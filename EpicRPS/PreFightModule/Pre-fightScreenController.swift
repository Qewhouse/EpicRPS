//
//  Pre-fightScreen.swift
//  EpicRPS
//
//  Created by Андрей Линьков on 11.06.2024.
//

import UIKit

class Pre_fightScreen: UIViewController {
    
    // MARK: - UI Properties
    private lazy var player1: UIImageView = {
        let element = UIImageView()
        element.image = UIImage.player1
        element.contentMode = .scaleAspectFit
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    } ()
    
    private lazy var player2: UIImageView = {
        let element = UIImageView()
        element.image = UIImage.player2
        element.contentMode = .scaleAspectFit
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    } ()
    
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
    
    private let player1Stat: UITextView = {
        let element = UITextView()
        element.textColor = .white
        element.backgroundColor = .clear
        element.text =
        """
        10 Victories /
            2 Lose
        """
        element.font = UIFont.boldSystemFont(ofSize: 19.5)
        element.contentMode = .scaleAspectFill
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private let player2Stat: UITextView = {
        let element = UITextView()
        element.textColor = .white
        element.backgroundColor = .clear
        element.text =
        """
        23 Victories /
             1 Lose
        """
        element.font = UIFont.boldSystemFont(ofSize: 19.5)
        element.contentMode = .scaleAspectFit
        element.translatesAutoresizingMaskIntoConstraints = false
        print(element)
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
            player1Stat.widthAnchor.constraint(equalToConstant: 128),
            player1Stat.bottomAnchor.constraint(equalTo: vsLabel.topAnchor, constant: -61),
            player1Stat.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            player2Stat.heightAnchor.constraint(equalToConstant: 50),
            player2Stat.widthAnchor.constraint(equalToConstant: 128),
            player2Stat.topAnchor.constraint(equalTo: player2.bottomAnchor, constant: 10),
            player2Stat.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
    }
}
