
import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        let wv = UIWebView(frame: UIScreen.main.applicationFrame)
        view = wv
        wv.loadHTMLString("_<p>_<p>_<p><button onclick=\"webkit.messageHandlers.hello.postMessage({'message':'foo'})\">Click me</button>", baseURL: nil)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            installHandler(self.view as! UIWebView, "hello")
        }
    }
}

