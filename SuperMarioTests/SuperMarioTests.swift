//
//  SuperMarioTests.swift
//  SuperMarioTests
//
//  Created by Nazario Mariano on 4/22/20.
//  Copyright © 2020 Nazario Mariano. All rights reserved.
//

import XCTest
@testable import SuperMario

class SuperMarioTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testWhenImagePreviewActionCalled_Should_NavigateToImageViewer() {
        let detailViews = MockDetailNavigation()
        let rootVC = RootViewController()
        let _ = rootVC.view
        rootVC.detailViews = detailViews
        
        rootVC.push(to: .render(.characterPreview("")))
        
        XCTAssert(detailViews.willNavigateToImagePreview)
    }

    func testWhenImagePreviewActionCalled_ShouldNot_NavigateToWebView() {
        let detailViews = MockDetailNavigation()
        let rootVC = RootViewController()
        let _ = rootVC.view
        rootVC.detailViews = detailViews
        
        rootVC.push(to: .render(.characterPreview("")))
        
        XCTAssert(!detailViews.willNavigateToWebPreview)
    }
    
    func testWhenWebViewActionCalled_Should_NavigateToWebView() {
        let detailViews = MockDetailNavigation()
        let rootVC = RootViewController()
        let _ = rootVC.view
        rootVC.detailViews = detailViews
        
        rootVC.push(to: .render(.webSearch("")))
        
        XCTAssert(detailViews.willNavigateToWebPreview)
    }
    
    func testWhenWebViewActionCalled_ShouldNot_NavigateToImageViewer() {
        let detailViews = MockDetailNavigation()
        let rootVC = RootViewController()
        let _ = rootVC.view
        rootVC.detailViews = detailViews
        
        rootVC.push(to: .render(.webSearch("")))
        
        XCTAssert(!detailViews.willNavigateToImagePreview)
    }
    
    // MARK: RootViewController State
    
    func testWhenAPIRequestFails_ShouldBe_NoConnectionState() {
        
        let fails = true
        
        let rootVC = RootViewController()
        
        let fakeRequest = MockRequests()
        fakeRequest.mockSuccess = !fails
        let mockVM = RootViewModel(request: fakeRequest )
        rootVC.viewModel = mockVM
        let _ = rootVC.view

        XCTAssert(.noConnection("") == rootVC.state)
    }
    
    func testWhenAPIRequestSucceeds_ShouldNOTBe_NoConnectionState() {
        
        let fails = false
        
        let rootVC = RootViewController()
        
        let fakeRequest = MockRequests()
        fakeRequest.mockSuccess = !fails
        let mockVM = RootViewModel(request: fakeRequest )
        rootVC.viewModel = mockVM
        let _ = rootVC.view
        
        XCTAssertFalse(.noConnection("") == rootVC.state)
    }
}
