//#-hidden-code
//
//  See LICENSE folder for this template’s licensing information.
//
//  Abstract:
//  The Swift file containing the source code edited by the user of this playground book.
//


//Messaging from Page to Live View:
import Foundation
import PlaygroundSupport

let page = PlaygroundPage.current
let proxy = page.liveView as? PlaygroundRemoteLiveViewProxy

let pass = "You're great! The camera is now working. Tap the *Take Photo* button, zoom in on your mole so it fills most of the screen and take a photo. To get more space, dismiss this alert. After exploring, click the ✅, and [*go to the last page*](@next)."

func enableCamera() {
    try! sendValue(.data(try NSKeyedArchiver.archivedData(withRootObject: true, requiringSecureCoding: true)))
    
    PlaygroundPage.current.assessmentStatus = .pass(
        message: pass
    )
}

//#-end-hidden-code
/*:
 # Classify your own birthmarks
 
 * Important:
 This app is NOT a medical device and is made for experimental purposes to show technical possibilities. It should in **no way** be used for self-diagnosis. The ML model is not clinically accurate enough and not validated by professionals. This is plagroundbook is a proof-of-concept and could produce false positives and negatives. Always consult a doctor when in doubt of skin cancer (or any other disease).
 
 Because the affordance of our modern devices, compared with expensive medical hardware, it has become possible for people to examine theirselves with their iPhone or iPad. In this playground page an **experimental example** is demonstrated on how the iPad can be used to detect melanomas.

 * Note:
 In order to make detection as accurate as possible, take a photo of a larger mole. Also use a well-lit room and crop (use zoom) the image as close as possible while retaining sharpness. The model will also classify other objects as malignant or benign, and thus app makes no sense outside of the domain of moles. Below, implement the `enableCamera()` function to start.
 */
//#-hidden-code
//#-code-completion(everything, hide)
//#-code-completion(identifier, show, enableCamera())
//#-end-hidden-code
//#-editable-code

//#-end-editable-code

