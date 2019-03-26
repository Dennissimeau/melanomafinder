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

let pass = "Wonderful! Drag an drop is working. Tap a photo, hold your finger for a second and drag the image on Menno. To get more space, dismiss this alert. After exploring, click the ✅, and [*go to the next page*](@next)."

func dragAndDrop() {
    try! sendValue(.data(try NSKeyedArchiver.archivedData(withRootObject: true, requiringSecureCoding: true)))
    
    PlaygroundPage.current.assessmentStatus = .pass(
        message: pass
    )
}


//#-end-hidden-code
/*:
 # Human meets machine
 
 With the knowledge about how melanomas look, you can now keep an eye on yourself. With iPhone and iPad becoming smarter and more powerful than we could ever imagine, its technology could assist in diagnosis.
 
 With the processing power we have nowadays, our computers can help us in recognizing melanomas. This recognition can be achieved by using *Machine Learning*. Using CreateML (on Xcode Playgrounds) a model was trained on a large, publicly available, dataset of benign and malignant birthmarks. The used dataset is called the *International Skin Imaging Collaboration* (ISIC) Archive.
 
 In the view on the right, Menno the Mole is trained to recognize Melanomas. Using [*transfer learning*](glossary://transfer%20learning), Menno learned the features he should look for when classifying a mole as benign or malignant.
 
  + Callout(Drag and drop): Underneath Menno, there are a few images present in a horizontal scrollview. We can drag and drop these on him and he will will classify them. To make this possible, implement `dragAndDrop()`.
 */
//#-hidden-code
//#-code-completion(everything, hide)
//#-code-completion(identifier, show, dragAndDrop())
//#-end-hidden-code
//#-editable-code

//#-end-editable-code
/*:
 ## References
 - ISIC Archive, consulted and downloaded March 2019. [https://www.isic-archive.com/](https://www.isic-archive.com/)
 - Wikipedia, Transfer learning, consulted March 2019. [Wikipedia](https://en.wikipedia.org/wiki/Transfer_learning)
 */

