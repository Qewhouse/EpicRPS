//
//  Pre-fightScreen.swift
//  EpicRPS
//
//  Created by Андрей Линьков on 11.06.2024.
//

import UIKit

class Pre_fightScreen: UIViewController {
       
    // MARK: - UI Properties
    private lazy var player1: UIImageView = {
        let element = UIImageView()
        element.image = #imageLiteral(resourceName: "Player 1")
        element.contentMode = .scaleAspectFit
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    } ()
    
    private lazy var player2: UIImageView = {
        let element = UIImageView()
        element.image = #imageLiteral(resourceName: "Player 2")
        element.contentMode = .scaleAspectFit
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    } ()
    
    private let vs: UILabel = {
        let element = UILabel()
        element.textColor = UIColor(red: 255/255, green: 178/255, blue: 76/255, alpha: 1)
        element.text = "VS"
        element.font = UIFont.boldSystemFont(ofSize: 56)
        element.contentMode = .scaleAspectFit
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private let getReady: UILabel = {
        let element = UILabel()
        element.textColor = UIColor(red: 255/255, green: 178/255, blue: 76/255, alpha: 1)
        element.text = "Get ready..."
        element.font = UIFont(name: "Rubik", size: 19.5)
            //.boldSystemFont(ofSize: 19.5)
        element.contentMode = .scaleAspectFit
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private let player1Stat: UITextView = {
        let element = UITextView()
        element.textColor = .white
        element.backgroundColor = .clear
        element.text =
        """
        10 Victories/
            2 Lose
        """
        element.font = UIFont(name: "Rubik", size: 19.5)
        //element.font = UIFont.boldSystemFont(ofSize: 19.5)
        element.contentMode = .scaleAspectFill
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private let player2Stat: UITextView = {
        let element = UITextView()
        element.textColor = .white
        element.backgroundColor = .clear
        element.text =
        """
        23 Victories/
             1 Lose
        """
        element.font = UIFont(name: "Rubik", size: 19.5)
        //element.font = .font.; //UIFont.boldSystemFont(ofSize: 19.5)
        element.contentMode = .scaleAspectFit
        element.translatesAutoresizingMaskIntoConstraints = false
        print(element)
        return element
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let backgroundColour1 = UIColor(red: 45/255, green: 37/255, blue: 153/255, alpha: 1).cgColor
        let backgroundColour2 = UIColor(red: 101/255, green: 109/255, blue: 244/255, alpha: 1).cgColor
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.type = .radial
        gradientLayer.frame = self.view.bounds
        gradientLayer.colors = [backgroundColour1, backgroundColour2]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        self.view.layer.insertSublayer(gradientLayer, at: 0)
        
        setupUI()
        setupConstraints()
    }
    

    // MARK: - Private Methods
    private func setupUI() {
        //view.backgroundColor = UIColor(red: 53/255, green: 69/255, blue: 200/255, alpha: 1).cgColor
        //view.layer.addSublayer(CAGradientLayer)
        
        view.addSubview(player1)
        view.addSubview(player2)
        view.addSubview(vs)
        view.addSubview(getReady)
        view.addSubview(player1Stat)
        view.addSubview(player2Stat)


        
    }
}

    // MARK: - Setup Constraints
extension Pre_fightScreen{
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            vs.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            vs.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            getReady.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            getReady.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -56),
            
            player1.bottomAnchor.constraint(equalTo: player1Stat.topAnchor, constant: -9),
            player1.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            
            player2.topAnchor.constraint(equalTo: vs.bottomAnchor, constant: 61),
            player2.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            player1Stat.heightAnchor.constraint(equalToConstant: 50),
            player1Stat.widthAnchor.constraint(equalToConstant: 128),
            player1Stat.bottomAnchor.constraint(equalTo: vs.topAnchor, constant: -61),
            player1Stat.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            player2Stat.heightAnchor.constraint(equalToConstant: 50),
            player2Stat.widthAnchor.constraint(equalToConstant: 128),
            player2Stat.topAnchor.constraint(equalTo: player2.bottomAnchor, constant: 10),
            player2Stat.centerXAnchor.constraint(equalTo: view.centerXAnchor),
])
    }
}
