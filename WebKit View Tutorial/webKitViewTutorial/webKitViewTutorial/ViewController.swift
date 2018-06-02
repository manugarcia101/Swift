//
//  ViewController.swift
//  webKitViewTutorial
//
//  Created by Macosx on 6/4/18.
//  Copyright © 2018 Macosx. All rights reserved.
//

import UIKit
import WebKit
import Foundation

class ViewController: UIViewController {
    
    var urlText: String? = "https://www.google.com"
    var definitiveText: String? = ""

    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var text: UITextField!
    @IBAction func search(_ sender: Any) {
        let txt = text.text
        let array : [String] = (txt?.components(separatedBy: " "))!
        for elements in array{
            definitiveText = definitiveText!+"+"+elements
        }
        if txt != nil {
            urlText = "https://www.google.es/search?q="+definitiveText!;
            viewDidLoad()
            text.text = ""
        }
        definitiveText = ""
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        if urlText != nil {
            let url = URL(string: urlText!)
            let request = URLRequest(url: url!)
            webView.load(request)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

