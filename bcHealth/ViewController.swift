import UIKit
import WebKit

class ViewController: UIViewController, WKUIDelegate, WKNavigationDelegate {

    var webView: WKWebView!
    
    @IBOutlet weak var importButton: UIButton!
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        print("observeValue called with keyPath \(keyPath!)")
        if keyPath == "loading" {
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        webView = WKWebView(frame: CGRect( x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height - 200 ), configuration: WKWebViewConfiguration() )
        self.view.addSubview(webView)
        let myURL = URL(string: "https://my.bikecitizens.net")
        let myRequest = URLRequest(url: myURL!)
        webView.addObserver(self, forKeyPath: #keyPath(WKWebView.isLoading), options: .new, context: nil)
        
        webView.load(myRequest)
        importButton.addTarget(self, action: #selector(importPressed), for: .touchUpInside)
        
    }
    
    func importPressed () {
        webView.evaluateJavaScript("document.documentElement.outerHTML.toString()", completionHandler:
            { (html: Any?, error: Error?) in print(html!) })
    }

}
