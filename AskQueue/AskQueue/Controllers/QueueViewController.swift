//
//  QueueViewController.swift
//  AskQueue
//
//  Created by Rafael Galdino on 23/01/20.
//  Copyright © 2020 Rafael Galdino. All rights reserved.
//

import UIKit

class QueueViewController: UIViewController {

    var viewsContainers: [UIView]?
    var staticLabels: [UILabel]?
    var timeLabel: UILabel?
    var currentNameLabel: UILabel?
    var queueCodeLabel: UILabel?
    var interruptButton: UIButton?
    var joinQueueButton: UIButton?
    var queueTableView: UITableView?

// MARK: Lifecycle Functions
    override func viewWillAppear(_ animated: Bool) {
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupController()
        setupContainers()
        createLabels()
        createButtons()
        createTableView()
        insertElements()
    }

// MARK: Visual Components Setups
    func setupController() {
        self.view.backgroundColor = AskQueueColors.black
        navigationController?.navigationBar.barTintColor = AskQueueColors.darkGreen
        navigationController?.navigationBar.tintColor = AskQueueColors.lightGreen
        navigationItem.largeTitleDisplayMode = .never
        self.title = "Fila"
        createRightBarButton()
        viewsContainers = []
        staticLabels = []
    }

    func setupContainers() {
        var views: [UIView] = []
        let margins = view.layoutMarginsGuide
        let guides = view.safeAreaLayoutGuide
        for _ in 0..<6 {
            let field = UIView(frame: .zero)
            field.translatesAutoresizingMaskIntoConstraints = false
            views.append(field)
            self.view.addSubview(field)
            field.trailingAnchor.constraint(equalTo: margins.trailingAnchor).isActive = true
            field.leadingAnchor.constraint(equalTo: margins.leadingAnchor).isActive = true
        }
        views[0].topAnchor.constraint(equalTo: guides.topAnchor).isActive = true
        views[1].topAnchor.constraint(equalTo: views[0].bottomAnchor).isActive = true
        views[2].topAnchor.constraint(equalTo: views[1].bottomAnchor).isActive = true
        views[3].topAnchor.constraint(equalTo: views[2].bottomAnchor).isActive = true
        views[4].topAnchor.constraint(equalTo: views[3].bottomAnchor).isActive = true
        views[5].topAnchor.constraint(equalTo: views[4].bottomAnchor).isActive = true
        views[5].bottomAnchor.constraint(equalTo: guides.bottomAnchor).isActive = true

        views[0].heightAnchor.constraint(equalTo: guides.heightAnchor, multiplier: 0.1).isActive = true
        views[1].heightAnchor.constraint(equalTo: guides.heightAnchor, multiplier: 0.2).isActive = true
        views[2].heightAnchor.constraint(equalToConstant: 75).isActive = true
        views[3].heightAnchor.constraint(equalTo: guides.heightAnchor, multiplier: 0.06).isActive = true
        views[5].heightAnchor.constraint(equalToConstant: 75).isActive = true

        viewsContainers = views
    }

    func createLabels() {
        var labels: [UILabel] = []
        for index in 0..<6 {
            let label = UILabel(frame: .zero)
            label.translatesAutoresizingMaskIntoConstraints = false
            label.adjustsFontForContentSizeCategory = true
            label.lineBreakMode = .byWordWrapping
            label.numberOfLines = 0
            label.font = UIFont.rounded17Regular
            label.textAlignment = .center
            label.textColor = AskQueueColors.white
            label.sizeToFit()
            switch index {
            case 0:
                timeLabel = label
            case 1:
                currentNameLabel = label
            case 2:
                queueCodeLabel = label
            default:
                labels.append(label)
            }
        }

        queueCodeLabel?.text = "000000"
        queueCodeLabel?.font = UIFont.rounded17Regular
        timeLabel?.text = "00:30"
        timeLabel?.font = UIFont.default64RegularItalic
        currentNameLabel?.text = "Claire"
        currentNameLabel?.font = UIFont.rounded22Regular
        currentNameLabel?.textAlignment = .left

        labels[0].text = "Código da Fila"
        labels[0].font = UIFont.rounded17Regular
        labels[1].text = "Tempo Restante de Fala"
        labels[1].font = UIFont.rounded22Bold
        labels[2].text = "Próximos a falar"
        labels[2].font = UIFont.rounded22Regular

        staticLabels = labels
    }

    func createButtons() {
        var buttons: [UIButton] = []
        for _ in 0..<2 {
            let button = UIButton(frame: .zero)
            button.translatesAutoresizingMaskIntoConstraints = false
            button.layer.borderColor = AskQueueColors.red.cgColor
            button.layer.cornerRadius = 55/2
            button.clipsToBounds = true
            button.setTitleColor(AskQueueColors.darkGreen,
                                 for: .highlighted)
            button.setTitleColor(AskQueueColors.white,
                                 for: .normal)
            button.backgroundColor = AskQueueColors.lightGreen
            buttons.append(button)
        }
        buttons[0].setTitle("Adendo",
                            for: .normal)
        buttons[1].setTitle("Entrar na Fila",
                            for: .normal)
        buttons[0].addTarget(self,
                             action: #selector(interruptQueue),
                             for: .touchDown)
        buttons[1].addTarget(self,
                             action: #selector(joinQueue),
                             for: .touchDown)
        interruptButton = buttons[0]
        joinQueueButton = buttons[1]
    }

    func createTableView() {
        let tableView = UITableView(frame: .zero)
        tableView.translatesAutoresizingMaskIntoConstraints  = false
        tableView.backgroundColor = AskQueueColors.black
        tableView.separatorStyle = .singleLine
        tableView.separatorColor = AskQueueColors.white.withAlphaComponent(0.2)
        queueTableView = tableView
    }

    func createRightBarButton() {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .organize,
                                                                 target: self,
                                                                 action: #selector(detailQueue))
        self.navigationController?.navigationBar.tintColor = AskQueueColors.lightGreen
    }


    func insertElements() {
        guard let views =  viewsContainers, let labels = staticLabels, let code = queueCodeLabel, let time = timeLabel,
            let currentName = currentNameLabel, let interrupt = interruptButton, let joinQueue = joinQueueButton,
            let queueTable = queueTableView else {
            return
        }
        for label in [labels[0], code] {
            views[0].addSubview(label)
            label.leadingAnchor.constraint(equalTo: views[0].leadingAnchor).isActive = true
            label.trailingAnchor.constraint(equalTo: views[0].trailingAnchor).isActive = true
        }
        labels[0].topAnchor.constraint(equalTo: views[0].topAnchor, constant: 5).isActive = true
        labels[0].bottomAnchor.constraint(equalTo: code.topAnchor, constant: 5).isActive = true
        code.bottomAnchor.constraint(equalTo: views[0].bottomAnchor, constant: -10).isActive = true
        code.heightAnchor.constraint(equalTo: views[0].heightAnchor, multiplier: 0.5).isActive = true

        for label in [time, labels[1]] {
            views[1].addSubview(label)
            label.leadingAnchor.constraint(equalTo: views[1].leadingAnchor).isActive = true
            label.trailingAnchor.constraint(equalTo: views[1].trailingAnchor).isActive = true
        }
        time.topAnchor.constraint(equalTo: views[1].topAnchor).isActive = true
        labels[1].topAnchor.constraint(equalTo: time.bottomAnchor).isActive = true
        labels[1].bottomAnchor.constraint(equalTo: views[1].bottomAnchor).isActive = true

        for view in [currentName, interrupt] {
            views[2].addSubview(view)
            view.topAnchor.constraint(equalTo: views[2].topAnchor, constant: 10).isActive = true
            view.bottomAnchor.constraint(equalTo: views[2].bottomAnchor, constant: -10).isActive = true
        }
        currentName.leadingAnchor.constraint(equalTo: views[2].leadingAnchor).isActive = true
        currentName.trailingAnchor.constraint(equalTo: interrupt.trailingAnchor).isActive = true
        interrupt.trailingAnchor.constraint(equalTo: views[2].trailingAnchor).isActive = true
        interrupt.widthAnchor.constraint(equalTo: views[2].widthAnchor, multiplier: 0.4).isActive = true

        var index: Int = 3
        for view in [labels[2], queueTable] {
            views[index].addSubview(view)
            view.topAnchor.constraint(equalTo: views[index].topAnchor).isActive = true
            view.bottomAnchor.constraint(equalTo: views[index].bottomAnchor).isActive = true
            view.leadingAnchor.constraint(equalTo: views[index].leadingAnchor).isActive = true
            view.trailingAnchor.constraint(equalTo: views[index].trailingAnchor).isActive = true
            index += 1
        }
        views[5].addSubview(joinQueue)
        joinQueue.topAnchor.constraint(equalTo: views[5].topAnchor, constant: 10).isActive = true
        joinQueue.bottomAnchor.constraint(equalTo: views[5].bottomAnchor, constant: -10).isActive = true
        joinQueue.leadingAnchor.constraint(equalTo: views[5].leadingAnchor).isActive = true
        joinQueue.trailingAnchor.constraint(equalTo: views[5].trailingAnchor).isActive = true
    }

    @objc func interruptQueue() {
        UIView.animate(withDuration: 0.5) { [weak self] in
            if self?.interruptButton?.backgroundColor == AskQueueColors.lightGreen {
                self?.interruptButton?.layer.borderWidth = 2
                self?.interruptButton?.backgroundColor = .clear
                self?.interruptButton?.setTitle("Cancelar", for: .normal)
            } else {
                self?.interruptButton?.layer.borderWidth = 0
                self?.interruptButton?.backgroundColor = AskQueueColors.lightGreen
                self?.interruptButton?.setTitle("Adendo", for: .normal)
            }
        }
    }

    @objc func joinQueue() {
        UIView.animate(withDuration: 0.5) { [weak self] in
            if self?.joinQueueButton?.backgroundColor == AskQueueColors.lightGreen {
                self?.joinQueueButton?.layer.borderWidth = 2
                self?.joinQueueButton?.backgroundColor = .clear
                self?.joinQueueButton?.setTitle("Cancelar", for: .normal)
            } else {
                self?.joinQueueButton?.layer.borderWidth = 0
                self?.joinQueueButton?.backgroundColor = AskQueueColors.lightGreen
                self?.joinQueueButton?.setTitle("Ficar na Fila", for: .normal)
            }
        }
    }

    @objc func detailQueue() {
        let detailViewController = DetailViewController()
        detailViewController.navigationItem.largeTitleDisplayMode = .never
        detailViewController.navigationController?.navigationBar.prefersLargeTitles = false
        detailViewController.joinQueueBool = false
        navigationController?.pushViewController(detailViewController, animated: true)
    }

}
