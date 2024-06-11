//
//  RulesView.swift
//  EpicRPS
//
//  Created by Валентина Попова on 10.06.2024.
//

import UIKit

class RulesView: UIView {
    
    // Инициализация представления
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Настройка пользовательского интерфейса
    func setupUI() {
        backgroundColor = .white // Установка фона
        
        // Создание и настройка всех правил
        let rule1 = createRuleLabel(text: "Игра проводится между игроком и компьютером.", number: 1)
        let rule2 = createGestureRuleLabel()
        let rule3 = createRuleLabel(text: "У игрока есть 30 сек. для выбора жеста.", number: 3)
        let rule4 = createRuleLabel(text: "Игра ведётся до трёх побед одного из участников.", number: 4)
        let rule5 = createRuleLabel(text: "За каждую победу игрок получает 500 баллов, которые можно посмотреть на доске лидеров.", number: 5, highlight: "500 баллов")
        
        // Создание вертикального стека для всех правил
        let stackView = UIStackView(arrangedSubviews: [rule1, rule2, rule3, rule4, rule5])
        stackView.axis = .vertical // Установка оси стека на вертикальную
        stackView.spacing = 16 // Установка расстояния между элементами
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        // Добавление стека на основное представление
        addSubview(stackView)
        
        // Настройка констрейнтов для стека
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 16),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
        ])
    }
    
    // Функция создания общего правила
    private func createRuleLabel(text: String, number: Int, highlight: String? = nil) -> UIView {
        let container = UIView() // Контейнер для правила
        container.translatesAutoresizingMaskIntoConstraints = false
        
        // Создание и настройка метки с номером
        let numberLabel = UILabel()
        numberLabel.text = "\(number)"
        numberLabel.font = UIFont.boldSystemFont(ofSize: 16)
        numberLabel.textAlignment = .center
        numberLabel.backgroundColor = UIColor.systemYellow
        numberLabel.layer.cornerRadius = 15
        numberLabel.layer.masksToBounds = true
        numberLabel.translatesAutoresizingMaskIntoConstraints = false
        numberLabel.widthAnchor.constraint(equalToConstant: 30).isActive = true
        numberLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        // Создание и настройка метки с текстом правила
        let textLabel = UILabel()
        let textAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 16)
        ]
        let attributedText = NSMutableAttributedString(string: text, attributes: textAttributes)
        
        // Подсветка указанного текста, если есть
        if let highlight = highlight {
            let highlightRange = (text as NSString).range(of: highlight)
            attributedText.addAttributes([.foregroundColor: UIColor(red: 35/255.0, green: 37/255.0, blue: 134/255.0, alpha: 1.0)], range: highlightRange)
        }
        
        textLabel.attributedText = attributedText
        textLabel.numberOfLines = 0
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // Создание горизонтального стека для номера и текста
        let stackView = UIStackView(arrangedSubviews: [numberLabel, textLabel])
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        // Добавление стека в контейнер
        container.addSubview(stackView)
        
        // Настройка констрейнтов для стека в контейнере
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: container.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: container.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: container.bottomAnchor)
        ])
        
        return container
    }
    
    // Функция создания правила для жестов
    private func createGestureRuleLabel() -> UIView {
        let container = UIView()
        container.translatesAutoresizingMaskIntoConstraints = false
        
        // Создание и настройка метки с номером
        let numberLabel = UILabel()
        numberLabel.text = "2"
        numberLabel.font = UIFont.boldSystemFont(ofSize: 16)
        numberLabel.textAlignment = .center
        numberLabel.backgroundColor = UIColor.systemYellow
        numberLabel.layer.cornerRadius = 15
        numberLabel.layer.masksToBounds = true
        numberLabel.translatesAutoresizingMaskIntoConstraints = false
        numberLabel.widthAnchor.constraint(equalToConstant: 30).isActive = true
        numberLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        // Создание и настройка метки с текстом "Жесты:"
        let textLabel = UILabel()
        textLabel.text = "Жесты:"
        textLabel.font = UIFont.systemFont(ofSize: 16)
        textLabel.numberOfLines = 0
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // Создание вертикального стека для жестов
        let gestureStackView = UIStackView(arrangedSubviews: [
            createGestureLabel(imageName: "Rock", text: "Кулак > Ножницы"),
            createGestureLabel(imageName: "Paper", text: "Бумага > Кулак"),
            createGestureLabel(imageName: "Scissors", text: "Ножницы > Бумага")
        ])
        gestureStackView.axis = .vertical
        gestureStackView.spacing = 8
        gestureStackView.translatesAutoresizingMaskIntoConstraints = false
        
        // Создание горизонтального стека для номера и текста
        let mainStackView = UIStackView(arrangedSubviews: [numberLabel, textLabel])
        mainStackView.axis = .horizontal
        mainStackView.spacing = 8
        mainStackView.alignment = .center
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        
        // Добавление стеков в контейнер
        container.addSubview(mainStackView)
        container.addSubview(gestureStackView)
        
        // Настройка констрейнтов для стеков в контейнере
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: container.topAnchor),
            mainStackView.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            mainStackView.trailingAnchor.constraint(equalTo: container.trailingAnchor),
            
            gestureStackView.topAnchor.constraint(equalTo: mainStackView.bottomAnchor, constant: 8),
            gestureStackView.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 38), // Смещение вправо от цифры
            gestureStackView.trailingAnchor.constraint(equalTo: container.trailingAnchor),
            gestureStackView.bottomAnchor.constraint(equalTo: container.bottomAnchor)
        ])
        
        return container
    }
    
    // Функция создания метки для жеста с изображением
    private func createGestureLabel(imageName: String, text: String) -> UIView {
        let container = UIView()
        container.translatesAutoresizingMaskIntoConstraints = false
        
        // Создание и настройка ImageView с изображением жеста
        let imageView = UIImageView()
        imageView.image = UIImage(named: imageName)
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.widthAnchor.constraint(equalToConstant: 30).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        // Создание и настройка метки с текстом жеста
        let textLabel = UILabel()
        textLabel.text = text
        textLabel.font = UIFont.systemFont(ofSize: 16)
        textLabel.numberOfLines = 0
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // Создание горизонтального стека для изображения и текста
        let stackView = UIStackView(arrangedSubviews: [imageView, textLabel])
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        // Добавление стека в контейнер
        container.addSubview(stackView)
        
        // Настройка констрейнтов для стека в контейнере
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: container.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: container.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: container.bottomAnchor)
        ])
        
        return container
    }
}
