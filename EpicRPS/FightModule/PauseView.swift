//
//  PauseView.swift
//  EpicRPS
//
//  Created by Станислав Артамонов on 12.06.24.
//

import UIKit
final class PauseView: UIView {
    // MARK: - Dependencies
    var leftScore: Int = 0
    var rightScore: Int = 0
    let screenWidth = UIScreen.main.bounds.size.width
    let screenHeight = UIScreen.main.bounds.size.height
    
    //MARK: - Private properties
    private var viewModel: PauseModel?
    private let buttonStackView = UIStackView()
    private let homeButton = UIButton(type: .system)
    private let restartButton = UIButton(type: .system)
    private let playButton = UIButton(type: .system)
    private var superView: UIView?
    
    private lazy var player1View: UIImageView = {
        let element = UIImageView()
        element.image = UIImage(named: "Player 1")
        element.contentMode = .scaleAspectFit
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var player2View: UIImageView = {
        let element = UIImageView()
        element.image = UIImage(named: "Player 2")
        element.contentMode = .scaleAspectFit
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var vsView: UIImageView = {
        let element = UIImageView()
        element.image = UIImage(named: "vs")
        element.contentMode = .scaleAspectFit
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var blurEffectView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .light)
        let view = UIVisualEffectView(effect: blurEffect)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var resultLabel: UILabel = {
        let element = UILabel()
        element.text = "\(leftScore) - \(rightScore)"
        element.font = UIFont.systemFont(ofSize: 70, weight: .heavy)
        element.textColor = UIColor(named: "labelColour")
        element.textAlignment = .center
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var mainStackView: UIStackView = {
        let element = UIStackView()
        element.axis = .vertical
        element.spacing = 40
        element.distribution = .fillProportionally
        element.alignment = .center
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()

    private lazy var imageStackView: UIStackView = {
        let element = UIStackView()
        element.axis = .horizontal
        element.spacing = 10
        element.distribution = .fillEqually
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    //MARK: - Init
    init(model: PauseModel? = nil, superView: UIView) {
        self.viewModel = model
        self.superView = superView
        super.init(frame: .zero)
        initialize()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with model: PauseModel) {
        self.viewModel = model
        self.leftScore = model.femaleScore
        self.rightScore = model.maleScore
        resultLabel.text = "\(leftScore) - \(rightScore)"
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupContraints()
    }
}

private extension PauseView {
    func initialize() {
        setupViews()
        configureButtonStackView()
        configureButtons()
        layer.cornerRadius = 20
        clipsToBounds = true
    }
    
    func setupViews() {
        addSubview(blurEffectView)
        addSubview(mainStackView)
        
        mainStackView.addArrangedSubview(imageStackView)
        mainStackView.addArrangedSubview(resultLabel)
        mainStackView.addArrangedSubview(buttonStackView)
        
        imageStackView.addArrangedSubview(player1View)
        imageStackView.addArrangedSubview(vsView)
        imageStackView.addArrangedSubview(player2View)
    }
    
    func setupContraints() {
        NSLayoutConstraint.activate([
            self.heightAnchor.constraint(equalToConstant: screenHeight),
            self.widthAnchor.constraint(equalToConstant: screenWidth),
            
            blurEffectView.heightAnchor.constraint(equalToConstant: screenHeight),
            blurEffectView.widthAnchor.constraint(equalToConstant: screenWidth),
            
            mainStackView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            mainStackView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            mainStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 50),
            mainStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -50),
            mainStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -300),
            mainStackView.topAnchor.constraint(equalTo: topAnchor, constant: 300),
            
            resultLabel.heightAnchor.constraint(equalToConstant: 70),
            
            buttonStackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            buttonStackView.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
    
    func configureButtonStackView() {
        buttonStackView.axis = .horizontal
        buttonStackView.spacing = 10
        buttonStackView.distribution = .fillEqually
        buttonStackView.translatesAutoresizingMaskIntoConstraints = false
        buttonStackView.addArrangedSubview(homeButton)
        buttonStackView.addArrangedSubview(restartButton)
        buttonStackView.addArrangedSubview(playButton)
    }
    
    func configureButtons() {
        homeButton.setImage(UIImage(named: "Home"), for: .normal)
        restartButton.setImage(UIImage(named: "Restart"), for: .normal)
        playButton.setImage(UIImage(named: "Play")?.withRenderingMode(.alwaysOriginal), for: .normal)
        
        homeButton.imageView?.contentMode = .scaleAspectFit
        restartButton.imageView?.contentMode = .scaleAspectFit
        playButton.imageView?.contentMode = .scaleAspectFit
        
        playButton.addTarget(self, action: #selector(tappedPlaytButton), for: .touchUpInside)
        restartButton.addTarget(self, action: #selector(tappedRestartButton), for: .touchUpInside)
        homeButton.addTarget(self, action: #selector(tappedHomeButton), for: .touchUpInside)
    }
    
    //MARK: - Button Metohds
    @objc func tappedHomeButton() {
        self.viewModel?.actionHandler(.goToHome)
    }
    @objc func tappedRestartButton() {
        self.viewModel?.actionHandler(.restart)
    }
    
    @objc func tappedPlaytButton() {
        self.viewModel?.actionHandler(.play)
    }
}

extension PauseView {
    struct PauseModel {
        let maleScore: Int
        let femaleScore: Int
        let actionHandler: (PauseVariantTap) -> Void
    }
    
    enum PauseVariantTap {
        case restart
        case goToHome
        case play
    }
}
