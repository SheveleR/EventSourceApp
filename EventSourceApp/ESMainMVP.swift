//
//  ESMainMVP.swift
//  EventSourceApp
//
//  Created by SheveleR on 24/02/2018.
//  Copyright © 2018 SheveleR. All rights reserved.
//

import Foundation

protocol ESMainViewProtocol {
    func showDefaultCells(_ content: Array<ESCellContent>)
    func updateContent(_ contentElem: ESCellContent)
}

protocol ESMainPresnterProtocol {
    init(_ viewController: ESMainViewProtocol, _ model: ESMainModelProtocol)
    func createEventSource()
}

protocol ESMainModelProtocol {
    func createEventSource()
    func addListner(_ callback: @escaping (_ measurements: String) -> ())
}
