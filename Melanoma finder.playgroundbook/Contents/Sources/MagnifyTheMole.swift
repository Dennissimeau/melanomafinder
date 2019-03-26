//
//  See LICENSE folder for this template’s licensing information.
//
//  Abstract:
//  Provides supporting functions for setting up a live view.
//

import UIKit
import Foundation
import PlaygroundSupport

public class MagnifyTheMole: LiveViewController {
    
    private var magnifierView: MagnifierView?
    var isMagnifierEnabled = false
    
    
    public override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //Gets called when the user touches the screen
    override public func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        //Guard to check if the user enabled the magnify function in the code.
        guard isMagnifierEnabled else { return }
        
        let point = touches.first?.location(in: self.view)
        if magnifierView == nil {
            magnifierView = MagnifierView.init(frame: CGRect(x: 0, y: 0, width: 150, height: 150))
            magnifierView?.viewToMagnify = self.view
            magnifierView?.setTouchPoint(pt: point!)
            self.view.addSubview(magnifierView!)
        }
    }
    
    //Gets called when the user removes their finger from the screen.
    override public func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        guard isMagnifierEnabled else { return }
        
        if magnifierView != nil {
            magnifierView?.removeFromSuperview()
            magnifierView = nil
        }
    }
    
    //Gets the location of the finger when it moved.
    override public func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
         guard isMagnifierEnabled else { return }
        
        let point = touches.first?.location(in: self.view)
        magnifierView?.setTouchPoint(pt: point!)
        magnifierView?.setNeedsDisplay()
    }
    
    
     override public func receive(_ message: PlaygroundValue) {
//        Uncomment the following to be able to receive messages from the Contents.swift playground page. You will need to define the type of your incoming object and then perform any actions with it.

        guard case .data(let messageData) = message else { return }
        do { if let incomingObject = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(messageData) as? Bool {

                isMagnifierEnabled = incomingObject

            }
        } catch let error { fatalError("\(error) Unable to receive the message from the Playground page") }
        
    }
}


