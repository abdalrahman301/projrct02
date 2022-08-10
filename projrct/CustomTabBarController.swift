
import UIKit
class CustomTabBarController : UITabBarController {
    
    @IBInspectable var initialIndex: Int = 1
    override func viewDidLoad() {
        super.viewDidLoad()
        selectedIndex = initialIndex
    }
    
}
