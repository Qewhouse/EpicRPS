//
//  VerticalProgressView.swift
//  EpicRPS
//
//  Created by Станислав Артамонов on 10.06.24.
//

import UIKit

// MARK: - VerticalProgressView
class VerticalProgressView: UIView {
    
    // MARK: - Private Properties
    private let progressView: UIProgressView = {
        let progressView = UIProgressView()
        progressView.translatesAutoresizingMaskIntoConstraints = false
        progressView.transform = CGAffineTransform(rotationAngle: .pi * -0.5)
        return progressView
    }()
    
    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }
    
    // MARK: - Public Properties
    public var progress: Float {
        get {
            return progressView.progress
        }
        set {
            progressView.progress = newValue
        }
    }
    
    public var trackColor: UIColor {
        get {
            return progressView.trackTintColor ?? .clear
        }
        set {
            progressView.trackTintColor = newValue
        }
    }
    
    public var progressColor: UIColor {
        get {
            return progressView.progressTintColor ?? .clear
        }
        set {
            progressView.progressTintColor = newValue
        }
    }
    
    // MARK: - Public Methods
    public func setProgress(_ progress: Float, animated: Bool = true) {
        progressView.setProgress(progress, animated: animated)
    }
    
    // MARK: - Private Methods
    private  func setupViews() {
        addSubview(progressView)
        layoutForProgressView()
    }
    
    private func layoutForProgressView() {
        NSLayoutConstraint.activate([
            progressView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            progressView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            progressView.widthAnchor.constraint(equalTo: self.heightAnchor),
            progressView.heightAnchor.constraint(equalTo: self.widthAnchor)
        ])
    }
}
