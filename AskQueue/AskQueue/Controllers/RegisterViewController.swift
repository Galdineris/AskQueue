//
//  RegisterViewController.swift
//  AskQueue
//
//  Created by Rafael Galdino on 18/01/20.
//  Copyright © 2020 Rafael Galdino. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {

    var fieldNameLabels: [UILabel]?
    var fieldsUIViews: [UIView]?
    var inputTextFields: [UITextField]?
    var inputTextView: UITextView?
    var animationConstraints: [NSLayoutConstraint]?
    weak var textFieldDelegate = TextFieldDelegate()

// MARK: Lifecycle Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        controllerSetup()
        setupAutolayout()
        createTextFields()
        createLabels()
        createTextViews()
        insertElementsInViews()
    }

    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.keyboardWillShow),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.keyboardWillHide),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
    }

    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.navigationBar.prefersLargeTitles = true
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }

// MARK: Visual Components Setups
    func controllerSetup() {
        self.view.backgroundColor = AskQueueColors.black
        navigationController?.navigationBar.barTintColor = AskQueueColors.lightGreen
        navigationController?.navigationBar.tintColor = AskQueueColors.white
        navigationController?.hidesBarsWhenKeyboardAppears = false
        self.navigationController?.navigationBar.largeTitleTextAttributes =
            [NSAttributedString.Key.foregroundColor: AskQueueColors.white]
        self.title = "Criar Fila"
        animationConstraints = []
    }

    func setupAutolayout() {
        var fields: [UIView] = []
        let margins = view.layoutMarginsGuide
        let guides = view.safeAreaLayoutGuide
        for _ in 0..<3 {
            let field = UIView(frame: .zero)
            self.view.addSubview(field)
            field.translatesAutoresizingMaskIntoConstraints = false
            field.trailingAnchor.constraint(equalTo: margins.trailingAnchor).isActive = true
            field.leadingAnchor.constraint(equalTo: margins.leadingAnchor).isActive = true
            fields.append(field)
        }
        animationConstraints?.append(fields[0].topAnchor.constraint(
        equalTo: guides.topAnchor,
        constant: 20))
        animationConstraints?.append(fields[1].topAnchor.constraint(
        equalTo: guides.topAnchor,
        constant: 20))
        animationConstraints?.append(fields[2].topAnchor.constraint(
        equalTo: guides.topAnchor,
        constant: 20))
        animationConstraints?[0].isActive = true
        fields[1].topAnchor.constraint(equalTo: fields[0].bottomAnchor,
                                       constant: 20).isActive = true
        fields[2].topAnchor.constraint(equalTo: fields[1].bottomAnchor,
                                       constant: 20).isActive = true
        fields[0].heightAnchor.constraint(equalToConstant: 90).isActive = true
        fields[1].heightAnchor.constraint(equalToConstant: 90).isActive = true
        fields[2].bottomAnchor.constraint(equalTo: guides.bottomAnchor,
                                          constant: -20).isActive = true
        fieldsUIViews = fields
    }

    func createLabels() {
        var labels: [UILabel] = []
        for _ in 0..<3 {
            let label = UILabel(frame: .zero)
            label.translatesAutoresizingMaskIntoConstraints = false
            label.font = UIFont.preferredFont(forTextStyle: .title3)
            label.adjustsFontForContentSizeCategory = true
            label.textColor = AskQueueColors.white
            label.sizeToFit()
            labels.append(label)
        }
        labels[0].text = "Tema"
        labels[1].text = "Autor"
        labels[2].text = "Pauta"
        fieldNameLabels = labels
    }

    func createTextFields() {
        var fields: [UITextField] = []
        for _ in 0..<2 {
            let textField = UITextField(frame: .zero)
            textField.translatesAutoresizingMaskIntoConstraints = false
            textField.keyboardAppearance = .dark
            textField.textAlignment = .natural
            textField.tag = 2
            textField.font = UIFont.preferredFont(forTextStyle: .title3)
            textField.delegate = textFieldDelegate
            textField.textColor = AskQueueColors.white
            fields.append(textField)
        }
        inputTextFields = fields
    }

    func createTextViews() {
        let textView = UITextView(frame: .zero)
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.keyboardAppearance = .dark
        textView.backgroundColor = AskQueueColors.black
        textView.textAlignment = .natural
        textView.font = UIFont.preferredFont(forTextStyle: .title3)
        textView.addDoneButton(title: "Done", target: self, selector: #selector(tapDone(sender:)))
        textView.textColor = AskQueueColors.white
        textView.clipsToBounds = false
        inputTextView = textView
    }

    func insertElementsInViews() {
        guard
            let textFields = inputTextFields,
            let labels = fieldNameLabels,
            let textView = inputTextView,
            let views = fieldsUIViews else {
            return
        }
        var fields: [UIView] = textFields
        fields.append(textView)
        for index in 0..<3 {
            views[index].addSubview(labels[index])
            labels[index].topAnchor.constraint(equalTo: views[index].topAnchor).isActive = true
            labels[index].heightAnchor.constraint(equalToConstant: 45).isActive = true
            labels[index].leadingAnchor.constraint(equalTo: views[index].leadingAnchor,
                                                   constant: 45/2).isActive = true
            labels[index].trailingAnchor.constraint(equalTo: views[index].trailingAnchor).isActive = true

            views[index].addSubview(fields[index])
            fields[index].topAnchor.constraint(equalTo: labels[index].bottomAnchor,
                                               constant: 2).isActive = true
            fields[index].bottomAnchor.constraint(equalTo: views[index].bottomAnchor,
                                                  constant: -2).isActive = true
            fields[index].leadingAnchor.constraint(equalTo: views[index].leadingAnchor,
                                                   constant: 45/2).isActive = true
            fields[index].trailingAnchor.constraint(equalTo: views[index].trailingAnchor,
                                                    constant: -45/2).isActive = true

            let border = UIView(frame: .zero)
            border.layer.cornerRadius = 45/2
            border.layer.borderColor = AskQueueColors.white.cgColor
            border.layer.borderWidth = 2
            border.clipsToBounds = true
            border.isUserInteractionEnabled = false
            fields[index].addSubview(border)
            border.translatesAutoresizingMaskIntoConstraints = false
            border.centerXAnchor.constraint(equalTo: fields[index].centerXAnchor).isActive = true
            border.centerYAnchor.constraint(equalTo: fields[index].centerYAnchor).isActive = true
            border.heightAnchor.constraint(equalTo: fields[index].heightAnchor,
                                           constant: 4).isActive = true
            border.widthAnchor.constraint(equalTo: fields[index].widthAnchor,
                                          constant: 45).isActive = true
        }
    }

// MARK: Triggered Functions
    @objc func keyboardWillShow() {
        for constraint in animationConstraints ?? [] {
            constraint.isActive = false
        }
        guard
            let textFields = inputTextFields,
            let textView = inputTextView else {
            return
        }
        var fields: [UIView] = textFields
        fields.append(textView)
        for index in 0..<3 {
            if fields[index].isFirstResponder {
                UIView.animate(withDuration: 1) { [weak self] in
                    self?.animationConstraints?[index].isActive = true
                    self?.view.layoutIfNeeded()
                }
            } else {
                fieldsUIViews?[index].isHidden = true
            }
        }
    }

    @objc func keyboardWillHide() {
        for constraint in animationConstraints ?? [] {
            constraint.isActive  = false
        }
        UIView.animate(withDuration: 1) { [weak self] in
            self?.fieldsUIViews?[0].isHidden = false
            self?.fieldsUIViews?[1].isHidden = false
            self?.fieldsUIViews?[2].isHidden = false
            self?.animationConstraints?[0].isActive = true
            self?.view.layoutIfNeeded()
        }
    }

    @objc func tapDone(sender: Any) {
        self.view.endEditing(true)
    }
}

// MARK: Extensions
extension UITextView {
    func addDoneButton(title: String, target: Any, selector: Selector) {

        let toolBar = UIToolbar(frame: CGRect(x: 0.0,
                                              y: 0.0,
                                              width: UIScreen.main.bounds.size.width,
                                              height: 44.0))
        let flexible = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let barButton = UIBarButtonItem(title: title,
                                        style: .plain,
                                        target: target,
                                        action: selector)
        toolBar.setItems([flexible, barButton], animated: false)
        self.inputAccessoryView = toolBar
    }
}
