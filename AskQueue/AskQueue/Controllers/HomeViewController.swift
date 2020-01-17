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

    var msgLabel: UILabel?
    var codeInput: UITextField?
    var connectButton: UIButton?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupHome()
        setupLabel()
        setupTextField()
    }

    func setupHome() {
        self.view.backgroundColor = UIColor.init(red: 43/255,
                                                 green: 43/255,
                                                 blue: 43/255,
                                                 alpha: 1)
        self.navigationController?.navigationBar.prefersLargeTitles = true
//        self.navigationController?.navigationBar.isTranslucent = false
        self.title = "AskQueue"
        setupRightButton()
    }

    func setupRightButton() {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add,
                                                                 target: self,
                                                                 action: #selector(createQueue))
        self.navigationItem.rightBarButtonItem?.setTitlePositionAdjustment(.init(horizontal: 10, vertical: 20),
                                                                           for: .default)
        self.navigationController?.navigationBar.tintColor = UIColor.init(red: 44/255,
                                                                             green: 185/255,
                                                                             blue: 147/255,
                                                                             alpha: 1)
        self.navigationController?.navigationBar.largeTitleTextAttributes =
            [NSAttributedString.Key.foregroundColor: UIColor.white]
    }

    func setupLabel() {
        msgLabel = UILabel(frame: .zero)
        guard let label = msgLabel else {
            return
        }
        label.font = UIFont.systemFont(ofSize: 36, weight: UIFont.Weight.regular)
        label.text = "Insira abaixo \no código de \numa fila"
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.textColor = .white

        self.view.addSubview(label)

        label.translatesAutoresizingMaskIntoConstraints = false
        label.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        label.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        label.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20).isActive = true
        label.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20).isActive = true
        label.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.3).isActive = true
    }

    func setupTextField() {
        codeInput = UITextField(frame: .zero)
        guard let textField = codeInput, let label = msgLabel else {
            return
        }
        textField.layer.cornerRadius = self.view.frame.width * 0.05
        textField.clipsToBounds = true

        textField.layer.borderColor = CGColor(srgbRed: 240/255,
                                              green: 240/255,
                                              blue: 240/255,
                                              alpha: 1)
        textField.layer.borderWidth = 2

        self.view.addSubview(textField)

        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 0).isActive = true
        textField.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20).isActive = true
        textField.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20).isActive = true
        textField.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.05).isActive = true
    }

    @objc func createQueue() {
        print("created Queue")
    }
}
