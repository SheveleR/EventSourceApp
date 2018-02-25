//
//  EventSourceAppTests.swift
//  EventSourceAppTests
//
//  Created by SheveleR on 24/02/2018.
//  Copyright © 2018 SheveleR. All rights reserved.
//

import XCTest
@testable import EventSourceApp

class EventSourceAppTests: XCTestCase {
    var mainVC: ESMainVC!
    var showDefaultCellsCalled: Bool = false
    var content: Array<ESCellContent> = Array<ESCellContent>()
    var defaultCountOfViews: Int = 6
    
    override func setUp() {
        super.setUp()
        mainVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ESMainVC") as! ESMainVC
        content.append(ESCellContent.init("Temperature", ""))
        content.append(ESCellContent.init("Pressure", ""))
        content.append(ESCellContent.init("Serial", ""))
        content.append(ESCellContent.init("PM1", ""))
        content.append(ESCellContent.init("Location", ""))
        content.append(ESCellContent.init("Batt. Voltage", ""))
    }
    
    func testDefaultInitVC() {
        let _ = mainVC.view
        
        let countOfViews = mainVC.stackView.subviews.count
        
        XCTAssert(countOfViews == defaultCountOfViews, "DefaultCellsOn")
        XCTAssert(mainVC.presenter != nil, "Presenter ON")
    }
}
