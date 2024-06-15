//
//  WinLooseViewController.swift
//  EpicRPS
//
//  Created by mac41 on 11/6/2024.
//

import UIKit

final class ResultsViewController: UIViewController {

    // MARK: - Properties
    private let winResult = "You Win"
    private let looseResult = "You Lose"
    
    // MARK: - Player Configuration
    private let player = "Player 2"
    private let computer = "Player 1"
    
    // MARK: - Background Configuration
    private let winBackground = "Background"
    private let looseBackground = "winBackground"
    
    // MARK: - Score Properties
    var leftScore = 0 {
        didSet {
            updateScoreLabel()
        }
    }
    var rightScore = 0 {
        didSet {
            updateScoreLabel()
        }
    }
    
    // MARK: - Game Outcome
    var outcome = true
    
    // MARK: - UI Properties
    private lazy var playerImageView: UIImageView = {
        let imageName = outcome ? player : computer
        let imageView = UIImageView(image: UIImage(named: imageName))
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var circleView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 43/255, green: 40/255, blue: 112/255, alpha: 1.0)
        view.layer.cornerRadius = 88
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var resultLabelView: UILabel = {
        let resultLabel = UILabel()
        let outputText = outcome ? winResult : looseResult
        resultLabel.text = outputText
        resultLabel.font = UIFont(name: "Helvetica-Bold", size: 38)
        resultLabel.textColor = outcome ? .labelColour : .black
        resultLabel.textAlignment = .center
        resultLabel.adjustsFontSizeToFitWidth = true
        resultLabel.translatesAutoresizingMaskIntoConstraints = false
        return resultLabel
    }()
    
    private lazy var scoreView: UILabel = {
        let resultLabel = UILabel()
        resultLabel.font = UIFont(name: "Futura-Bold", size: 38)
        resultLabel.textColor = .white
        resultLabel.textAlignment = .center
        resultLabel.adjustsFontSizeToFitWidth = true
        resultLabel.translatesAutoresizingMaskIntoConstraints = false
        return resultLabel
    }()
    
    private lazy var homeButton: UIButton = {
        let homeButton = UIButton()
        homeButton.setImage(.home, for: .normal)
        homeButton.addTarget(self, action: #selector(homeButtonTapped), for: .touchUpInside)
        homeButton.translatesAutoresizingMaskIntoConstraints = false
        return homeButton
    }()
    
    private lazy var restartButton: UIButton = {
        let restartButton = UIButton()
        restartButton.setImage(.restart, for: .normal)
        restartButton.addTarget(self, action: #selector(restartButtonTapped), for: .touchUpInside)
        restartButton.translatesAutoresizingMaskIntoConstraints = false
        return restartButton
    }()

    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraints()
    }

    
    // MARK: - Private Methods
    private func setupUI() {
        view.backgroundColor = .white
        setBackground(imageName: outcome ? winBackground : looseBackground)
        view.addSubview(circleView)
        circleView.addSubview(playerImageView)
        view.addSubview(resultLabelView)
        view.addSubview(scoreView)
        view.addSubview(homeButton)
        view.addSubview(restartButton)
        
        updateScoreLabel()
        
        navigationController?.isNavigationBarHidden = true
    }
    
    
    // MARK: - Update UI
    private func updateScoreLabel() {
        scoreView.text = "\(leftScore) - \(rightScore)"
    }
    
    func setBackground(imageName: String) {
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: imageName)
        backgroundImage.contentMode = .scaleAspectFill
        view.insertSubview(backgroundImage, at: 0)
    }
    
    // MARK: - Methods for buttons
    @objc func homeButtonTapped() {
        navigationController?.popToRootViewController(animated: true)
    }
    
    @objc func restartButtonTapped() {
        print("Restart button tapped")
        navigationController?.popViewController(animated: true)
    //TODO: "kill FightViewController -> reboot FightViewController"
    }
}

// MARK: - Setup Constraints
private extension ResultsViewController {
     func setupConstraints() {
        NSLayoutConstraint.activate([
            circleView.widthAnchor.constraint(equalToConstant: 176),
            circleView.heightAnchor.constraint(equalToConstant: 176),
            circleView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            circleView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 130),
            
            playerImageView.centerXAnchor.constraint(equalTo: circleView.centerXAnchor),
            playerImageView.centerYAnchor.constraint(equalTo: circleView.centerYAnchor),
            playerImageView.widthAnchor.constraint(equalTo: circleView.widthAnchor, multiplier: 0.5),

            resultLabelView.topAnchor.constraint(equalTo: circleView.bottomAnchor, constant: 20),
            resultLabelView.centerXAnchor.constraint(equalTo: circleView.centerXAnchor),
            resultLabelView.widthAnchor.constraint(equalToConstant: 84),
            resultLabelView.heightAnchor.constraint(equalToConstant: 25),
            
            scoreView.topAnchor.constraint(equalTo: resultLabelView.bottomAnchor, constant: 17),
            scoreView.centerXAnchor.constraint(equalTo: circleView.centerXAnchor),
            scoreView.widthAnchor.constraint(equalToConstant: 84),
            scoreView.heightAnchor.constraint(equalToConstant: 49),
            
            homeButton.topAnchor.constraint(equalTo: scoreView.topAnchor, constant: 80),
            homeButton.leadingAnchor.constraint(equalTo: view.centerXAnchor, constant: -110),
            homeButton.widthAnchor.constraint(equalToConstant: 100),
            homeButton.heightAnchor.constraint(equalToConstant: 50),
            
            restartButton.topAnchor.constraint(equalTo: homeButton.topAnchor),
            restartButton.leadingAnchor.constraint(equalTo: homeButton.trailingAnchor, constant: 20),
            restartButton.widthAnchor.constraint(equalToConstant: 100),
            restartButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}

