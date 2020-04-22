//
//  SeriesDecriptionViewController.swift
//  SuperMario
//
//  Created by Nazario Mariano on 4/22/20.
//  Copyright © 2020 Nazario Mariano. All rights reserved.
//

import UIKit
import WebKit

class SeriesDecriptionViewController: BaseViewController {
    
    let googleQueryURL = "https://www.google.com"
    
    fileprivate var webView = WKWebView(frame: .zero)
    fileprivate var progressView = UIProgressView(progressViewStyle: .default)
    
    var searchKey: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Series Description"
        
        addView(childView: webView, constraint: ConstraintValues())
        
        var indicatorConstraintVal = ConstraintValues()
        indicatorConstraintVal.bottom = nil
        
        webView.addObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress), options: .new, context: nil)
        
        progressView.progressTintColor = UIColor(named: "Yellow")
        progressView.progress = 0.5
        addView(childView: progressView, constraint: indicatorConstraintVal)
        
        let base = URL(string: googleQueryURL)!
        let query = URLQueryItem(name: "q", value: searchKey)
        let endPoint = Endpoint(base: base, path: "/search", queryItems: [query])
        
        webView.load(URLRequest(url: endPoint.url!))
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "estimatedProgress" {
            let progress = Float(webView.estimatedProgress)
            progressView.progress = progress
            if progress >= 1.0 {
                progressView.isHidden = true
            }
        }
    }
}
