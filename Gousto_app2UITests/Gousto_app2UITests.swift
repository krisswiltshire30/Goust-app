//
//  Gousto_app2UITests.swift
//  Gousto_app2UITests
//
//  Created by Kriss Wiltshire on 19/01/2020.
//  Copyright © 2020 Kriss Wiltshire. All rights reserved.
//

import XCTest

class Gousto_app2UITests: XCTestCase {

    override func setUp() {
        continueAfterFailure = false
        XCUIApplication().launch()
    }
    
        func test_DirectsToDetailsPageOnTap() {
            let app = XCUIApplication()
            let title = app.tables.cells["Borsao Macabeo, £6.95"].children(matching: .image).element
            let titleElement = app.staticTexts["detailTitle"]
            let descriptionElement = app.staticTexts["detailDescription"]
            let sizeElement = app.staticTexts["detailSize"]
            let priceElement = app.staticTexts["detailPrice"]
            let allergyElement = app.staticTexts["detailAllergy"]
            title.tap()
            XCTAssertTrue(titleElement.exists)
            XCTAssertTrue(descriptionElement.exists)
            XCTAssertTrue(sizeElement.exists)
            XCTAssertTrue(priceElement.exists)
            XCTAssertTrue(allergyElement.exists)
    }
    
    func test_RecievesTheCorrectSearchResults() {
        let app = XCUIApplication()
        let tableCell = app.tables.cells
        let searchBar = app.otherElements.containing(.image, identifier:"Gousto_logo").children(matching: .other).element.children(matching: .searchField)
        searchBar.element.tap()
        searchBar.element.typeText("Food")
        app/*@START_MENU_TOKEN@*/.keyboards.buttons["Search"]/*[[".keyboards.buttons[\"Search\"]",".buttons[\"Search\"]"],[[[-1,1],[-1,0]]],[1]]@END_MENU_TOKEN@*/.tap()
        sleep(2)
        XCTAssertTrue(tableCell.count == 1)
        XCTAssertTrue(tableCell["OLD SKU Superfood Bakery Spirit Lifter Cookies, £6.55"].exists)
    }
    
    func test_ReturnsToAllProducts() {
        let app = XCUIApplication()
        let totalProducts = 458
        let tableCell = app.tables.cells
        let searchBar = app.otherElements.containing(.image, identifier:"Gousto_logo").children(matching: .other).element.children(matching: .searchField)
        searchBar.element.tap()
        searchBar.element.typeText("Food")
        app/*@START_MENU_TOKEN@*/.keyboards.buttons["Search"]/*[[".keyboards.buttons[\"Search\"]",".buttons[\"Search\"]"],[[[-1,1],[-1,0]]],[1]]@END_MENU_TOKEN@*/.tap()
        sleep(1)
        searchBar.element.tap()
        app.searchFields.buttons["Clear text"].tap()
        sleep(1)
        XCTAssertTrue(tableCell.count == totalProducts)
        XCTAssertTrue(tableCell["Borsao Macabeo, £6.95"].exists)
        
    }
    
    func test_BackButtonReturnsToMainView() {
        let app = XCUIApplication()
        let descriptionElement = app.staticTexts["detailDescription"]
        XCTAssertTrue(descriptionElement.exists == false)
        app.tables.cells["Borsao Macabeo, £6.95"].images["placeholder"].tap()
        XCTAssertTrue(descriptionElement.exists)
        app.buttons["Back"].tap()
        XCTAssertTrue(descriptionElement.exists == false)
        XCTAssertTrue(app.tables.cells["Borsao Macabeo, £6.95"].exists)
    }
}
