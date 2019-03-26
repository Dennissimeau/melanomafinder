//
//  Classifier.swift
//  Playgrounds Author Template Extension
//
//  Created by Dennis Vermeulen on 22/03/2019.
//

import Foundation
import CoreML
import Vision
import UIKit

public class Classifier {
    
    var isAbleToClassify: Bool
    var isEmpty: Bool
    var result: String?
    
    init() {
        isAbleToClassify = false
        isEmpty = true
    }
    
    //Image analysis request that gets calculated after first use using the create ML model.
    lazy private var classRequest: VNCoreMLRequest = {
        guard let model = try? VNCoreMLModel(for: ISICSkinModel().model) else {
            fatalError("Couldn't load CoreMLModel")
        }
        let request = VNCoreMLRequest(model: model, completionHandler: { [weak self] request, error in
            self?.processClassifications(for: request, error: error)
        })
        request.imageCropAndScaleOption = .centerCrop
        return request
    }()
    
    
    //Public method for VC to call for CoreML and with completion handler to return the result
    func classifyImage(for image: UIImage, completionHandler: @escaping (Bool, Error?, String?)->()) {
        
        let orientation = CGImagePropertyOrientation(rawValue: UInt32(image.imageOrientation.rawValue))
        guard let ciImage = CIImage(image: image) else {
            fatalError("Unable to create \(CIImage.self) from \(image).")
        }
        DispatchQueue.main.async {
            let handler = VNImageRequestHandler(ciImage: ciImage, orientation: orientation!)
            do {
                try handler.perform([self.classRequest])
                DispatchQueue.main.async {
                    completionHandler(true, nil, self.result)
                }
            } catch {
                completionHandler(false, error, nil)
                fatalError(error.localizedDescription)
            }
        }
    }
    
    //Gets the classification from request and processes it to a string which is put into the var result
    private func processClassifications(for request: VNRequest, error: Error?) {
        DispatchQueue.main.async {
            guard let results = request.results else {
                self.isAbleToClassify = false
                return
            }
            
            let classifications = results as! [VNClassificationObservation]
            if classifications.isEmpty {
                self.isEmpty = true
            }
            else {
                
                let topClassifications = classifications.prefix(1)
                let descriptions = topClassifications.map { classification in
                    return  "It's \(classification.identifier) with \(String(format: "%.2f",classification.confidence)) confidence!"
                }
                self.result = descriptions.first
            }
        }
    }
}
