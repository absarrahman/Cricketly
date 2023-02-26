//
//  WKViewController.swift
//  Cricketly
//
//  Created by BJIT  on 26/2/23.
//

import UIKit
import WebKit

class WKViewController: UIViewController {
    
    @IBOutlet weak var webView: WKWebView!
    
    var urlString = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        webView.allowsBackForwardNavigationGestures = true
        webView.load(URLRequest(url: URL(string: urlString)!))
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
