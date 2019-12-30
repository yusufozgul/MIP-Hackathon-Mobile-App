//
//  MoovitVC.swift
//  mipHackathon
//
//  Created by Yusuf Özgül on 29.12.2019.
//  Copyright © 2019 Yusuf Özgül. All rights reserved.
//

import UIKit
import WebKit

class MoovitVC: UIViewController, WKNavigationDelegate {

    var webView: WKWebView!
    var url: String = "https://moovitapp.com"
    override func viewDidLoad() {
        super.viewDidLoad()

        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
        
        if let url = URL(string: url)
        {
            webView.load(URLRequest(url: url))
            webView.allowsBackForwardNavigationGestures = true
        }
        
    }

}
