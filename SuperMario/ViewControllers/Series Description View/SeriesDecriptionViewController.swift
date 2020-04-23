//
//  SeriesDecriptionViewController.swift
//  SuperMario
//
//  Created by Nazario Mariano on 4/22/20.
//  Copyright © 2020 Nazario Mariano. All rights reserved.
//

import UIKit
import WebKit

/**
 On this screen the web view is initialized with the google search url.
 When the url is loaded a progress indicator is displayed to indicate the
 current progress of loading the url.
 */
class SeriesDecriptionViewController: BaseViewController {
    
    var searchKey: String!
    
    fileprivate let googleQueryURL = "https://www.google.com"
    fileprivate var webView = WKWebView(frame: .zero)
    fileprivate var progressView = UIProgressView(progressViewStyle: .default)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Series Description"
        
        configureViews()
        loadResource()
    }
    
    /// Observe the web view progress
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "estimatedProgress" {
            let progress = Float(webView.estimatedProgress)
            progressView.progress = progress
            if progress >= 1.0 {
                progressView.isHidden = true
            }
        }
    }
    
    /// Setup the view
    fileprivate func configureViews() {
        
        addView(childView: webView, constraint: ConstraintValues())
        
        var indicatorConstraintVal = ConstraintValues()
        indicatorConstraintVal.bottom = nil
        
        webView.addObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress), options: .new, context: nil)
        
        progressView.progressTintColor = UIColor(named: "Yellow")
        
        progressView.progress = 0.5
        
        addView(childView: progressView, constraint: indicatorConstraintVal)
    }
    
    /// A method to load a google search on a webview
    fileprivate func loadResource() {
        let base = URL(string: googleQueryURL)!
        let query = URLQueryItem(name: "q", value: searchKey)
        let endPoint = Endpoint(base: base, path: "/search", queryItems: [query])
        
        webView.load(URLRequest(url: endPoint.url!))
    }
}
