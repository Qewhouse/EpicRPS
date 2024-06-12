//
//  RulesViewController.swift
//  EpicRPS
//
//  Created by Валентина Попова on 10.06.2024.
//

import UIKit

class RulesViewController: UIViewController {
    
    var rulesView = RulesView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view = rulesView
        showNavigationBar()
    }
    
    func showNavigationBar() {
        title = "Правила"

        let appearance = UINavigationBarAppearance()
        appearance.titleTextAttributes = [.font: UIFont.boldSystemFont(ofSize: 24)]
        navigationController?.navigationBar.standardAppearance = appearance

        let backButton = UIBarButtonItem(image: UIImage(systemName: "chevron.backward"),
                                         style: .plain,
                                         target: self,
                                         action: #selector(backButtonTapped))

        backButton.tintColor = .black
        navigationItem.leftBarButtonItem = backButton
    }
    
    @objc func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
}
