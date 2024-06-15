//
//  FightViewController.swift
//  EpicRPS
//
//  Created by Станислав Артамонов on 10.06.24.
//
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
        static let pauseViewButtonWight: CGFloat = 200
        static let pauseViewButtonHeight: CGFloat = 200
        static let fightDrawImageViewSizeHeight: CGFloat = 150
        static let fightDrawImageViewSizeWight: CGFloat = 200
        static let timerProgressViewHeight: CGFloat = 166
        static let timerProgressViewWeght: CGFloat = 9
        static let battleProgressViewHeight: CGFloat = 250
        static let battleProgressViewWight: CGFloat = 9
    }
    
    private enum VariantHand: String, CaseIterable {
        case rock = "Rock"
        case paper = "Paper"
        case scissors = "Scissors"
        
        static func random() -> VariantHand {
            VariantHand.allCases.randomElement()!
        }
        
        func imageName(for player: String) -> String {
            "\(player) hand \(self.rawValue.lowercased())"
        }
        
        func imageNameChoisenButton() -> String {
            self.rawValue + "_chosen"
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
    
    private let fightImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "fight")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let drowImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "draw")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let bloodImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(named: "blood")
        return imageView
    }()
    
    private let timerlProgressView = VerticalProgressView()
    private let battleProgressView = DualPlayerProgressView()
    
    private let roundTimeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        return label
    }()
    
    private let femaleScoreLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        return label
    }()
    
    private let maleScoreLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        return label
    }()
    
    private let rockButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "Rock"), for: .normal)
        button.setImage(UIImage(named: "Rock_chosen"), for: .highlighted)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .black
        return button
    }()
    
    private let paperButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "Paper"), for: .normal)
        button.setImage(UIImage(named: "Paper_chosen"), for: .highlighted)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .black
        return button
    }()
    
    private let scissorsButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "Scissors"), for: .normal)
        button.setImage(UIImage(named: "Scissors_chosen")?.withRenderingMode(.alwaysOriginal), for: .highlighted)
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.resetGame()
        self.timerlProgressView.progress = Float(DefaultsSettings.roundTime!)
        loadRoundTime()
        navigationController?.isNavigationBarHidden = false
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        startTimerAndHideFight()
    }
}

//MARK: - Private methods
private extension FightViewController {
    // MARK: - Setup Methods
    func initialize() {
        setupView()
        cofigurePauseView()
        setupConstraints()
        setBackground(imageName: "fight background")
        loadRoundTime()
        configureButton()
        configureNavigationBar()
        resetHands()
        configureProgressView()
        updateScoreLabel()
        bloodImageView.isHidden = true
    }
    
    func setupView() {
        view.addSubview(femaleHandImageView)
        view.addSubview(bloodImageView)
        view.addSubview(maleHandImageView)
        view.addSubview(timerlProgressView)
        view.addSubview(battleProgressView)
        view.addSubview(roundTimeLabel)
        view.addSubview(rockButton)
        view.addSubview(paperButton)
        view.addSubview(scissorsButton)
        view.addSubview(drowImageView)
        view.addSubview(fightImageView)
        view.addSubview(maleScoreLabel)
        view.addSubview(femaleScoreLabel)
        view.addSubview(pauseView)
    }
    
    func cofigurePauseView() {
        configurePauseViewModel()
        pauseView.translatesAutoresizingMaskIntoConstraints = false
        pauseView.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
        pauseView.alpha = 0
    }
    
    func configurePauseViewModel() {
        pauseView.configure(with: .init(maleScore: playerScore, femaleScore: computerScore, actionHandler: { [weak self] action in
            guard let self = self else { return }
            switch action {
            case .play:
                self.resumeGame()
            case .restart:
                self.restartInPauseView()
            case .goToHome:
                self.navigationController?.popToRootViewController(animated: true)
            }
        }))
    }
    
    func setBackground(imageName: String) {
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: imageName)
        backgroundImage.contentMode = .scaleAspectFill
        view.insertSubview(backgroundImage, at: 0)
        drowImageView.isHidden = true
    }
    
    func loadRoundTime() {
        let minutes =  DefaultsSettings.roundTime! / 60
        let seconds =  DefaultsSettings.roundTime! % 60
        roundTimeLabel.text = String(format: "%2d:%02d", minutes, seconds)
    }
    
    func configureButton() {
        rockButton.addTarget(self, action: #selector(rockButtonTapped), for: .touchUpInside)
        paperButton.addTarget(self, action: #selector(paperButtonTapped), for: .touchUpInside)
        scissorsButton.addTarget(self, action: #selector(scissorsButtonTapped), for: .touchUpInside)
    }
    
    func configureProgressView() {
       timerlProgressView.progressColor = .green
       timerlProgressView.trackColor = .darkGray
        battleProgressView.updateProgress(player1Score: 0, player2Score: 0)
        timerlProgressView.translatesAutoresizingMaskIntoConstraints = false
        battleProgressView.translatesAutoresizingMaskIntoConstraints = false
        roundTimeLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func startTimerAndHideFight() {
        self.fightImageView.isHidden = false
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.fightImageView.isHidden = true
            self.startTimer()
        }
    }
    
    // MARK: - Timer Methods
    func startTimer() {
        elapsedTime = 0
        updateProgress()
        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    @objc func updateTimer() {
        elapsedTime += 1
        if playerScore == 3 || computerScore == 3 {
            timer?.invalidate()
            timer = nil
        }
        
        if elapsedTime >= roundTime{
            timer?.invalidate()
            timer = nil
            computerScore += 1
            updateScore()
            if playerScore == 3 || computerScore == 3 {
                endGame()
            } else {
                startTimer()
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
    
    func showDrow() {
        drowImageView.isHidden = false
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
            self?.drowImageView.isHidden = true
            self?.nextRound()
        }
    }
    
    // MARK: - Game Logic
    private func playerChose(_ choice: VariantHand) {
        let computerChoice = VariantHand.random()
        selectedButton(choice)
        timer?.invalidate()
        maleHandImageView.image = UIImage(named: choice.imageName(for: "male"))
        femaleHandImageView.image = UIImage(named: computerChoice.imageName(for: "female"))
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self ] in
            self?.determineWinner(playerChoice: choice, computerChoice: computerChoice)
        }
    }
    
    private func determineWinner(playerChoice: VariantHand, computerChoice: VariantHand) {
        guard playerChoice != computerChoice else {
            showDrow()
            return }
        
        if (playerChoice == .rock && computerChoice == .scissors) ||
            (playerChoice == .scissors && computerChoice == .paper) ||
            (playerChoice == .paper && computerChoice == .rock) {
            playerScore += 1
        } else {
            computerScore += 1
        }
        animateHands()
        updateScore()
        updateScoreLabel()
       
    }
    
    func updateScore() {
        battleProgressView.updateProgress(player1Score: playerScore, player2Score: computerScore)
    }
    
    func endGame() {
        timer?.invalidate()
        timer = nil
        updateTotalScore()
        let winner = playerScore > computerScore ? "Player" : "Computer"
        let winLooseVC = ResultsViewController()
        winLooseVC.leftScore = self.playerScore
        winLooseVC.rightScore = self.computerScore
        winLooseVC.outcome = playerScore > computerScore
        navigationController?.pushViewController(winLooseVC, animated: true)
    }
    
    func updateTotalScore() {
        if playerScore > computerScore {
            DefaultsSettings.maleWinPlayerScore! += 1
            DefaultsSettings.femaleLoosePlayerScore! += 1
        } else {
            DefaultsSettings.femaleWinPlayerScore! += 1
            DefaultsSettings.maleLoosePlayerScore! += 1
        }
    }
    
    func resetGame() {
        timer?.invalidate()
        timer = nil
        playerScore = 0
        computerScore = 0
        updateScoreLabel()
        battleProgressView.updateProgress(player1Score: 0, player2Score: 0)
    }
    
    func animateHands() {
        let originalMaleTopConstraint = maleHandTopConstraint.constant
        let originalFemaleBottomConstraint = femaleHandBottomConstraint.constant
        
        maleHandTopConstraint.constant = Constants.maleHandToCenterOffset
        femaleHandBottomConstraint.constant = Constants.femaleHandToCenterOffset
        
        UIView.animate(withDuration: 0.5, animations: {
            self.view.layoutIfNeeded()
        }) { _ in
            
            self.bloodImageView.isHidden = false
            self.bloodImageView.alpha = 1.0
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
                UIView.animate(withDuration: 0.5, animations: {
                    self.maleHandTopConstraint.constant = originalMaleTopConstraint
                    self.femaleHandBottomConstraint.constant = originalFemaleBottomConstraint
                    self.view.layoutIfNeeded()
                    self.bloodImageView.alpha = 0.0
                    if self.computerScore == 3 || self.playerScore == 3 {
                        self.endGame()
                    }
                }) { _ in
                    self.bloodImageView.isHidden = true
                    if self.computerScore != 3 || self.playerScore != 3 {
                        self.nextRound()
                    }
                }
            }
        }
    }
    
    func resetHands() {
        maleHandImageView.image = UIImage(named: "male hand")
        femaleHandImageView.image = UIImage(named: "female hand")
    }
    
    func updateScoreLabel() {
        femaleScoreLabel.text = String(computerScore)
        maleScoreLabel.text = String(playerScore)
    }
    
    func nextRound() {
        self.resetHands()
        self.timer?.invalidate()
        self.startTimer()
        self.selectedButton(nil)
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
    
    private func selectedButton(_ with: VariantHand?) {
        guard let with = with else {
            setupBaseImageButton()
            return
        }
        [rockButton, paperButton, scissorsButton].forEach() { $0.isUserInteractionEnabled = false }
        
        switch with {
        case .rock:
            rockButton.setImage(UIImage(named: VariantHand.rock.imageNameChoisenButton()), for: .normal)
        case .paper:
            paperButton.setImage(UIImage(named: VariantHand.paper.imageNameChoisenButton()), for: .normal)
        case .scissors:
            scissorsButton.setImage(UIImage(named: VariantHand.scissors.imageNameChoisenButton()), for: .normal)
        default:
            break
        }
    }
    
    func setupBaseImageButton() {
        [rockButton, paperButton, scissorsButton].forEach() { $0.isUserInteractionEnabled = true }
        rockButton.setImage(UIImage(named: VariantHand.rock.rawValue), for: .normal)
        paperButton.setImage(UIImage(named: VariantHand.paper.rawValue), for: .normal)
        scissorsButton.setImage(UIImage(named: VariantHand.scissors.rawValue), for: .normal)
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
        configurePauseViewModel()
        timer?.invalidate()
        pauseView.isHidden = false
        UIView.animate(withDuration: 0.3, animations: {
            self.pauseView.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            self.pauseView.alpha = 1.0
        })
    }
    
    func hidePauseView() {
        UIView.animate(withDuration: 0.3, animations: {
            self.pauseView.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
            self.pauseView.alpha = 0.0
        }) { _ in
            self.pauseView.isHidden = true
        }
    }
    
    func resumeGame() {
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
        hidePauseView()
    }
    
    func restartInPauseView() {
        hidePauseView()
        resetGame()
        startTimer()
    }
}

// MARK: - Setup Contraints
private extension FightViewController {
    
    func setupConstraints() {
        
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
            timerlProgressView.heightAnchor.constraint(equalToConstant: Constants.timerProgressViewHeight),
            timerlProgressView.widthAnchor.constraint(equalToConstant: Constants.timerProgressViewWeght),
            
            battleProgressView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            battleProgressView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            battleProgressView.heightAnchor.constraint(equalToConstant: Constants.battleProgressViewHeight),
            battleProgressView.widthAnchor.constraint(equalToConstant: Constants.battleProgressViewWight),
            
            roundTimeLabel.centerXAnchor.constraint(equalTo: timerlProgressView.centerXAnchor),
            roundTimeLabel.topAnchor.constraint(equalTo: timerlProgressView.bottomAnchor, constant: 10),

            rockButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.buttonBottomMargin),
            rockButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -Constants.buttonBottomMargin),
            rockButton.heightAnchor.constraint(equalToConstant: Constants.buttonSize),
            rockButton.widthAnchor.constraint(equalToConstant: Constants.buttonSize),
            
            paperButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            paperButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -Constants.paperButtonBottomMargin),
            paperButton.heightAnchor.constraint(equalToConstant: Constants.buttonSize),
            paperButton.widthAnchor.constraint(equalToConstant: Constants.buttonSize),
            
            scissorsButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.buttonBottomMargin),
            scissorsButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -Constants.buttonBottomMargin),
            scissorsButton.heightAnchor.constraint(equalToConstant: Constants.buttonSize),
            scissorsButton.widthAnchor.constraint(equalToConstant: Constants.buttonSize),
            
            drowImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            drowImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            drowImageView.widthAnchor.constraint(equalToConstant:  Constants.fightDrawImageViewSizeWight),
            drowImageView.heightAnchor.constraint(equalToConstant: Constants.fightDrawImageViewSizeHeight),
            
            fightImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            fightImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            fightImageView.widthAnchor.constraint(equalToConstant: Constants.fightDrawImageViewSizeWight),
            fightImageView.heightAnchor.constraint(equalToConstant: Constants.fightDrawImageViewSizeHeight),
            
            bloodImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            bloodImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            bloodImageView.widthAnchor.constraint(equalToConstant: 250),
            bloodImageView.heightAnchor.constraint(equalToConstant: 250)
        ])
    }
}

