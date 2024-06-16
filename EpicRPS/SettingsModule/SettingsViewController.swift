//
//  SettingsViewController.swift
//  EpicRPS
//
//  Created by Валентина Попова on 13.06.2024.
//

import UIKit

final class SettingsViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    // MARK: - UI Elements
    private let gameTimeLabel = UILabel()
    private let button30 = UIButton(type: .system)
    private let button60 = UIButton(type: .system)
    private let gameTimeSC: UISegmentedControl = {
        let gameTimeSC = UISegmentedControl()
        gameTimeSC.insertSegment(withTitle: "30 сек.", at: 0, animated: false)
        gameTimeSC.insertSegment(withTitle: "60 сек.", at: 1, animated: false)
        gameTimeSC.heightAnchor.constraint(equalToConstant: 40).isActive = true
        gameTimeSC.selectedSegmentIndex = 0
        gameTimeSC.selectedSegmentTintColor = .systemOrange
        gameTimeSC.setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)
        gameTimeSC.setTitleTextAttributes([.foregroundColor: UIColor.black], for: .normal)
        return gameTimeSC
    }()
    
    private let musicLabel = UILabel()
    private let musicButton = UIButton(type: .system)
    private let musicPicker: UIPickerView = {
        let picker = UIPickerView()
        picker.translatesAutoresizingMaskIntoConstraints = false
        picker.isHidden = true
        return picker
    }()
    private var musicPickerHeightConstraint: NSLayoutConstraint?
    
    private let backgroundLabel = UILabel()
    private let backgroundSwitch: UISwitch = {
        let backgroundSwitch = UISwitch()
        backgroundSwitch.subviews.first?.subviews.first?.backgroundColor = .systemGray5
        backgroundSwitch.translatesAutoresizingMaskIntoConstraints = false
        return backgroundSwitch
    }()
    
    private let playWithFriendLabel = UILabel()
    private let playWithFriendsSwitch: UISwitch = {
        let playWithFriendsSwitch = UISwitch()
        playWithFriendsSwitch.subviews.first?.subviews.first?.backgroundColor = .systemGray5
        playWithFriendsSwitch.translatesAutoresizingMaskIntoConstraints = false
        return playWithFriendsSwitch
    }()
    
    private let musicOptions = ["Мелодия1", "Мелодия2", "Мелодия3"] // добавить звуки и переименовать
    private let variantTime = [30, 60]
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        showNavigationBar()
        setupUI()
        setConstraints()
        loadUserSettings()
        
        musicPicker.dataSource = self
        musicPicker.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = false
    }
    // MARK: - Navigation Bar
    func showNavigationBar() {
        title = "Настройки"
        
        let appearance = UINavigationBarAppearance()
        appearance.titleTextAttributes = [.font: UIFont.boldSystemFont(ofSize: 24)]
        navigationController?.navigationBar.standardAppearance = appearance
        
        let backButton = UIBarButtonItem(image: UIImage(systemName: "chevron.backward"),
                                         style: .plain,
                                         target: self,
                                         action: #selector(backButtonTapped))
        
        backButton.tintColor = .black
        navigationItem.leftBarButtonItem = backButton
    }
    
    @objc func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    // MARK: - UI Setup
    private func setupUI() {
        view.backgroundColor = .white
        
        // Настройка время игры
        gameTimeLabel.text = "ВРЕМЯ ИГРЫ"
        gameTimeLabel.font = UIFont.systemFont(ofSize: 18)
        gameTimeLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // Настройка кнопок выбора времени игры
        setupButton(button30, withTitle: "30 сек.")
        setupButton(button60, withTitle: "60 сек.")
        
        // Настройка метки для фоновой музыки
        musicLabel.text = "Фоновая музыка"
        musicLabel.font = UIFont.systemFont(ofSize: 18)
        musicLabel.textColor = .white
        musicLabel.translatesAutoresizingMaskIntoConstraints = false
        
        setupButton(musicButton, withTitle: "Выбрать мелодию | >")
        musicButton.addTarget(self, action: #selector(showMusicPicker), for: .touchUpInside)
        
        // Настройка метки и переключателя для смены цвета фона
        backgroundLabel.text = "Цвет фона"
        backgroundLabel.font = UIFont.systemFont(ofSize: 18)
        backgroundLabel.textColor = .white
        backgroundLabel.translatesAutoresizingMaskIntoConstraints = false
        backgroundSwitch.addTarget(self, action: #selector(changeBackgroundColor), for: .valueChanged)
        
        // Настройка метки и переключателя для игры с другом
        playWithFriendLabel.text = "Игра с другом"
        playWithFriendLabel.font = UIFont.systemFont(ofSize: 18)
        playWithFriendLabel.textColor = .white
        
        //Добавление отлеживаения для времени игры
        gameTimeSC.addTarget(self, action: #selector(didSelectTime), for: .valueChanged)
    }
    
    // MARK: - Constraints
    private func setConstraints() {
        let stackHeight: CGFloat = 50
        
        let gameTimeStack = view.createStackView(
            with: [gameTimeLabel, gameTimeSC],
            axis: .vertical,
            spacing: 15,
            layoutMargins: UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15),
            cornerRadius: 15,
            borderWidth: 1,
            borderColor: .black
        )
        
        let backgroundStack = view.createStackView(
            with: [backgroundLabel, backgroundSwitch],
            axis: .horizontal,
            spacing: 8,
            layoutMargins: UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5),
            cornerRadius: 10,
            backgroundColor: .systemOrange,
            height: stackHeight
        )
        
        let musicControlStack = view.createStackView(
            with: [musicLabel, musicButton],
            axis: .horizontal,
            spacing: 8,
            layoutMargins: UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5),
            cornerRadius: 10,
            backgroundColor: .systemOrange,
            height: stackHeight
        )
        
        let musicStack = view.createStackView(
            with: [musicControlStack, musicPicker],
            axis: .vertical,
            spacing: 8
        )
        
        let playWithFriendStack = view.createStackView(
            with: [playWithFriendLabel, playWithFriendsSwitch],
            axis: .horizontal,
            spacing: 8,
            layoutMargins: UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5),
            cornerRadius: 10,
            backgroundColor: .systemOrange,
            height: stackHeight
        )
        
        let secondStack = view.createStackView(
            with: [backgroundStack, playWithFriendStack, musicStack],
            axis: .vertical,
            spacing: 15,
            layoutMargins: UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15),
            cornerRadius: 15,
            borderWidth: 1,
            borderColor: .black
        )
        
        let settingsStack = view.createStackView(
            with: [gameTimeStack, secondStack],
            axis: .vertical,
            spacing: 16
        )
        
        view.addSubview(settingsStack)
        
        // Установка constraints для settingsStack
        NSLayoutConstraint.activate([
            settingsStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            settingsStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            settingsStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            settingsStack.bottomAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
        
        // Установка constraints для musicPicker
        musicPickerHeightConstraint = musicPicker.heightAnchor.constraint(equalToConstant: 0)
        musicPickerHeightConstraint?.isActive = true
    }
    
    // MARK: - Button Setup
    func setupButton(_ button: UIButton, withTitle title: String) {
        button.setTitle(title, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor.systemOrange
        button.layer.cornerRadius = 8
        button.translatesAutoresizingMaskIntoConstraints = false
        button.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    // MARK: - Actions
    @objc private func showMusicPicker() {
        if musicPicker.isHidden {
            musicPicker.isHidden = false
            musicPickerHeightConstraint?.constant = 150
        } else {
            musicPicker.isHidden = true
            musicPickerHeightConstraint?.constant = 0
        }
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
    
    @objc private func changeBackgroundColor() {
        let isBackgroundBlack = backgroundSwitch.isOn
        view.backgroundColor = isBackgroundBlack ? .black : .white
        saveUserSettings()
    }
    
    @objc private func didSelectTime(select: UISegmentedControl) {
        DefaultsSettings.roundTime = variantTime[gameTimeSC.selectedSegmentIndex]
    }
    
    // MARK: - UIPickerViewDataSource
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return musicOptions.count
    }
    
    // MARK: - UIPickerViewDelegate
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return musicOptions[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let selectedTitle = musicOptions[row]
        musicButton.setTitle("\(selectedTitle)", for: .normal)
        musicPicker.isHidden = true
        musicPickerHeightConstraint?.constant = 0
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
        
        saveUserSettings()
    }
    
    // MARK: - User Defaults
    private func saveUserSettings() {
        DefaultsSettings.roundTime = variantTime[gameTimeSC.selectedSegmentIndex]
        DefaultsSettings.darkMode = backgroundSwitch.isOn
        DefaultsSettings.pvpMode = playWithFriendsSwitch.isOn
        DefaultsSettings.defaultFonMusicName = musicButton.title(for: .normal)
    }
    
    private func loadUserSettings() {
        gameTimeSC.selectedSegmentIndex = DefaultsSettings.roundTime == 30 ? 0 : 1
        backgroundSwitch.isOn = DefaultsSettings.darkMode!
        view.backgroundColor = backgroundSwitch.isOn ? .black : .white
        playWithFriendsSwitch.isOn = DefaultsSettings.pvpMode!
        musicButton.setTitle(DefaultsSettings.defaultFonMusicName, for: .normal)
    }
}

// MARK: - Stack View Extension

extension UIView {
    func createStackView(with arrangedSubviews: [UIView], axis: NSLayoutConstraint.Axis, spacing: CGFloat, layoutMargins: UIEdgeInsets = .zero, cornerRadius: CGFloat = 0, borderWidth: CGFloat = 0, borderColor: UIColor = .clear, backgroundColor: UIColor = .clear, height: CGFloat? = nil) -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: arrangedSubviews)
        stackView.axis = axis
        stackView.alignment = .fill
        stackView.spacing = spacing
        stackView.backgroundColor = backgroundColor
        stackView.layer.cornerRadius = cornerRadius
        stackView.layer.borderWidth = borderWidth
        stackView.layer.borderColor = borderColor.cgColor
        stackView.layoutMargins = layoutMargins
        stackView.isLayoutMarginsRelativeArrangement = true
        if let height = height {
            stackView.heightAnchor.constraint(equalToConstant: height).isActive = true
        }
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }
}

