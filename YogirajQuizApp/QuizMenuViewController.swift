//
//  QuizMenuViewController.swift
//  YogirajQuizApp
//
//  Created by mihir jariwala on 05/11/25.
//

import UIKit

class QuizMenuViewController: UIViewController {

    private let topButtonsTitles = ["Short Quiz", "Mix Quiz", "Numbers Quiz", "Blanks Quiz"]
    private var topButtons: [UIButton] = []

    private lazy var backButton: UIButton = {
        let b = UIButton(type: .system)
        b.setTitle("Back", for: .normal)
        b.setTitleColor(.black, for: .normal)
        b.backgroundColor = UIColor(white: 0.85, alpha: 1.0)
        b.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        b.translatesAutoresizingMaskIntoConstraints = false
        b.addTarget(self, action: #selector(backTapped), for: .touchUpInside)
        return b
    }()

    private lazy var exitButton: UIButton = {
        let b = UIButton(type: .system)
        b.setTitle("Exit App", for: .normal)
        b.setTitleColor(.white, for: .normal)
        b.backgroundColor = UIColor(red: 221/255, green: 108/255, blue: 93/255, alpha: 1)
        b.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        b.layer.borderColor = UIColor.black.cgColor
        b.layer.borderWidth = 1.5
        b.translatesAutoresizingMaskIntoConstraints = false
        b.addTarget(self, action: #selector(exitTapped), for: .touchUpInside)
        return b
    }()

    private lazy var settingButton: UIButton = {
        let b = UIButton(type: .system)
        b.setTitle("Setting", for: .normal)
        b.setTitleColor(.white, for: .normal)
        b.backgroundColor = UIColor(red: 221/255, green: 108/255, blue: 93/255, alpha: 1)
        b.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        b.layer.borderColor = UIColor.black.cgColor
        b.layer.borderWidth = 1.5
        b.translatesAutoresizingMaskIntoConstraints = false
        b.addTarget(self, action: #selector(settingTapped), for: .touchUpInside)
        return b
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupBackground()
        setupTopButtons()
        setupBottomButtons()
    }

    private func setupBackground() {
        let bg = UIImageView(image: UIImage(named: "background"))
        bg.contentMode = .scaleAspectFill
        bg.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(bg)

        NSLayoutConstraint.activate([
            bg.topAnchor.constraint(equalTo: view.topAnchor),
            bg.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bg.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bg.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])

        let overlay = UIView()
        overlay.backgroundColor = UIColor.black.withAlphaComponent(0.25)
        overlay.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(overlay)

        NSLayoutConstraint.activate([
            overlay.topAnchor.constraint(equalTo: view.topAnchor),
            overlay.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            overlay.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            overlay.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    private func setupTopButtons() {
        var previousAnchor: NSLayoutYAxisAnchor = view.safeAreaLayoutGuide.topAnchor
        let leftInset: CGFloat = 20
        let buttonWidth: CGFloat = 200
        let buttonHeight: CGFloat = 40
        let verticalSpacing: CGFloat = 18

        for title in topButtonsTitles {
            let btn = makeMenuButton(title: title)
            view.addSubview(btn)
            btn.translatesAutoresizingMaskIntoConstraints = false

            NSLayoutConstraint.activate([
                btn.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: leftInset),
                btn.widthAnchor.constraint(equalToConstant: buttonWidth),
                btn.heightAnchor.constraint(equalToConstant: buttonHeight),
                btn.topAnchor.constraint(equalTo: previousAnchor, constant: previousAnchor == view.safeAreaLayoutGuide.topAnchor ? 36 : verticalSpacing)
            ])

            previousAnchor = btn.bottomAnchor
            topButtons.append(btn)
        }
    }

    private func setupBottomButtons() {
        // Back button (centered)
        view.addSubview(backButton)
        NSLayoutConstraint.activate([
            backButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            backButton.topAnchor.constraint(equalTo: topButtons.last!.bottomAnchor, constant: 30),
            backButton.widthAnchor.constraint(equalToConstant: 120),
            backButton.heightAnchor.constraint(equalToConstant: 44)
        ])

        // Exit App button (flush to right edge)
        view.addSubview(exitButton)
        NSLayoutConstraint.activate([
            exitButton.trailingAnchor.constraint(equalTo: view.trailingAnchor), // removed spacing
            exitButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -80),
            exitButton.widthAnchor.constraint(equalToConstant: 160),
            exitButton.heightAnchor.constraint(equalToConstant: 40)
        ])

        // Setting button (flush to left edge)
        view.addSubview(settingButton)
        NSLayoutConstraint.activate([
            settingButton.leadingAnchor.constraint(equalTo: view.leadingAnchor), // removed spacing
            settingButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -28),
            settingButton.widthAnchor.constraint(equalToConstant: 140),
            settingButton.heightAnchor.constraint(equalToConstant: 36)
        ])
    }

    private func makeMenuButton(title: String) -> UIButton {
        let btn = UIButton(type: .system)
        btn.setTitle(title, for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        btn.backgroundColor = UIColor(red: 211/255, green: 132/255, blue: 132/255, alpha: 1)
        btn.layer.borderColor = UIColor.black.cgColor
        btn.layer.borderWidth = 2
        btn.addTarget(self, action: #selector(topButtonTapped(_:)), for: .touchUpInside)
        return btn
    }

    @objc private func topButtonTapped(_ sender: UIButton) {
        guard let title = sender.title(for: .normal) else { return }
        switch title {
        case "Short Quiz":
            navigationController?.pushViewController(QuizQuestionViewController(), animated: true)
        default:
            navigationController?.pushViewController(QuizQuestionViewController(), animated: true)
        }
    }

    @objc private func backTapped() {
        navigationController?.popViewController(animated: true)
    }

    @objc private func exitTapped() {
        exit(0)
    }

    @objc private func settingTapped() {
        navigationController?.pushViewController(SettingsViewController(), animated: true)
    }
}
