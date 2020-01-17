//
//  HomeViewController.swift
//  AskQueue
//
//  Created by Rafael Galdino on 16/01/20.
//  Copyright © 2020 Rafael Galdino. All rights reserved.
//

import Foundation
import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupHome()
    }

    func setupHome() {
        self.view.backgroundColor = UIColor.init(red: 240/255,
                                                 green: 240/255,
                                                 blue: 240/255,
                                                 alpha: 1)
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationBar.isTranslucent = false
        self.title = "AskQueue"
        setupRightButton()
    }
    func setupRightButton(){
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add,
                                                                 target: self,
                                                                 action: #selector(createQueue))
        self.navigationItem.rightBarButtonItem?.setTitlePositionAdjustment(.init(horizontal: 10, vertical: 20),
                                                                           for: .default)
    }
    @objc func createQueue() {
        print("created Queue")
    }
}
