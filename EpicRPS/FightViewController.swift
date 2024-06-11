//
//  FightViewController.swift
//  EpicRPS
//
//  Created by Станислав Артамонов on 10.06.24.
//

import Foundation
import UIKit

final class FightViewController: UIViewController {
    
    // MARK: - Enum
    private enum Constants {
        static let roundTime: Int = 30
        static let maleHandInitialTopConstant: CGFloat = 60
        static let femaleHandInitialBottomConstant: CGFloat = -60
        static let maleHandToCenterOffset: CGFloat = -40
        static let femaleHandToCenterOffset: CGFloat = 40
        static let handImageWidth: CGFloat = 200
        static let handImageHeight: CGFloat = 500
        static let leadingMargin: CGFloat = 80
        static let buttonSize: CGFloat = 80
        static let buttonBottomMargin: CGFloat = 57
        static let paperButtonBottomMargin: CGFloat = 125
    }
    
    private enum VariantHand: String, CaseIterable {
        case rock = "Rock"
        case paper = "Paper"
        case scissors = "Scissors"
        
        static func random() -> VariantHand {
            return VariantHand.allCases.randomElement()!
        }
        
        func imageName(for player: String) -> String {
            return "\(player) hand \(self.rawValue.lowercased())"
        }
    }
    
    // MARK: - Private Layout
    private let maleHandImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let femaleHandImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let timerlProgressView = VerticalProgressView()
    private let battleProgressView = BattleVerticalProgressView()
    
    private let roundTimeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        return label
    }()
    
    private let rockButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "Rock"), for: .normal)
        button.setImage(UIImage(named: "Rock_chosen"), for: .highlighted)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .black
        return button
    }()
    
    private let paperButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "Paper"), for: .normal)
        button.setImage(UIImage(named: "Paper_chosen"), for: .highlighted)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .black
        return button
    }()
    
    private let scissorsButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "Scissors"), for: .normal)
        button.setImage(UIImage(named: "Scissors_chosen"), for: .highlighted)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .black
        return button
    }()
    
    private var pauseView = PauseView()
    
    // MARK: - Private Properties
    private var timer: Timer?
    private var roundTime: Int = Constants.roundTime
    private var elapsedTime: Int = 0
    private var isPaused = false
    
    private var playerScore = 0
    private var computerScore = 0
    
    private var maleHandTopConstraint: NSLayoutConstraint!
    private var femaleHandBottomConstraint: NSLayoutConstraint!
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
        roundTime = DefaultsSettings.roundTime ?? Constants.roundTime
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        startTimer()
    }
}

private extension FightViewController {
    // MARK: - Setup Methods
    func initialize() {
        setupView()
        cofigurePauseView()
        setupConstraints()
        setBackground(imageName: "fight background")
        loadRoundTime()
        configureNavigationBar()
        battleProgressView.trackColor = .cyan
        battleProgressView.progressColor = .orange
        timerlProgressView.progressColor = .green
        timerlProgressView.trackColor = .darkGray
        battleProgressView.progress = 0.5
        
        rockButton.addTarget(self, action: #selector(rockButtonTapped), for: .touchUpInside)
        paperButton.addTarget(self, action: #selector(paperButtonTapped), for: .touchUpInside)
        scissorsButton.addTarget(self, action: #selector(scissorsButtonTapped), for: .touchUpInside)
    }
    
    func setupView() {
        view.addSubview(femaleHandImageView)
        view.addSubview(maleHandImageView)
        view.addSubview(timerlProgressView)
        view.addSubview(battleProgressView)
        view.addSubview(roundTimeLabel)
        view.addSubview(rockButton)
        view.addSubview(paperButton)
        view.addSubview(scissorsButton)
        view.addSubview(pauseView)
        resetHands()
    }
    
    func cofigurePauseView() {
        pauseView.configure(with: .init(maleScore: playerScore, femaleScore: computerScore, actionHandler: { [weak self] action in
            guard let self = self else { return }
            switch action {
            case .play:
                
                self.hidePauseView()
            case .restart:
                break
            case .goToHome:
                break
            }
        }))
            
        pauseView.translatesAutoresizingMaskIntoConstraints = false
        pauseView.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
        pauseView.alpha = 0
    }
    
    
    func setBackground(imageName: String) {
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: imageName)
        backgroundImage.contentMode = .scaleAspectFill
        view.insertSubview(backgroundImage, at: 0) // Вставляем изображение на задний план
    }
    
    func loadRoundTime() {
        roundTimeLabel.text = "0:\(Constants.roundTime)"
    }
    
    
    
    // MARK: - Timer Methods
    func startTimer() {
        elapsedTime = 0
        updateProgress()
        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    @objc func updateTimer() {
        elapsedTime += 1
        if elapsedTime >= roundTime {
            timer?.invalidate()
            timer = nil
            computerScore += 1
            updateScore()
            startTimer()
            
            if playerScore >= 3 || computerScore >= 3 {
                endGame()
            }
        }
        updateProgress()
    }
    
    func updateProgress() {
        let remainingTime = roundTime - elapsedTime
        let progress = Float(remainingTime) / Float(roundTime)
        timerlProgressView.setProgress(progress, animated: true)
        let minutes = remainingTime / 60
        let seconds = remainingTime % 60
        roundTimeLabel.text = String(format: "%2d:%02d", minutes, seconds)
    }
    
    // MARK: - Game Logic
    private func playerChose(_ choice: VariantHand) {
        let computerChoice = VariantHand.random()
        
        maleHandImageView.image = UIImage(named: choice.imageName(for: "male"))
        femaleHandImageView.image = UIImage(named: computerChoice.imageName(for: "female"))
        
        determineWinner(playerChoice: choice, computerChoice: computerChoice)
        
        animateHands()
    }
    
    private func determineWinner(playerChoice: VariantHand, computerChoice: VariantHand) {
        guard playerChoice != computerChoice else { return }
        // It's a tie, do nothing
        if (playerChoice == .rock && computerChoice == .scissors) ||
            (playerChoice == .scissors && computerChoice == .paper) ||
            (playerChoice == .paper && computerChoice == .rock) {
            playerScore += 1
        } else {
            computerScore += 1
        }
        
        updateScore()
        
        if playerScore >= 3 || computerScore >= 3 {
            endGame()
        }
    }
    
    func updateScore() {
        let totalRounds = playerScore + computerScore
        let playerProgress = Float(playerScore) / Float(totalRounds)
        battleProgressView.setProgress(playerProgress, animated: true)
    }
    
    func endGame() {
        timer?.invalidate()
        timer = nil
        
        let winner = playerScore > computerScore ? "Player" : "Computer"
        let alert = UIAlertController(title: "Game Over", message: "\(winner) wins!", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
            self.resetGame()
        }))
        
        
        present(alert, animated: true, completion: nil)
    }
    
    func resetGame() {
        playerScore = 0
        computerScore = 0
        battleProgressView.setProgress(0.5, animated: true)
    }
    
    func animateHands() {
        let originalMaleTopConstraint = maleHandTopConstraint.constant
        let originalFemaleBottomConstraint = femaleHandBottomConstraint.constant
        
        maleHandTopConstraint.constant = Constants.maleHandToCenterOffset
        femaleHandBottomConstraint.constant = Constants.femaleHandToCenterOffset
        
        UIView.animate(withDuration: 0.5, animations: {
            self.view.layoutIfNeeded()
        }) { _ in
            self.maleHandTopConstraint.constant = originalMaleTopConstraint
            self.femaleHandBottomConstraint.constant = originalFemaleBottomConstraint
            
            UIView.animate(withDuration: 0.5, animations: {
                self.view.layoutIfNeeded()
            }) { _ in
                self.resetHands()
                self.timer?.invalidate()
                self.startTimer()
            }
        }
    }
    
    func resetHands() {
        maleHandImageView.image = UIImage(named: "male hand")
        femaleHandImageView.image = UIImage(named: "female hand")
    }
    
    // MARK: - Button Actions
    @objc func rockButtonTapped() {
        playerChose(.rock)
    }
    
    @objc func paperButtonTapped() {
        playerChose(.paper)
    }
    
    @objc func scissorsButtonTapped() {
        playerChose(.scissors)
    }
    
    @objc func pauseButtonTapped() {
        showPauseView()
    }
    // MARK: - Configure NavigationBar
    func configureNavigationBar() {
        self.navigationItem.rightBarButtonItem = configureBarButtonItem()
        self.navigationItem.hidesBackButton = true
        
    }
    
    func configureBarButtonItem() -> UIBarButtonItem {
        let navigationItem = UIBarButtonItem(image: UIImage(named: "Pause"), style: .done, target: self, action: #selector(pauseButtonTapped))
        navigationItem.tintColor = .black
        return navigationItem
    }
    
    //MARK: - PasueView Show
    
    func showPauseView() {
        timer?.invalidate()
        pauseView.isHidden = false
        UIView.animate(withDuration: 0.3, animations: {
            self.pauseView.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            self.pauseView.alpha = 1.0
        })
    }
    
    func hidePauseView() {
        startTimer()
        UIView.animate(withDuration: 0.3, animations: {
            self.pauseView.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
            self.pauseView.alpha = 0.0
        }) { _ in
            self.pauseView.isHidden = true
        }
    }
}

// MARK: - Setup Contraints
private extension FightViewController {
    
    func setupConstraints() {
        timerlProgressView.translatesAutoresizingMaskIntoConstraints = false
        battleProgressView.translatesAutoresizingMaskIntoConstraints = false
        roundTimeLabel.translatesAutoresizingMaskIntoConstraints = false
        
        battleProgressView.setImages(topImage: UIImage(named: "Player 1")!, bottomImage: UIImage(named: "Player 2")!)
        
        NSLayoutConstraint.activate([
            femaleHandImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.leadingMargin),
            femaleHandImageView.widthAnchor.constraint(equalToConstant: Constants.handImageWidth),
            femaleHandImageView.heightAnchor.constraint(equalToConstant: Constants.handImageHeight)
        ])
        femaleHandBottomConstraint = femaleHandImageView.bottomAnchor.constraint(equalTo: view.centerYAnchor, constant: Constants.femaleHandInitialBottomConstant)
        femaleHandBottomConstraint.isActive = true
        
        NSLayoutConstraint.activate([
            maleHandImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.leadingMargin + 45),
            maleHandImageView.widthAnchor.constraint(equalToConstant: Constants.handImageWidth),
            maleHandImageView.heightAnchor.constraint(equalToConstant: Constants.handImageHeight)
        ])
        maleHandTopConstraint = maleHandImageView.topAnchor.constraint(equalTo: view.centerYAnchor, constant: Constants.maleHandInitialTopConstant)
        maleHandTopConstraint.isActive = true
        
        NSLayoutConstraint.activate([
            timerlProgressView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            timerlProgressView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            timerlProgressView.heightAnchor.constraint(equalToConstant: 166),
            timerlProgressView.widthAnchor.constraint(equalToConstant: 9)
        ])
        
        NSLayoutConstraint.activate([
            battleProgressView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            battleProgressView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            battleProgressView.heightAnchor.constraint(equalToConstant: 300),
            battleProgressView.widthAnchor.constraint(equalToConstant: 9)
        ])
        
        NSLayoutConstraint.activate([
            roundTimeLabel.centerXAnchor.constraint(equalTo: timerlProgressView.centerXAnchor),
            roundTimeLabel.topAnchor.constraint(equalTo: timerlProgressView.bottomAnchor, constant: 10)
        ])
        
        NSLayoutConstraint.activate([
            rockButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.buttonBottomMargin),
            rockButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -Constants.buttonBottomMargin),
            rockButton.heightAnchor.constraint(equalToConstant: Constants.buttonSize),
            rockButton.widthAnchor.constraint(equalToConstant: Constants.buttonSize)
        ])
        
        NSLayoutConstraint.activate([
            paperButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            paperButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -Constants.paperButtonBottomMargin),
            paperButton.heightAnchor.constraint(equalToConstant: Constants.buttonSize),
            paperButton.widthAnchor.constraint(equalToConstant: Constants.buttonSize)
        ])
        
        NSLayoutConstraint.activate([
            scissorsButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.buttonBottomMargin),
            scissorsButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -Constants.buttonBottomMargin),
            scissorsButton.heightAnchor.constraint(equalToConstant: Constants.buttonSize),
            scissorsButton.widthAnchor.constraint(equalToConstant: Constants.buttonSize)
        ])
        
        NSLayoutConstraint.activate([
            pauseView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            pauseView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            pauseView.widthAnchor.constraint(equalToConstant: 200),
            pauseView.heightAnchor.constraint(equalToConstant: 200)
        ])
    }
    
}


import SwiftUI



struct FightViewControllerRepresentable: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> FightViewController {
        return FightViewController()
    }
    
    func updateUIViewController(_ uiViewController: FightViewController, context: Context) {
        
    }
}


struct FightViewControllerPreview: View {
    var body: some View {
        FightViewControllerRepresentable()
            .edgesIgnoringSafeArea(.all)
    }
}


struct FightViewControllerPreview_Previews: PreviewProvider {
    static var previews: some View {
        FightViewControllerPreview()
    }
}
