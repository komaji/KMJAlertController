//
//  KMJAlertControllerDemoUITests.swift
//  KMJAlertControllerDemoUITests
//
//  Created by KojimaTatsuya on 2016/11/01.
//  Copyright © 2016年 komaji. All rights reserved.
//

import XCTest

class KMJAlertControllerDemoUITests: XCTestCase {
    
    let app = XCUIApplication()

    override func setUp() {
        super.setUp()
        
        continueAfterFailure = false
        XCUIApplication().launch()
   }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testShowAlert() {
        app.buttons["Alert"].tap()
        XCTAssertTrue(app.alerts["Alert Title"].staticTexts["Alert Message"].exists)
        app.alerts["Alert Title"].buttons["Cancel"].tap()
        
        app.buttons["Alert"].tap()
        app.alerts["Alert Title"].buttons["Destructive"].tap()

        app.buttons["Alert"].tap()
        app.alerts["Alert Title"].buttons["Default0"].tap()

        app.buttons["Alert"].tap()
        app.alerts["Alert Title"].buttons["Default1"].tap()
    }
    
    func testShowActionSheet() {
        app.buttons["Action Sheet"].tap()
        XCTAssertTrue(app.sheets["Action Sheet Title"].staticTexts["Action Sheet Message"].exists)

        if UIDevice.current.userInterfaceIdiom == .phone {
            app.sheets["Action Sheet Title"].buttons["Cancel"].tap()

            app.buttons["Action Sheet"].tap()
        } else if UIDevice.current.userInterfaceIdiom == .pad {
            XCTAssertFalse(app.popovers["Action Sheet Title"].buttons["Cancel"].exists)
        }
        
        app.sheets["Action Sheet Title"].buttons["Destructive"].tap()
        
        app.buttons["Action Sheet"].tap()
        app.sheets["Action Sheet Title"].buttons["Default0"].tap()
        
        app.buttons["Action Sheet"].tap()
        app.sheets["Action Sheet Title"].buttons["Default1"].tap()
    }
    
}
