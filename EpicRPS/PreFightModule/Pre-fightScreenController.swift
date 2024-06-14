//
//  Pre-fightScreen.swift
//  EpicRPS
//
//  Created by Андрей Линьков on 11.06.2024.
//

import UIKit

class Pre_fightScreen: UIViewController {
    //MARK: - Dependencies
    var player1winStat: Int = 12
    var player1looseStat: Int = 6
    var player2winStat: Int = 25
    var player2looseStat: Int = 33
    
    // MARK: - UI Properties
    private lazy var player1: UIImageView = {
        let element = UIImageView()
        element.image = UIImage.player1
        element.contentMode = .scaleAspectFit
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var player2: UIImageView = {
        let element = UIImageView()
        element.image = UIImage.player2
        element.contentMode = .scaleAspectFit
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private let vsLabel: UILabel = {
        let element = UILabel()
        element.textColor = UIColor(.labelColour)
        element.text = "VS"
        element.font = UIFont.boldSystemFont(ofSize: 60)
        element.contentMode = .scaleAspectFit
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private let getReadyLabel: UILabel = {
        let element = UILabel()
        element.textColor = UIColor(.labelColour)
        element.text = "Get ready..."
        element.font = UIFont.boldSystemFont(ofSize: 19.5)
        element.contentMode = .scaleAspectFit
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var player1Stat: UILabel = {
        let element = UILabel()
        element.textColor = .white
        element.textAlignment = .center
        element.numberOfLines = 0
        element.text =
        """
        \(player1winStat) Victories /
        \(player1looseStat) Lose
        """
        element.font = UIFont.boldSystemFont(ofSize: 19.5)
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var player2Stat: UILabel = {
        let element = UILabel()
        element.textColor = .white
        element.textAlignment = .center
        element.numberOfLines = 0
        element.text =
        """
        \(player2winStat) Victories /
        \(player2looseStat) Lose
        """
        element.font = UIFont.boldSystemFont(ofSize: 19.5)
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var backgroundImage: UIImageView = {
        let element = UIImageView()
        element.image = UIImage.background
        element.contentMode = .scaleAspectFill
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraints()
        startGame()
    }
    
    // MARK: - Private Methods
    private func setupUI() {
        view.addSubview(backgroundImage)
        view.addSubview(player1)
        view.addSubview(player2)
        view.addSubview(vsLabel)
        view.addSubview(getReadyLabel)
        view.addSubview(player1Stat)
        view.addSubview(player2Stat)
        navigationController?.isNavigationBarHidden = true
    }
    
    //MARK: - Private Selector Methods
    @objc func startGame() {
            // Delay the transition to the pre-game screen by 3 seconds
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                self.navigationController?.pushViewController(FightViewController(), animated: true)
            }
        }
}

// MARK: - Setup Constraints
private extension Pre_fightScreen{
    func setupConstraints() {
        NSLayoutConstraint.activate([
            backgroundImage.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImage.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundImage.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            vsLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            vsLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            getReadyLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            getReadyLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -56),
            
            player1.bottomAnchor.constraint(equalTo: player1Stat.topAnchor, constant: -9),
            player1.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            player2.topAnchor.constraint(equalTo: vsLabel.bottomAnchor, constant: 61),
            player2.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            player1Stat.heightAnchor.constraint(equalToConstant: 50),
            player1Stat.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 100),
            player1Stat.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -100),
            player1Stat.bottomAnchor.constraint(equalTo: vsLabel.topAnchor, constant: -61),
            
            player2Stat.heightAnchor.constraint(equalToConstant: 50),
            player2Stat.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 100),
            player2Stat.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -100),
            player2Stat.topAnchor.constraint(equalTo: player2.bottomAnchor, constant: 10),
        ])
    }
}
