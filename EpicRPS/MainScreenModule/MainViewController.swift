//
//  ViewController.swift
//  EpicRPS
//
//  Created by Alexander Altman on 09.06.2024.
//

import UIKit

final class MainViewController: UIViewController {
    //MARK: - Dependencies
    let fontSize: CGFloat = 20
    let offset: CGFloat = 60
    let smallButtonSize: CGFloat = 40
    
    // MARK: - UI Properties
    private lazy var startButton: UIButton = {
        let element = UIButton(type: .system)
        element.setTitle("START", for: .normal)
        element.setTitleColor(UIColor(named: "titleColorButton"), for: .normal)
        element.titleLabel?.font = UIFont.systemFont(ofSize: fontSize, weight: .heavy)
        element.setBackgroundImage(UIImage(named: "button"), for: .normal)
        element.addTarget(self, action: #selector(startButtonTapped), for: .touchUpInside)
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var resultsButton: UIButton = {
        let element = UIButton(type: .system)
        element.setTitle("RESULTS", for: .normal)
        element.setTitleColor(UIColor(named: "titleColorButton"), for: .normal)
        element.titleLabel?.font = UIFont.systemFont(ofSize: fontSize, weight: .heavy)
        element.setBackgroundImage(UIImage(named: "button"), for: .normal)
        element.addTarget(self, action: #selector(resultsButtonTapped), for: .touchUpInside)
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var settingsButton: UIButton = {
        let element = UIButton(type: .system)
        element.setBackgroundImage(UIImage(systemName: "gearshape.fill"), for: .normal)
        element.tintColor = .black
        element.addTarget(self, action: #selector(settingsButtonTapped), for: .touchUpInside)
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var rulesButton: UIButton = {
        let element = UIButton(type: .system)
        element.setBackgroundImage(UIImage(systemName: "questionmark.circle.fill"), for: .normal)
        element.tintColor = .black
        element.addTarget(self, action: #selector(rulesButtonTapped), for: .touchUpInside)
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var handsImageView: UIImageView = {
        let element = UIImageView()
        element.image = UIImage(named: "hands")
        element.contentMode = .scaleAspectFit
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
    
    // MARK: - Selector methods
    @objc private func startButtonTapped() {
        print("startButtonTapped")
        navigationController?.pushViewController(FightViewController(), animated: true)
    }
    
    @objc private func resultsButtonTapped() {
        print("resultsButtonTapped")
    }
    
    @objc private func settingsButtonTapped() {
        print("settingsButtonTapped")
    }
    
    @objc private func rulesButtonTapped() {
        print("rulesButtonTapped")
        navigationController?.pushViewController(RulesViewController(), animated: true)
    }
}

    // MARK: - Setup Constraints
private extension MainViewController {
     func setupConstraints() {
        NSLayoutConstraint.activate([
            startButton.bottomAnchor.constraint(equalTo: resultsButton.topAnchor, constant: -10),
            startButton.widthAnchor.constraint(equalToConstant: view.frame.width / 1.8),
            startButton.heightAnchor.constraint(equalToConstant: offset),
            startButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            resultsButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            resultsButton.heightAnchor.constraint(equalToConstant: offset),
            resultsButton.widthAnchor.constraint(equalToConstant: view.frame.width / 1.8),
            resultsButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            settingsButton.heightAnchor.constraint(equalToConstant: smallButtonSize),
            settingsButton.widthAnchor.constraint(equalToConstant: smallButtonSize),
            settingsButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            settingsButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            rulesButton.heightAnchor.constraint(equalToConstant: smallButtonSize),
            rulesButton.widthAnchor.constraint(equalToConstant: smallButtonSize),
            rulesButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            rulesButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),

            handsImageView.widthAnchor.constraint(equalToConstant: view.frame.width),
            handsImageView.heightAnchor.constraint(equalToConstant: view.frame.width),
            handsImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            handsImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}
