//
//  WinLooseViewController.swift
//  EpicRPS
//
//  Created by mac41 on 11/6/2024.
//

import UIKit

final class WinLooseViewController: UIViewController {
    
//  receiving results
//  receiving scores
//  change text according to the resutls
//  change text color according to the results
//  change background according to the results
//  change player Image according to the results
    
    
//  gradientLayer.colors = [
//      UIColor(red: 255/255, green: 182/255, blue: 0/255, alpha: 1.0).cgColor,
//      UIColor(red: 238/255, green: 65/255, blue: 60/255, alpha: 0.8).cgColor
//  ] // colors for the loose screen
    
    

    
    let player = "Player 2"
    let leftScore = 3
    let rightScore = 1
    let winResult = "You Win"
    let looseResult = "You Loose"
    
    
    // MARK: - UI Properties
    private lazy var gradientLayer: CAGradientLayer = {
        let gradientLayer = CAGradientLayer()
        gradientLayer.type = .radial
        gradientLayer.colors = [
            UIColor(red: 45/255, green: 37/255, blue: 153/255, alpha: 1.0).cgColor,
            UIColor(red: 101/255, green: 109/255, blue: 244/255, alpha: 1.0).cgColor
        ]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
        gradientLayer.frame = view.bounds
        return gradientLayer
    }()
    
    private lazy var playerView: UIImageView = {
        let image = UIImage(named: player)
        let imageView = UIImageView(image: image)
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
        resultLabel.text = winResult
        resultLabel.font = UIFont(name: "Helvetica-Bold", size: 38)
        resultLabel.textColor = UIColor(red: 1.0, green: 0.696, blue: 0.298, alpha: 1.0) // Custom color #FFB24C
        resultLabel.textAlignment = .center
        resultLabel.adjustsFontSizeToFitWidth = true
        resultLabel.translatesAutoresizingMaskIntoConstraints = false

        return resultLabel
    }()
    
    private lazy var scoreView: UILabel = {
        let resultLabel = UILabel()
        resultLabel.text = "\(leftScore) - \(rightScore)"
        resultLabel.font = UIFont(name: "Futura-Bold", size: 38)
        resultLabel.textColor = .white
        resultLabel.textAlignment = .center
        resultLabel.adjustsFontSizeToFitWidth = true
        resultLabel.translatesAutoresizingMaskIntoConstraints = false

        return resultLabel
    }()
    
    private lazy var homeButtonView: UIButton = {
        let homeButton = UIButton()
        homeButton.translatesAutoresizingMaskIntoConstraints = false
        if let homeImage = UIImage(named: "Home") {
            homeButton.setImage(homeImage, for: .normal)
        }
        homeButton.imageView?.contentMode = .scaleAspectFit
        homeButton.addTarget(self, action: #selector(homeButtonTapped), for: .touchUpInside)
        return homeButton
    }()
    
    private lazy var restartButtonView: UIButton = {
        let restartButton = UIButton()
        restartButton.translatesAutoresizingMaskIntoConstraints = false
        if let restartImage = UIImage(named: "Restart") {
            restartButton.setImage(restartImage, for: .normal)
        }
        restartButton.imageView?.contentMode = .scaleAspectFit
        restartButton.addTarget(self, action: #selector(restartButtonTapped), for: .touchUpInside)
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
        view.layer.insertSublayer(gradientLayer, at: 0)
        view.addSubview(circleView)
        view.addSubview(playerView)
        view.addSubview(resultLabelView)
        view.addSubview(scoreView)
        view.addSubview(homeButtonView)
        view.addSubview(restartButtonView)
    }
    
    // MARK: - Methods for buttons
    @objc func homeButtonTapped() {
        print("Home button tapped")
    }
    
    @objc func restartButtonTapped() {
        print("Restart button tapped")
    }
}

// MARK: - Setup Constraints
private extension WinLooseViewController {
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            circleView.widthAnchor.constraint(equalToConstant: 176),
            circleView.heightAnchor.constraint(equalToConstant: 176),
            circleView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            circleView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 130),
            
            playerView.centerXAnchor.constraint(equalTo: circleView.centerXAnchor),
            playerView.centerYAnchor.constraint(equalTo: circleView.centerYAnchor),
            playerView.widthAnchor.constraint(equalToConstant: 67.17),
            playerView.heightAnchor.constraint(equalToConstant: 78.05),

            resultLabelView.topAnchor.constraint(equalTo: circleView.bottomAnchor, constant: 20),
            resultLabelView.centerXAnchor.constraint(equalTo: circleView.centerXAnchor),
            resultLabelView.widthAnchor.constraint(equalToConstant: 84),
            resultLabelView.heightAnchor.constraint(equalToConstant: 25),
            
            scoreView.topAnchor.constraint(equalTo: resultLabelView.bottomAnchor, constant: 17),
            scoreView.centerXAnchor.constraint(equalTo: circleView.centerXAnchor),
            scoreView.widthAnchor.constraint(equalToConstant: 84),
            scoreView.heightAnchor.constraint(equalToConstant: 49),
            
            homeButtonView.topAnchor.constraint(equalTo: scoreView.topAnchor, constant: 80),
            homeButtonView.leadingAnchor.constraint(equalTo: view.centerXAnchor, constant: -110),
            homeButtonView.widthAnchor.constraint(equalToConstant: 100),
            homeButtonView.heightAnchor.constraint(equalToConstant: 50),
            
            restartButtonView.topAnchor.constraint(equalTo: homeButtonView.topAnchor),
            restartButtonView.leadingAnchor.constraint(equalTo: homeButtonView.trailingAnchor, constant: 20),
            restartButtonView.widthAnchor.constraint(equalToConstant: 100),
            restartButtonView.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}

