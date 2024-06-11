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
            topPersonImageView.widthAnchor.constraint(equalToConstant: 30), // Установите ширину изображения по вашему выбору
            topPersonImageView.heightAnchor.constraint(equalToConstant: 30), // Установите высоту изображения по вашему выбору
            
            // Constraints for bottomPersonImageView
            bottomPersonImageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            bottomPersonImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            bottomPersonImageView.widthAnchor.constraint(equalToConstant: 30), // Установите ширину изображения по вашему выбору
            bottomPersonImageView.heightAnchor.constraint(equalToConstant: 30), // Установите высоту изображения по вашему выбору
            
            // Constraints for centerLineView
            centerLineView.centerYAnchor.constraint(equalTo: centerYAnchor),
            centerLineView.centerXAnchor.constraint(equalTo: centerXAnchor),
            centerLineView.widthAnchor.constraint(equalToConstant: 15), // Установите ширину линии по вашему выбору
            centerLineView.heightAnchor.constraint(equalToConstant: 2) // Установите высоту линии
        ])
    }
}
