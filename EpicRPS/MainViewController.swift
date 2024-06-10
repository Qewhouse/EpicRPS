//
//  ViewController.swift
//  EpicRPS
//
//  Created by Alexander Altman on 09.06.2024.
//

import UIKit

final class MainViewController: UIViewController {
    
    // MARK: - UI Properties
    
    private lazy var startButton: UIButton = {
        let element = UIButton(type: .system)
        element.setTitle("START", for: .normal)
        element.setTitleColor(UIColor(named: "titleColorButton"), for: .normal)
        element.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .heavy)
        element.setBackgroundImage(UIImage(named: "button"), for: .normal)
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var resultsButton: UIButton = {
        let element = UIButton(type: .system)
        element.setTitle("RESULTS", for: .normal)
        element.setTitleColor(UIColor(named: "titleColorButton"), for: .normal)
        element.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .heavy)
        element.setBackgroundImage(UIImage(named: "button"), for: .normal)
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var settingsButton: UIButton = {
        let element = UIButton(type: .system)
        element.setBackgroundImage(UIImage(systemName: "gearshape.fill"), for: .normal)
        element.tintColor = .black
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    
    private lazy var rulesButton: UIButton = {
        let element = UIButton(type: .system)
        element.setBackgroundImage(UIImage(systemName: "questionmark.circle.fill"), for: .normal)
        element.tintColor = .black
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var handsImageView: UIImageView = {
        let element = UIImageView()
        element.image = UIImage(named: "hands")
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupConstraints()
        
    }
    
    // MARK: - Private Methods
    
    private func setupUI() {
        view.backgroundColor = UIColor(named: "backgroundColor")
        
        view.addSubview(settingsButton)
        view.addSubview(rulesButton)
        view.addSubview(startButton)
        view.addSubview(resultsButton)
        
        view.addSubview(handsImageView)
    
    }
}


    // MARK: - Setup Constraints

extension MainViewController {
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
           
            startButton.bottomAnchor.constraint(equalTo: resultsButton.topAnchor, constant: -10),
            startButton.heightAnchor.constraint(equalToConstant: 60),
            startButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 100),
            startButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -100),
            
            resultsButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -60),
            resultsButton.heightAnchor.constraint(equalToConstant: 60),
            resultsButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 100),
            resultsButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -100),
            
            settingsButton.heightAnchor.constraint(equalToConstant: 40),
            settingsButton.widthAnchor.constraint(equalToConstant: 40),
            settingsButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            settingsButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            
            rulesButton.heightAnchor.constraint(equalToConstant: 40),
            rulesButton.widthAnchor.constraint(equalToConstant: 40),
            rulesButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            rulesButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            
            
            handsImageView.heightAnchor.constraint(equalToConstant: 360),
            handsImageView.widthAnchor.constraint(equalToConstant: 430),
            handsImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            handsImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
    
        ])
    }
}
