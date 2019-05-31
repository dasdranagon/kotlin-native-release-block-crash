import UIKit
import app

class ViewController: UIViewController {
    var customCoreDomain: Core!
    var firebaseCoreDomain: Core!
    
    @IBOutlet weak var listenerButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCustomDomain()
        configureFirebaseDomain()
    }
    
    private func configureCustomDomain() {
        let factory = CustomFactory()
        customCoreDomain = Core(factory: factory)
        customCoreDomain.requestListener()
    }
    
    private func configureFirebaseDomain() {
        let factory = FirebaseFactory()
        firebaseCoreDomain = Core(factory: factory)
        firebaseCoreDomain.requestListener()
    }
    
    @IBAction func tapListenerButton(_ sender: Any) {
        customCoreDomain.releaseListener()
    }
    
    @IBAction func tapFirebaseListenerButton(_ sender: Any) {
        firebaseCoreDomain.releaseListener()
    }
}


