//
//  QuizQuestionViewController.swift
//  YogirajQuizApp
//
//  Created by mihir jariwala on 05/11/25.
//

import UIKit

class QuizQuestionViewController: UIViewController {
    
    private let answerField = UITextField()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBackground()
        setupUI()
    }
    
    // MARK: - Background Setup
    private func setupBackground() {
        // Add background image
        let backgroundImage = UIImageView(image: UIImage(named: "background"))
        backgroundImage.contentMode = .scaleAspectFill
        backgroundImage.frame = view.bounds
        backgroundImage.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(backgroundImage)
        
        // Add dark overlay
        let overlayView = UIView(frame: view.bounds)
        overlayView.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        overlayView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(overlayView)
    }
    
    // MARK: - UI Setup
    private func setupUI() {
        // Title
        let titleLabel = UILabel()
        titleLabel.text = "Short Quiz Module"
        titleLabel.textColor = .white
        titleLabel.font = UIFont.boldSystemFont(ofSize: 20)
        titleLabel.textAlignment = .center
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(titleLabel)
        
        // Question Circle
        let questionCircle = createCircleView(diameter: 200)
        view.addSubview(questionCircle)
        
        let questionLabel = UILabel()
        questionLabel.text = "What is the sum of\n2 + 2 = ?"
        questionLabel.textColor = .black
        questionLabel.textAlignment = .center
        questionLabel.font = UIFont.boldSystemFont(ofSize: 18)
        questionLabel.numberOfLines = 0
        questionLabel.translatesAutoresizingMaskIntoConstraints = false
        questionCircle.addSubview(questionLabel)
        
        // Submit Button
        let submitButton = createButton(title: "Submit", color: UIColor.systemGreen)
        submitButton.addTarget(self, action: #selector(submitButtonTapped), for: .touchUpInside)
        view.addSubview(submitButton)
        
        // Answer Circle
        let answerCircle = createCircleView(diameter: 180)
        view.addSubview(answerCircle)
        
        let answerLabel = UILabel()
        answerLabel.text = "Enter Answer"
        answerLabel.textColor = .black
        questionLabel.textAlignment = .center
        answerLabel.font = UIFont.boldSystemFont(ofSize: 16)
        answerLabel.translatesAutoresizingMaskIntoConstraints = false
        answerCircle.addSubview(answerLabel)
        
        answerField.borderStyle = .roundedRect
        answerField.backgroundColor = .white
        answerField.textAlignment = .center
        answerField.translatesAutoresizingMaskIntoConstraints = false
        answerCircle.addSubview(answerField)
        
        // Right side buttons
        let resetButton = createSideButton(title: "Reset")
        let homeButton = createSideButton(title: "Home")
        let backButton = createSideButton(title: "Back")
        
        view.addSubview(resetButton)
        view.addSubview(homeButton)
        view.addSubview(backButton)
        
        // Bottom Buttons (same style as previous screen)
        let exitButton = createButton(title: "Exit App", color: UIColor(red: 0.89, green: 0.62, blue: 0.62, alpha: 1))
        let settingButton = createButton(title: "Setting", color: UIColor(red: 0.89, green: 0.62, blue: 0.62, alpha: 1))
        view.addSubview(exitButton)
        view.addSubview(settingButton)
        
        // Constraints
        NSLayoutConstraint.activate([
            // Title
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            // Question Circle (Top)
            questionCircle.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            questionCircle.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 40),
            questionCircle.widthAnchor.constraint(equalToConstant: 200),
            questionCircle.heightAnchor.constraint(equalToConstant: 200),
            
            questionLabel.centerXAnchor.constraint(equalTo: questionCircle.centerXAnchor),
            questionLabel.centerYAnchor.constraint(equalTo: questionCircle.centerYAnchor),
            
            // Submit Button
            submitButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            submitButton.topAnchor.constraint(equalTo: questionCircle.bottomAnchor, constant: 30),
            submitButton.widthAnchor.constraint(equalToConstant: 120),
            submitButton.heightAnchor.constraint(equalToConstant: 44),
            
            // Answer Circle (Below Submit)
            answerCircle.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            answerCircle.topAnchor.constraint(equalTo: submitButton.bottomAnchor, constant: 30),
            answerCircle.widthAnchor.constraint(equalToConstant: 180),
            answerCircle.heightAnchor.constraint(equalToConstant: 180),
            
            answerLabel.topAnchor.constraint(equalTo: answerCircle.topAnchor, constant: 20),
            answerLabel.centerXAnchor.constraint(equalTo: answerCircle.centerXAnchor),
            
            answerField.topAnchor.constraint(equalTo: answerLabel.bottomAnchor, constant: 12),
            answerField.centerXAnchor.constraint(equalTo: answerCircle.centerXAnchor),
            answerField.widthAnchor.constraint(equalToConstant: 120),
            answerField.heightAnchor.constraint(equalToConstant: 34),
            
            // Right-side buttons
            resetButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            resetButton.topAnchor.constraint(equalTo: answerCircle.topAnchor, constant: -10),
            resetButton.widthAnchor.constraint(equalToConstant: 70),
            resetButton.heightAnchor.constraint(equalToConstant: 35),
            
            homeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            homeButton.topAnchor.constraint(equalTo: resetButton.bottomAnchor, constant: 8),
            homeButton.widthAnchor.constraint(equalToConstant: 70),
            homeButton.heightAnchor.constraint(equalToConstant: 35),
            
            backButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            backButton.topAnchor.constraint(equalTo: homeButton.bottomAnchor, constant: 8),
            backButton.widthAnchor.constraint(equalToConstant: 70),
            backButton.heightAnchor.constraint(equalToConstant: 35),
            
            // Bottom Buttons
            exitButton.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            exitButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -80),
            exitButton.widthAnchor.constraint(equalToConstant: 160),
            exitButton.heightAnchor.constraint(equalToConstant: 40),
            
            settingButton.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            settingButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -28),
            settingButton.widthAnchor.constraint(equalToConstant: 140),
            settingButton.heightAnchor.constraint(equalToConstant: 36)
        ])
    }
    
    // MARK: - Helper Functions
    private func createCircleView(diameter: CGFloat) -> UIView {
        let circleView = UIView()
        circleView.backgroundColor = UIColor(red: 0.98, green: 0.77, blue: 0.77, alpha: 1)
        circleView.layer.cornerRadius = diameter / 2
        circleView.translatesAutoresizingMaskIntoConstraints = false
        return circleView
    }
    
    private func createButton(title: String, color: UIColor) -> UIButton {
        let button = UIButton(type: .system)
        button.setTitle(title, for: .normal)
        button.backgroundColor = color
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)

        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }
    
    private func createSideButton(title: String) -> UIButton {
        let button = UIButton(type: .system)
        button.setTitle(title, for: .normal)
        button.backgroundColor = UIColor(red: 0.38, green: 0.07, blue: 0.19, alpha: 1)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 18
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }
    
    // MARK: - Button Actions
    @objc private func submitButtonTapped() {
        let answer = answerField.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        let resultVC = ResultViewController()
        resultVC.userAnswer = answer
        navigationController?.pushViewController(resultVC, animated: true)
    }
}
