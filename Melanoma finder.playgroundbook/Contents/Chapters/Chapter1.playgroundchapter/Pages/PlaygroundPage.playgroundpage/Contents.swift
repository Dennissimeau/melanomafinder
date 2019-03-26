//#-hidden-code
//
//  See LICENSE folder for this template’s licensing information.
//
//  Abstract:
//  The Swift file containing the source code edited by the user of this playground book.
//


import Foundation
import PlaygroundSupport

let page = PlaygroundPage.current
let proxy = page.liveView as? PlaygroundRemoteLiveViewProxy

let pass = "Nice! You implemented the magnify function. Take a closer look to the birthmark and its characteristics. Drag your finger accross the skin to magnify. To get more space, dismiss this alert. After exploring, click the ✅, and [*go to the next page*](@next)."

func enableMagnifier() {
    try! sendValue(.data(try NSKeyedArchiver.archivedData(withRootObject: true, requiringSecureCoding: true)))
    
    PlaygroundPage.current.assessmentStatus = .pass(
        message: pass
    )
}

//#-end-hidden-code
/*:
 # Taking a look
 
 Exposure to UV rays from the sun or a tanning bed increases the risk of skin cancer. In fact, any change in skin color after UV exposure, like having a summer tan, is a sign of injury and not of health. Over time this exposure can cause cancers like melanomas, which is cancer of melanin pigment containing cells.
 
 More than 40% of the melanomas are found by the patients themselves. To become familiar with the harmless moles, freckles and spots on the skin, self examination is key, because early detection of skin cancer leads to better outcomes.
 
 + Callout(Take a look): Let's start with taking a close look to some skin and a mole. Implement the `enableMagnifier()` function to have a better look at the skin.
 
 */
//#-hidden-code
//#-code-completion(everything, hide)
//#-code-completion(identifier, show, enableMagnifier())
//#-end-hidden-code
//#-editable-code

//#-end-editable-code
/*:
 ## References
 - CDC, What is skin cancer?, consulted March 2019. [CDC](https://www.cdc.gov/cancer/skin/basic_info/what-is-skin-cancer.htm)
 - Wikipedia, Melanoma, consulted March 2019. [Wikipedia](https://en.wikipedia.org/wiki/Melanoma)
 */




