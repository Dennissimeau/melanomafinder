//
//  See LICENSE folder for this template’s licensing information.
//
//  Abstract:
//  Provides supporting functions for setting up a live view.
//

import UIKit
import Foundation
import CoreML
import Vision
import PlaygroundSupport

public class DragAndDropTheMole: LiveViewController, UIDropInteractionDelegate, UIDragInteractionDelegate {
   
    var classifier = Classifier()
    
    @IBOutlet weak var benignOrMalignantLabel: UILabel!
    @IBOutlet weak var destinationImageView: UIImageView!
    @IBOutlet weak var firstImageView: UIImageView!
    @IBOutlet weak var secondImageView: UIImageView!
    @IBOutlet weak var thirdImageView: UIImageView!
    
    
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        destinationImageView.addInteraction(UIDropInteraction(delegate: self))
        firstImageView.addInteraction(UIDragInteraction(delegate: self))
        secondImageView.addInteraction(UIDragInteraction(delegate: self))
        thirdImageView.addInteraction(UIDragInteraction(delegate: self))
        
        
    }
    
    func enableUserInteraction(isUserInteractionEnabled: Bool) {
        
        destinationImageView.isUserInteractionEnabled = isUserInteractionEnabled
        firstImageView.isUserInteractionEnabled = isUserInteractionEnabled
        secondImageView.isUserInteractionEnabled = isUserInteractionEnabled
        thirdImageView.isUserInteractionEnabled = isUserInteractionEnabled
    }
    //Checks which image is being dragged and returns that image.
    
    public func dragInteraction(_ interaction: UIDragInteraction, itemsForBeginning session: UIDragSession) -> [UIDragItem] {
        
        if interaction.view == firstImageView {
            guard let image = firstImageView.image else { return [] }
            let provider = NSItemProvider(object: image)
            let item = UIDragItem(itemProvider: provider)
            return [item]
        }
        else if interaction.view == secondImageView {
            guard let image = secondImageView.image else { return [] }
            let provider = NSItemProvider(object: image)
            let item = UIDragItem(itemProvider: provider)
            return [item]
        }
        else if interaction.view == thirdImageView {
            guard let image = thirdImageView.image else { return [] }
            let provider = NSItemProvider(object: image)
            let item = UIDragItem(itemProvider: provider)
            return [item]
        }
        return []
    }
    
    
    //Takes care of drop interection and then calls the Classifier class. The results are shown in the label after classification.
    public func dropInteraction(_ interaction: UIDropInteraction, performDrop session: UIDropSession) {
        
        self.benignOrMalignantLabel.text = "Classifying..."
        self.destinationImageView.image = #imageLiteral(resourceName: "dontknow")
        
        for dragItem in session.items {
            dragItem.itemProvider.loadObject(ofClass: UIImage.self, completionHandler: { object, error in
                
                guard error == nil else { fatalError("Failed loading dragged item") }
                guard let draggedImage = object as? UIImage else { return }
                
                DispatchQueue.main.async  {
                    if  self.destinationImageView.frame.contains(session.location(in: self.view)) {
                        
                        self.classifier.classifyImage(for: draggedImage, completionHandler: { success, error, result in
                            
                            guard error == nil else {
                                self.benignOrMalignantLabel.text = "Not able to classify, with error \(error.debugDescription)"
                                return
                            }
                            if success {
                                self.destinationImageView.image = #imageLiteral(resourceName: "doknow")
                                self.benignOrMalignantLabel.text = result
                            }
                        })
                    }
                }                
            })
        }
        
    }
    
    public func dropInteraction(_ interaction: UIDropInteraction, sessionDidUpdate session: UIDropSession) -> UIDropProposal {
        return UIDropProposal(operation: .copy)
    }
    
    public func dropInteraction(_ interaction: UIDropInteraction, canHandle session: UIDropSession) -> Bool {
        return session.canLoadObjects(ofClass: UIImage.self)
    }
    
    
    override public func receive(_ message: PlaygroundValue) {

                guard case .data(let messageData) = message else { return }
                do { if let incomingObject = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(messageData) as? Bool {
        
                        enableUserInteraction(isUserInteractionEnabled: incomingObject)
        
                    }
                } catch let error { fatalError("\(error) Unable to receive the message from the Playground page") }
        
    }
}
