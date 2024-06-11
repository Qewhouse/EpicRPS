//
//  WinLooseViewController.swift
//  EpicRPS
//
//  Created by mac41 on 11/6/2024.
//

import UIKit

final class WinLooseViewController: UIViewController {
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
    
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraints()
    }
    
    
    // MARK: - Private Methods
    private func setupUI() {
        view.layer.insertSublayer(gradientLayer, at: 0)
    }
    
}

// MARK: - Setup Constraints
private extension WinLooseViewController {
    private func setupConstraints() {
        
    }
}

