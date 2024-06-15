import UIKit

final class DualPlayerProgressView: UIView {
    private let firstPlayerProgress = UIView()
    private let secondPlayerProgress = UIView()
    private let totalSections: CGFloat = 6
    private let secondPlayerImageView = UIImageView(image: .player1)
    private let firstdPlayerFaceImageView = UIImageView(image: .player2)
    private let centerLineView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupProgressView()
        secondPlayerImageView.contentMode = .scaleAspectFit
        firstdPlayerFaceImageView.contentMode = .scaleAspectFit
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupProgressView()
        setupConstraints()
    }

    private func setupProgressView() {
        self.backgroundColor = UIColor.darkGray

        firstPlayerProgress.backgroundColor = UIColor.orange
        firstPlayerProgress.translatesAutoresizingMaskIntoConstraints = false
        firstPlayerProgress.layer.cornerRadius = 5
        firstPlayerProgress.clipsToBounds = true
        self.addSubview(firstPlayerProgress)
        
        secondPlayerProgress.backgroundColor = UIColor.cyan
        secondPlayerProgress.translatesAutoresizingMaskIntoConstraints = false
        secondPlayerProgress.layer.cornerRadius = 5
        secondPlayerProgress.clipsToBounds = true
        self.addSubview(secondPlayerProgress)

        secondPlayerImageView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(secondPlayerImageView)
        
        firstdPlayerFaceImageView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(firstdPlayerFaceImageView)
        
        self.addSubview(centerLineView)
    }

    func updateProgress(player1Score: Int, player2Score: Int) {
        guard player1Score >= 0 && player1Score <= 6 && player2Score >= 0 && player2Score <= 6 else {
            return
        }

        let sectionHeight = self.frame.height / totalSections
        
        UIView.animate(withDuration: 0.2) {
            self.firstPlayerProgress.frame.size.height = CGFloat(player1Score) * sectionHeight
            self.firstPlayerProgress.frame.origin.y = self.frame.height - self.firstPlayerProgress.frame.size.height

            self.secondPlayerProgress.frame.size.height = CGFloat(player2Score) * sectionHeight
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        firstPlayerProgress.frame = CGRect(x: 0, y: self.frame.height - firstPlayerProgress.frame.height, width: self.frame.width, height: firstPlayerProgress.frame.height)
        secondPlayerProgress.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: secondPlayerProgress.frame.height)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            secondPlayerImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            secondPlayerImageView.bottomAnchor.constraint(equalTo: self.topAnchor, constant: 0),
            secondPlayerImageView.widthAnchor.constraint(equalToConstant: 40),
            secondPlayerImageView.heightAnchor.constraint(equalToConstant: 40),
            
            firstdPlayerFaceImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            firstdPlayerFaceImageView.topAnchor.constraint(equalTo: self.bottomAnchor, constant: 0),
            firstdPlayerFaceImageView.widthAnchor.constraint(equalToConstant: 40),
            firstdPlayerFaceImageView.heightAnchor.constraint(equalToConstant: 40),
            
            centerLineView.centerYAnchor.constraint(equalTo: centerYAnchor),
            centerLineView.centerXAnchor.constraint(equalTo: centerXAnchor),
            centerLineView.widthAnchor.constraint(equalToConstant: 15),
            centerLineView.heightAnchor.constraint(equalToConstant: 2)
        ])
    }
}
