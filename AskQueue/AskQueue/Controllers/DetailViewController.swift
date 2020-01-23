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
    var joinQueueBool: Bool = false
    private var infoViews: [UIView]?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupController()
        updateInformation()
        createLabels()
        createTextViews()
        if joinQueueBool {
            createButton()
        }
        insertElementsIntoView()
    }

    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }

    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.prefersLargeTitles = false
    }

    func setupController() {
        self.view.backgroundColor = AskQueueColors.black
        navigationController?.navigationBar.barTintColor = AskQueueColors.lightGreen
        navigationController?.navigationBar.tintColor = AskQueueColors.white
        navigationController?.hidesBarsWhenKeyboardAppears = false
        self.navigationController?.navigationBar.largeTitleTextAttributes =
            [NSAttributedString.Key.foregroundColor: AskQueueColors.white]
        navigationItem.largeTitleDisplayMode = .never
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
        labels[0].text = "Código da Sala: " + (queueCode ?? "000000")
        labels[1].text = "Tema: " + (queueTitle ?? "Erro de Conexão")
        labels[2].text = "Autor: " + (queueAutor ?? "Favor, recarregar a página")
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
        textView.text = "Pauta: \n" + (queueDescription ?? "")
        textView.font = UIFont.preferredFont(forTextStyle: .body)
        infoViews?.append(textView)
    }

    func createButton() {
        let button = UIButton(frame: .zero)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 55/2
        button.clipsToBounds = true
        button.setTitle("Entrar", for: .normal)
        button.addTarget(self, action: #selector(joinQueue),
                         for: .touchDown)
        button.setTitleColor(AskQueueColors.darkGreen,
                             for: .highlighted)
        button.setTitleColor(AskQueueColors.white,
                             for: .normal)
        button.backgroundColor = AskQueueColors.lightGreen

        infoViews?.append(button)
    }

    func insertElementsIntoView() {
        guard let labels = infoViews else {
            return
        }

        let margins = self.view.layoutMarginsGuide
        let guides = self.view.safeAreaLayoutGuide

        for index in 0..<labels.count {
            self.view.addSubview(labels[index])
            labels[index].leadingAnchor.constraint(equalTo: margins.leadingAnchor).isActive = true
            labels[index].trailingAnchor.constraint(equalTo: margins.trailingAnchor).isActive = true
            switch index {
            case 0:
                labels[0].topAnchor.constraint(equalTo: guides.topAnchor, constant: 40).isActive = true
            case 2:
                labels[2].topAnchor.constraint(equalTo: labels[1].bottomAnchor, constant: 10).isActive = true
            default:
                labels[index].topAnchor.constraint(equalTo: labels[index - 1].bottomAnchor, constant: 40).isActive = true
            }
        }
        labels[labels.count - 1].bottomAnchor.constraint(equalTo: guides.bottomAnchor).isActive = true
    }

    func updateInformation() {
        queueCode = "UGH3(EPQ"
        queueTitle = "Reunião de Regras"
        queueAutor = "Takumi"
        queueDescription = "Reunião para decidir novo conjunto de regras" +
            " para uso de equipamentos do laboratório" +
        "\n*  Enumerar Equipamentos\n*  Revesar regras passadas\n*  Criar novo conjunto de regras"
    }

    @objc func joinQueue() {
        print("joined Queue")
    }
}
