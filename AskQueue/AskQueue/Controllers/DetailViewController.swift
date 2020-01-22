//
//  DetailViewController.swift
//  AskQueue
//
//  Created by Rafael Galdino on 22/01/20.
//  Copyright © 2020 Rafael Galdino. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    var queueCode: String?
    var queueTitle: String?
    var queueAutor: String?
    var queueDescription: String?
    private var infoViews: [UIView]?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupController()
        createLabels()
        createTextViews()
        insertElementsIntoView()
    }

    func setupController() {
        self.view.backgroundColor = AskQueueColors.black
        navigationController?.navigationBar.barTintColor = AskQueueColors.lightGreen
        navigationController?.navigationBar.tintColor = AskQueueColors.white
        navigationController?.hidesBarsWhenKeyboardAppears = false
        self.navigationController?.navigationBar.largeTitleTextAttributes =
            [NSAttributedString.Key.foregroundColor: AskQueueColors.white]
        navigationItem.largeTitleDisplayMode = .never
        navigationController?.navigationBar.prefersLargeTitles = false
        self.title = "CriarFila"
        infoViews = []
    }

    func createLabels() {
        var labels: [UILabel] = []
        for _ in 0..<3 {
            let label = UILabel(frame: .zero)
            label.translatesAutoresizingMaskIntoConstraints = false
            label.adjustsFontForContentSizeCategory = true
            label.lineBreakMode = .byWordWrapping
            label.numberOfLines = 0
            label.font = UIFont.preferredFont(forTextStyle: .title1)
            label.textColor = AskQueueColors.white
            label.sizeToFit()
            labels.append(label)
        }
        labels[0].text = "Código da Sala: UGH3(EPQ"
        labels[1].text = "Tema: Reunião de Regras"
        labels[2].text = "Autor: Roberto"
        labels[2].font = UIFont.preferredFont(forTextStyle: .title3)
        infoViews?.append(contentsOf: labels)
    }

    func createTextViews() {
        let textView = UITextView(frame: .zero)
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.backgroundColor = AskQueueColors.black
        textView.textAlignment = .natural
        textView.isEditable = false
        textView.textColor = AskQueueColors.white
        textView.clipsToBounds = false
        textView.text = "Pauta:\n Reunião para decidir novo conjunto de regras" +
            " para uso de equipamentos do laboratório" +
        "\n*  Enumerar Equipamentos\n*  Revesar regras passadas\n*  Criar novo conjunto de regras"
        textView.font = UIFont.preferredFont(forTextStyle: .body)
        infoViews?.append(textView)
    }

    func insertElementsIntoView() {
        guard let labels = infoViews else {
            return
        }

        let margins = self.view.layoutMarginsGuide
        let guides = self.view.safeAreaLayoutGuide

        for index in 0..<4 {
            self.view.addSubview(labels[index])
            labels[index].leadingAnchor.constraint(equalTo: margins.leadingAnchor).isActive = true
            labels[index].trailingAnchor.constraint(equalTo: margins.trailingAnchor).isActive = true
        }
        labels[0].topAnchor.constraint(equalTo: guides.topAnchor, constant: 40).isActive = true
        labels[1].topAnchor.constraint(equalTo: labels[0].bottomAnchor, constant: 40).isActive = true
        labels[2].topAnchor.constraint(equalTo: labels[1].bottomAnchor, constant: 10).isActive = true
        labels[3].topAnchor.constraint(equalTo: labels[2].bottomAnchor, constant: 40).isActive = true
        labels[3].bottomAnchor.constraint(equalTo: guides.bottomAnchor).isActive = true
    }
}
