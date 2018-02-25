//
//  ESMainPresenter.swift
//  EventSourceApp
//
//  Created by SheveleR on 24/02/2018.
//  Copyright © 2018 SheveleR. All rights reserved.
//

import Foundation

struct ESCellContent {
    var title: String
    var value: String
    
    init(_ title: String, _ value: String) {
        self.title = title
        self.value = value
    }
}

class ESMainPresenter: ESMainPresnterProtocol {
    var view: ESMainViewProtocol!
    var model: ESMainModelProtocol!
    var content: Array<ESCellContent> = Array<ESCellContent>()
    
    required init(_ viewControlelr: ESMainViewProtocol, _ model: ESMainModelProtocol) {
        self.view = viewControlelr
        self.model = model
        self.addDefaultCells()
    }
    
    func addDefaultCells() {
        content.append(ESCellContent.init("Temperature", ""))
        content.append(ESCellContent.init("Pressure", ""))
        content.append(ESCellContent.init("Serial", ""))
        content.append(ESCellContent.init("PM1", ""))
        content.append(ESCellContent.init("Location", ""))
        content.append(ESCellContent.init("Batt. Voltage", ""))
        view.showDefaultCells(content)
    }
    
    func createEventSource() {
        model.createEventSource()
        model.addListner { (measurement) in
            DispatchQueue.main.asyncAfter(deadline: .now() + 3.0, execute: {
                self.createContent(measurement)
            })
        }
    }
    
    func createContent(_ measurement: String) {
        var newString: String
        var unitName: String = String()
        var stringWithoutLastSquareBrackets: String = String()
        newString = measurement
        
        newString.removeFirst()
        newString.removeLast()
        
        let stringArray = measurement.components(separatedBy: "{")
        for elem in 0...stringArray.count - 1 {
            if elem > 0 {
                let nameOfMeasure = String(stringArray[elem].replacingOccurrences(of: "\"", with: "").split(separator: ",")[0].split(separator: ":")[1])
                let unit = stringArray[elem].replacingOccurrences(of: "\"", with: "").split(separator: ",")[1].split(separator: ":")
                if unit[0].contains("unit") {
                    unitName = String(unit[1])
                }
                else {
                    unitName = ""
                }
                if stringArray[elem].contains(nameOfMeasure) {
                    let string = stringArray[elem]
                    let stringWithoutFirstSquareBrackets = string.components(separatedBy: "[[")
                    if stringWithoutFirstSquareBrackets.count > 1 {
                        if nameOfMeasure.contains("Location") {
                          stringWithoutLastSquareBrackets = stringWithoutFirstSquareBrackets[1].components(separatedBy: "]]]")[0]
                        }
                        else {
                             stringWithoutLastSquareBrackets = stringWithoutFirstSquareBrackets[1].components(separatedBy: "]]")[0]
                        }
                        let numericSet = "0123456789,.-abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
                        let filteredCharacters = stringWithoutLastSquareBrackets.characters.filter {
                            return numericSet.contains($0)
                        }
                        let clearString = String(filteredCharacters)
                        let clearStringArray = clearString.components(separatedBy: ",")
                        if !unitName.isEmpty && !nameOfMeasure.contains("Location") {
                          let adapterContent = ESCellContent.init(nameOfMeasure, formatStringWith2DecimalPlaces(clearStringArray.last!) + " \(unitName)")
                            view.updateContent(adapterContent)
                        }
                        else if nameOfMeasure.contains("Location") {
                            let adapterContent = ESCellContent.init(nameOfMeasure, "\(formatStringWith2DecimalPlaces(clearStringArray[clearStringArray.count - 2])),\(formatStringWith2DecimalPlaces(clearStringArray[clearStringArray.count - 1]))")
                             view.updateContent(adapterContent)
                        }
                        else {
                            let adapterContent = ESCellContent.init(nameOfMeasure, formatStringWith2DecimalPlaces(clearStringArray.last!))
                            view.updateContent(adapterContent)
                        }
                    }
                }
            }
        }
    }
    
    func formatStringWith2DecimalPlaces(_ string: String) -> String {
        if string.contains(".") {
            let float = Float(string)
            let formattedString = String(format: "%.2f", float!)
            return formattedString
        }
        return string
    }
}
