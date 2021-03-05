//
//  tamboonUITests.swift
//  tamboonUITests
//
//  Created by Kittisak Phetrungnapha on 5/3/2564 BE.
//

import XCTest

final class tamboonUITests: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    override func tearDownWithError() throws {}

    func testDonate() throws {
        let app = XCUIApplication()
        app.launch()
        
        app.cells.element(boundBy: 0).tap()
        
        let amountTextField = app.alerts.textFields["Amount in THB"]
        XCTAssertTrue(amountTextField.exists)
        
        amountTextField.typeText("20")
        app.alerts.buttons["Confirm"].tap()
        XCTAssertFalse(amountTextField.exists)
        
        let cardNumberTextField = app.scrollViews.children(matching: .textField).element(boundBy: 0)
        cardNumberTextField.tap()
        cardNumberTextField.typeText("4111111111111111")
        
        let nameOnCardTextField = app.scrollViews.children(matching: .textField).element(boundBy: 1)
        nameOnCardTextField.tap()
        nameOnCardTextField.typeText("Kittisak Phetrungnapha")
        
        let expiryTextField = app.scrollViews.children(matching: .textField).element(boundBy: 2)
        expiryTextField.tap()
        expiryTextField.typeText("12/21")
        
        let cvvTextField = app.scrollViews.children(matching: .textField).element(boundBy: 3)
        cvvTextField.tap()
        cvvTextField.typeText("111")
        
        let payButton = app/*@START_MENU_TOKEN@*/.scrollViews.buttons["Pay"]/*[[".scrollViews.buttons[\"Pay\"]",".buttons[\"Pay\"]"],[[[-1,1],[-1,0]]],[1]]@END_MENU_TOKEN@*/
        XCTAssertTrue(payButton.isEnabled)
        
        payButton.tap()
        
        let okButton = app.alerts.buttons["OK"]
        XCTAssertTrue(okButton.waitForExistence(timeout: 3))
        
        okButton.tap()
        XCTAssertEqual(app.alerts.count, 0)
    }
}
