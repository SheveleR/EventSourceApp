//
//  ESMainContentCell.swift
//  EventSourceApp
//
//  Created by SheveleR on 24/02/2018.
//  Copyright © 2018 SheveleR. All rights reserved.
//

import Foundation
import UIKit

class ESMainContentCell: NibLoadingView {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    
    func initUI(_ desc: ESCellContent) {
        titleLabel.text = desc.title
        if desc.value.isEmpty {
            valueLabel.text = "Unknown Value"
        }
        else {
            valueLabel.text = desc.value
        }
    }
}
