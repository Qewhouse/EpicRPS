import UIKit

final class BattleVerticalProgressView: VerticalProgressView {
    
    private let topPersonImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let bottomPersonImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let centerLineView: UIView = {
        let view = UIView()
        view.backgroundColor = .white // Установите цвет линии по вашему выбору
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
        setupConstraints()
    }
    
    // Метод для установки изображений
    public func setImages(topImage: UIImage, bottomImage: UIImage) {
        topPersonImageView.image = topImage
        bottomPersonImageView.image = bottomImage
    }
    
    private func setupViews() {
        addSubview(topPersonImageView)
        addSubview(bottomPersonImageView)
        addSubview(centerLineView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            // Constraints for topPersonImageView
            topPersonImageView.topAnchor.constraint(equalTo: topAnchor),
            topPersonImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            topPersonImageView.widthAnchor.constraint(equalToConstant: 30),
            topPersonImageView.heightAnchor.constraint(equalToConstant: 30),
            
            // Constraints for bottomPersonImageView
            bottomPersonImageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            bottomPersonImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            bottomPersonImageView.widthAnchor.constraint(equalToConstant: 30),
            bottomPersonImageView.heightAnchor.constraint(equalToConstant: 30),
            
            // Constraints for centerLineView
            centerLineView.centerYAnchor.constraint(equalTo: centerYAnchor),
            centerLineView.centerXAnchor.constraint(equalTo: centerXAnchor),
            centerLineView.widthAnchor.constraint(equalToConstant: 15),
            centerLineView.heightAnchor.constraint(equalToConstant: 2)
        ])
    }
}
