//
//  PauseView.swift
//  EpicRPS
//
//  Created by Станислав Артамонов on 12.06.24.
//

import Foundation
import UIKit
final class PauseView: UIView {
    //MARK: - Private properties
    private var viewModel: PauseModel?
    private let buttonStackView = UIStackView()
    private let homeButton = UIButton(type: .system)
    private let restartButton = UIButton(type: .system)
    private let playButton = UIButton(type: .system)
    
    //MARK: - Init
    init(model: PauseModel? = nil) {
        self.viewModel = model
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
    }
    
}

private extension PauseView {
    func initialize() {
        setupViews()
        configureButtonStackView()
        configureButtons()
        setupContraints()
        backgroundColor = .white
        layer.cornerRadius = 10
        clipsToBounds = true
        
    }
    
    func setupViews() {
        addSubview(buttonStackView)
    }
    
    func setupContraints() {
        NSLayoutConstraint.activate([
            buttonStackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            buttonStackView.centerYAnchor.constraint(equalTo: centerYAnchor),
            buttonStackView.widthAnchor.constraint(equalToConstant: 150),
            buttonStackView.heightAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    func configureButtonStackView() {
        buttonStackView.axis = .horizontal
        buttonStackView.distribution = .equalSpacing
        buttonStackView.translatesAutoresizingMaskIntoConstraints = false
        buttonStackView.addArrangedSubview(homeButton)
        buttonStackView.addArrangedSubview(restartButton)
        buttonStackView.addArrangedSubview(playButton)
    }
    
    func configureButtons() {
        homeButton.setImage(UIImage(named: "Home"), for: .normal)
        restartButton.setImage(UIImage(named: "Restart"), for: .normal)
        playButton.setImage(UIImage(systemName: "play.circle"), for: .normal)
        
        homeButton.imageView?.contentMode = .scaleAspectFill
        restartButton.imageView?.contentMode = .scaleAspectFill
        playButton.imageView?.contentMode = .scaleAspectFill
        
        
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




