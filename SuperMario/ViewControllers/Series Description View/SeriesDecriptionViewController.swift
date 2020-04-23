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
    
    /// Inbound search keyword
    var searchKey: String!
    
    fileprivate let googleQueryURL = "https://www.google.com"
    fileprivate var webView = WKWebView(frame: .zero)
    fileprivate var progressView = UIProgressView(progressViewStyle: .default)
    fileprivate var observer: NSKeyValueObservation!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Series Description"
        
        configureViews()
        loadResource()

    }
    
    /// Setup the view
    fileprivate func configureViews() {
        
        addView(childView: webView, constraint: ConstraintValues())
        
        var indicatorConstraintVal = ConstraintValues()
        indicatorConstraintVal.bottom = nil
        
        progressView.progressTintColor = UIColor(named: "Yellow")
        
        progressView.progress = 0
        
        addObserver()
        
        addView(childView: progressView, constraint: indicatorConstraintVal)
    }
    
    /// A method to load a google search on a webview
    fileprivate func loadResource() {
        let base = URL(string: googleQueryURL)!
        let query = URLQueryItem(name: "q", value: searchKey)
        let endPoint = Endpoint(base: base, path: "/search", queryItems: [query])
        
        webView.load(URLRequest(url: endPoint.url!))
    }
    
    /// Observe the web view progress
    fileprivate func addObserver() {
        observer = webView.observe(\.estimatedProgress, options: [.new]) { [weak self] (_, change)  in
            let progress = Float(change.newValue!)
            self?.progressView.progress = progress
            if progress >= 1.0 {
                self?.progressView.isHidden = true
            }
        }
    }
}
