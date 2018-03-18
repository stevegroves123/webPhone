//
//  ViewController.swift
//  weatherPhone
//
//  Created by steve groves on 15/03/2018.
//  Copyright © 2018 steve groves. All rights reserved.
//

import UIKit
import WebKit

class ViewController: UIViewController, UITextFieldDelegate, WKNavigationDelegate {
    
    //MARK: Globals
    let urlhttp:String = "http://"
    
    //MARK: Outlets
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var forwardButton: UIButton!
    @IBOutlet weak var urLTextBox: UITextField!
    @IBOutlet weak var homeButton: UIButton!
    
    //MARK: Actions
    @IBAction func backButtonAction(_ sender: UIButton) {
        if webView.canGoBack {
            webView.goBack()
        }
    }
    
    @IBAction func forwardButtonAction(_ sender: UIButton) {
        if webView.canGoForward {
            webView.goForward()
        }
    }
    
    @IBAction func homeButtonAction(_ sender: UIButton) {
        let urlString:String = "www.apple.com/uk"
        let url:URL = URL(string: urlhttp+urlString)!
        let urlRequest:URLRequest = URLRequest(url: url)
        webView.load(urlRequest)
        
        urLTextBox.text = urlString
    }
    
    //MARK: Overrides
    override func viewDidLoad() {
        super.viewDidLoad()
        webView.navigationDelegate = self
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear( animated )
        let urlString:String = "www.apple.com/uk"
        let url:URL = URL(string: urlhttp+urlString)!
        let urlRequest:URLRequest = URLRequest(url: url)
        webView.load(urlRequest)
        
        urLTextBox.text = urlString
    }

    //MARK: func's
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        var urlString:String = urLTextBox.text!
        if (urLTextBox.text?.starts(with: "http://"))! || (urLTextBox.text?.starts(with: "https://"))!{
            urlString = urLTextBox.text!
        } else {
            urlString = (urlhttp + urLTextBox.text!)
        }
        let url:URL = URL(string: urlString)!
        let urlRequest:URLRequest = URLRequest(url: url)
        webView.load(urlRequest)
        
        textField.resignFirstResponder()
        return true
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        backButton.isEnabled = webView.canGoBack
        forwardButton.isEnabled = webView.canGoForward
        
        urLTextBox.text = webView.url?.absoluteString
    }
}
