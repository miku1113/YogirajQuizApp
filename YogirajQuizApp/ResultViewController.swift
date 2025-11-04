//
//  ResultViewController.swift
//  YogirajQuizApp
//
//  Created by mihir jariwala on 05/11/25.
//

import UIKit

final class ResultViewController: UIViewController {

    // MARK: - Public property
    var userAnswer: String?

    // MARK: - UI Components
    private let backgroundImageView: UIImageView = {
        let iv = UIImageView(image: UIImage(named: "background")) // your image name
        iv.contentMode = .scaleAspectFill
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()

    private let overlayView: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()

    private let resultLabel: UILabel = {
        let lbl = UILabel()
        lbl.textColor = .white
        lbl.font = UIFont.boldSystemFont(ofSize: 24)
        lbl.textAlignment = .center
        lbl.numberOfLines = 0
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()

    private lazy var backHomeButton = makeButton(title: "Back To Home", style: .secondary)
    private lazy var aboutButton = makeButton(title: "About Us")
    private lazy var rateButton  = makeButton(title: "Rate Us")
    private lazy var shareButton = makeButton(title: "Share App")
    private lazy var exitButton  = makeButton(title: "Exi App")

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupLayout()
        setupActions()
        configureResultLabel()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        overlayView.layer.sublayers?.first?.frame = overlayView.bounds
    }

    // MARK: - Setup
    private func setupView() {
        view.addSubview(backgroundImageView)
        view.addSubview(overlayView)

        NSLayoutConstraint.activate([
            backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            overlayView.topAnchor.constraint(equalTo: view.topAnchor),
            overlayView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            overlayView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            overlayView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])

        addOverlayGradient()
    }

    private func setupLayout() {
        [resultLabel, backHomeButton, aboutButton, rateButton, shareButton, exitButton].forEach {
            view.addSubview($0)
        }

        let buttonWidth: CGFloat = 170
        let buttonHeight: CGFloat = 40
        let spacing: CGFloat = 18

        NSLayoutConstraint.activate([
            // Result label
            resultLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 80),
            resultLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            resultLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            resultLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),

            // Back To Home (centered)
            backHomeButton.topAnchor.constraint(equalTo: resultLabel.bottomAnchor, constant: 40),
            backHomeButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            backHomeButton.widthAnchor.constraint(equalToConstant: buttonWidth + 20),
            backHomeButton.heightAnchor.constraint(equalToConstant: buttonHeight),

            // About Us — flush right edge
            aboutButton.topAnchor.constraint(equalTo: backHomeButton.bottomAnchor, constant: 60),
            aboutButton.trailingAnchor.constraint(equalTo: view.trailingAnchor), // <-- no margin
            aboutButton.widthAnchor.constraint(equalToConstant: buttonWidth),
            aboutButton.heightAnchor.constraint(equalToConstant: buttonHeight),

            // Rate Us — flush left edge
            rateButton.topAnchor.constraint(equalTo: aboutButton.bottomAnchor, constant: spacing),
            rateButton.leadingAnchor.constraint(equalTo: view.leadingAnchor), // <-- no margin
            rateButton.widthAnchor.constraint(equalToConstant: buttonWidth),
            rateButton.heightAnchor.constraint(equalToConstant: buttonHeight),

            // Share App — flush right edge
            shareButton.topAnchor.constraint(equalTo: rateButton.bottomAnchor, constant: spacing),
            shareButton.trailingAnchor.constraint(equalTo: view.trailingAnchor), // <-- no margin
            shareButton.widthAnchor.constraint(equalToConstant: buttonWidth),
            shareButton.heightAnchor.constraint(equalToConstant: buttonHeight),

            // Exi App — flush left edge
            exitButton.topAnchor.constraint(equalTo: shareButton.bottomAnchor, constant: spacing),
            exitButton.leadingAnchor.constraint(equalTo: view.leadingAnchor), // <-- no margin
            exitButton.widthAnchor.constraint(equalToConstant: buttonWidth),
            exitButton.heightAnchor.constraint(equalToConstant: buttonHeight)
        ])
    }

    private func configureResultLabel() {
        if userAnswer == "4" {
            resultLabel.text = "Correct! 🎉"
        } else {
            resultLabel.text = "Oops! The correct answer is 4."
        }
    }

    // MARK: - Overlay Gradient
    private func addOverlayGradient() {
        let gradient = CAGradientLayer()
        gradient.colors = [
            UIColor.black.withAlphaComponent(0.25).cgColor,
            UIColor.black.withAlphaComponent(0.35).cgColor,
            UIColor.black.withAlphaComponent(0.65).cgColor
        ]
        gradient.locations = [0.0, 0.5, 1.0]
        gradient.frame = view.bounds
        overlayView.layer.addSublayer(gradient)
    }

    // MARK: - Button Factory
    private enum ButtonStyle { case primary, secondary }

    private func makeButton(title: String, style: ButtonStyle = .primary) -> UIButton {
        let btn = UIButton(type: .system)
        btn.setTitle(title, for: .normal)
        btn.titleLabel?.font = .boldSystemFont(ofSize: 16)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.layer.masksToBounds = true

        switch style {
        case .primary:
            btn.backgroundColor = UIColor(red: 0.86, green: 0.53, blue: 0.51, alpha: 0.95)
            btn.setTitleColor(.white, for: .normal)
        case .secondary:
            btn.backgroundColor = UIColor(white: 0.80, alpha: 0.95)
            btn.setTitleColor(.white, for: .normal)
        }

        btn.layer.shadowColor = UIColor.black.cgColor
        btn.layer.shadowOpacity = 0.18
        btn.layer.shadowOffset = CGSize(width: 0, height: 2)
        btn.layer.masksToBounds = false

        return btn
    }

    // MARK: - Actions
    private func setupActions() {
        backHomeButton.addTarget(self, action: #selector(homeTapped), for: .touchUpInside)
        exitButton.addTarget(self, action: #selector(exitApp), for: .touchUpInside)
    }

    @objc private func homeTapped() {
        navigationController?.popToRootViewController(animated: true)
    }

    @objc private func exitApp() {
        exit(0)
    }
}
