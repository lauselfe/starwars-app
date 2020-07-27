//
//  WikiViewController.swift
//  starwars
//
//  Created by Master on 17/7/20.
//  Copyright © 2020 Master. All rights reserved.
//

import UIKit
import WebKit

class WikiViewController: UIViewController, WKNavigationDelegate, WKUIDelegate {

    @IBOutlet weak var browser: WKWebView!
    
    @IBOutlet weak var activityView: UIActivityIndicatorView!
    
    var model : StarWarsCharacter
    
    init(model : StarWarsCharacter) {
        self.model = model
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //patron singleton (solo hay una instancia en toda la aplicacion)
    let nc = NotificationCenter.default
    
    func startObserving() {
        nc.addObserver(forName: CharacterDidChangeNotification, object: nil, queue: nil) { (n : Notification) in
            let info = n.userInfo!
            
            let char = info[CharacterKey] as? StarWarsCharacter
            
            self.model = char!
            
            self.syncModelWithView()
            
            
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        startObserving()
        syncModelWithView()
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        nc.removeObserver(self)
        
    }
    
    func syncModelWithView(){
        //asignar el delegado
        browser.navigationDelegate = self
        
        activityView.startAnimating()
        
        browser.load(URLRequest(url: model.url))
        
        
        
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        activityView.stopAnimating()
        activityView.isHidden = true
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        
        if navigationAction.navigationType == .linkActivated || navigationAction.navigationType == .formSubmitted {
            decisionHandler(.cancel)
        }else{
            decisionHandler(.allow)
        }
    }
  

}
