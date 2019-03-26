//
//  See LICENSE folder for this template’s licensing information.
//
//  Abstract:
//  Provides supporting functions for setting up a live view.
//

import UIKit
import Foundation
import PlaygroundSupport


public class ScanYourself: LiveViewController, UINavigationControllerDelegate,  UIImagePickerControllerDelegate {
    
    
    let classifier = Classifier()
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var benignOrMalignantLabel: UILabel!
    var imagePicker: UIImagePickerController!
    @IBOutlet weak var takePhotoButton: UIButton!
    
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        takePhotoButton.isEnabled = false
        takePhotoButton.setTitleColor(#colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1), for: .disabled)
        takePhotoButton.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        
    }
    
    @IBAction func takePhoto(_ sender: UIButton) {
        imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .camera
        present(imagePicker,animated: true, completion: nil)
        
    }
    
    func performClassification(image: UIImage) {
        classifier.classifyImage(for: image, completionHandler: { success, error, result in
            guard error == nil else {
                self.benignOrMalignantLabel.text = "Not able to classify, with error \(error.debugDescription)"
                return
            }
            if success {
                self.benignOrMalignantLabel.text = result
            }
            
        })
    }
    
  
    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        
        if let image = info[.originalImage] as? UIImage {
            imageView.image = image
            performClassification(image: image)
        }
    }
    
    func changeButtonState(to isState:Bool) {
        takePhotoButton.isEnabled = isState
        takePhotoButton.backgroundColor = #colorLiteral(red: 0.7607843137, green: 0.337254902, blue: 0.0862745098, alpha: 1)
        benignOrMalignantLabel.text = "Let's make a photo."
    }
    
    override public func receive(_ message: PlaygroundValue) {
        
        guard case .data(let messageData) = message else { return }
        do { if let incomingObject = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(messageData) as? Bool {
            
            changeButtonState(to: incomingObject)
            
            }
        } catch let error { fatalError("\(error) Unable to receive the message from the Playground page") }
        
    }
}
