//
//  MagnifierView.swift
//  LiveViewTestApp
//
//  Created by Dennis Vermeulen on 19/03/2019.
//

import UIKit

public class MagnifierView: UIView {

    var viewToMagnify: UIView!
    var touchPoint: CGPoint!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    func commonInit()
    {
        self.layer.borderColor = UIColor.lightGray.cgColor
        self.layer.borderWidth = 3
        self.layer.cornerRadius = 50
        self.layer.masksToBounds = true
    }
    
    func setTouchPoint(pt: CGPoint) {
        touchPoint = pt
        
        //The magnifier is put 150 points above the touch area, to not interfere capturing the view of itself and the give the user clear view without their fingers being in the way.
        
        self.center = CGPoint(x: pt.x, y:pt.y - 150)
    }
    
    
    
    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
   public override func draw(_ rect: CGRect) {

    let context = UIGraphicsGetCurrentContext()
    
    //Shows what is right under the finger.
    context!.translateBy(x: 1 * (self.frame.size.width * 0.5), y: 1 * (self.frame.size.height * 0.5))
    context!.scaleBy(x: 1.5, y: 1.5) // 1.5 is the zoom scale
    
    //Sets the image in the view to the location of the finger
    context!.translateBy(x: -1 * (touchPoint.x), y: -1 * (touchPoint.y))
    self.viewToMagnify.layer.render(in: context!)
    }
 

}
