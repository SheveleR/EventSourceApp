//
//  ViewController.swift
//  EventSourceApp
//
//  Created by SheveleR on 24/02/2018.
//  Copyright © 2018 SheveleR. All rights reserved.
//

import UIKit

class ESMainVC: UIViewController, ESMainViewProtocol {
    var presenter: ESMainPresnterProtocol!

    @IBOutlet weak var stackView: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initBack()
        presenter.createEventSource()
    }
    
    func initBack() {
        presenter = ESMainPresenter.init(self, ESMainModel())
    }
    
    func showDefaultCells(_ content: Array<ESCellContent>) {
        for elem in content {
            let cell = ESMainContentCell.init(frame: CGRect.init(x: 0.0, y: 0.0, width: UIScreen.main.bounds.width, height: 60.0))
            cell.initUI(elem)
            stackView.addArrangedSubview(cell)
        }
    }
    
    func updateContent(_ contentElem: ESCellContent) {
        for view in stackView.subviews as! [ESMainContentCell] {
            if contentElem.title.contains(view.titleLabel.text!) {
                view.valueLabel.text = contentElem.value
            }
        }
    }
}

