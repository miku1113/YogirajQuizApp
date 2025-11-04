//
//  HomeViewController.swift
//  YogirajQuizApp
//
//  Created by mihir jariwala on 05/11/25.
//

import UIKit

class HomeViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBackground()
        setupUI()
    }
    
    private func setupBackground() {
        // Background image
        let bgImageView = UIImageView(image: UIImage(named: "background"))
        bgImageView.contentMode = .scaleAspectFill
        bgImageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(bgImageView)
        
        NSLayoutConstraint.activate([
            bgImageView.topAnchor.constraint(equalTo: view.topAnchor),
            bgImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bgImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bgImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        // Dark overlay
        let overlayView = UIView()
        overlayView.backgroundColor = UIColor.black.withAlphaComponent(0.25)
        overlayView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(overlayView)
        
        NSLayoutConstraint.activate([
            overlayView.topAnchor.constraint(equalTo: view.topAnchor),
            overlayView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            overlayView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            overlayView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func setupUI() {
        // Top illustration
        let topImage = UIImageView(image: UIImage(named: "construction"))
        topImage.contentMode = .scaleAspectFit
        topImage.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(topImage)

        // Title (bigger)
        let titleLabel = UILabel()
        titleLabel.text = "Yogiraj"
        titleLabel.font = UIFont(name: "ChalkboardSE-Bold", size: 46) ?? .boldSystemFont(ofSize: 46)
        titleLabel.textColor = .black
        titleLabel.textAlignment = .center
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(titleLabel)

        // Subtitle (bigger, narrower width so brackets get closer)
        let subtitleLabel = UILabel()
        subtitleLabel.text = "The Construction application is the\nbest application for the local users...!"
        subtitleLabel.font = .systemFont(ofSize: 20, weight: .semibold) // ↑
        subtitleLabel.textColor = .white
        subtitleLabel.textAlignment = .center
        subtitleLabel.numberOfLines = 0
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(subtitleLabel)

        // Button
        let goButton = UIButton(type: .system)
        goButton.setTitle("Goo", for: .normal)
        goButton.setTitleColor(.black, for: .normal)
        goButton.backgroundColor = UIColor(red: 255/255, green: 235/255, blue: 60/255, alpha: 1)
        goButton.layer.cornerRadius = 25
        goButton.layer.shadowColor = UIColor.systemGreen.cgColor
        goButton.layer.shadowOpacity = 0.8
        goButton.layer.shadowOffset = CGSize(width: 0, height: 5)
        goButton.layer.shadowRadius = 10
        goButton.titleLabel?.font = .boldSystemFont(ofSize: 20)
        goButton.translatesAutoresizingMaskIntoConstraints = false
        goButton.addTarget(self, action: #selector(openQuizMenu), for: .touchUpInside)
        view.addSubview(goButton)

        // Layout
        NSLayoutConstraint.activate([
            topImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            topImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            topImage.heightAnchor.constraint(equalToConstant: 200),
            topImage.widthAnchor.constraint(equalToConstant: 200),

            titleLabel.topAnchor.constraint(equalTo: topImage.bottomAnchor, constant: 22),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            // ↓ narrower width so brackets get closer together
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 12),
            subtitleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            subtitleLabel.widthAnchor.constraint(equalToConstant: 230),

            goButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            goButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -60),
            goButton.widthAnchor.constraint(equalToConstant: 150),
            goButton.heightAnchor.constraint(equalToConstant: 50)
        ])

        // Brackets after layout so we know the label’s actual size
        view.layoutIfNeeded()
        addCurvedBrackets(around: subtitleLabel)
    }

    
    private func addCurvedBrackets(around label: UILabel) {
        // Remove previous brackets if you call this again (optional safety)
        view.subviews.filter { $0.accessibilityIdentifier == "curvedBracket" }.forEach { $0.removeFromSuperview() }

        // Use the label's current height to size the arcs
        let labelHeight = max(label.bounds.height, label.font.lineHeight)
        // A little padding so arcs extend slightly above/below text
        let verticalPadding: CGFloat = 6
        let radius = (labelHeight / 2.0) + verticalPadding

        // Thickness proportional to radius for consistent look
        let lineWidth = max(10, radius * 0.22)

        // Tighter spacing to hug the text
        let bracketSpacing: CGFloat = 4

        // Host views for layers
        let leftBracket = UIView()
        leftBracket.accessibilityIdentifier = "curvedBracket"
        leftBracket.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(leftBracket)

        let rightBracket = UIView()
        rightBracket.accessibilityIdentifier = "curvedBracket"
        rightBracket.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(rightBracket)

        // Views are as tall as the full arc, but very thin (the arc draws outside)
        let bracketHeight = radius * 2.0
        let hostWidth: CGFloat = lineWidth / 2.0

        NSLayoutConstraint.activate([
            // Left bracket — centered to label, snug to leading edge
            leftBracket.centerYAnchor.constraint(equalTo: label.centerYAnchor),
            leftBracket.trailingAnchor.constraint(equalTo: label.leadingAnchor, constant: -bracketSpacing),
            leftBracket.widthAnchor.constraint(equalToConstant: hostWidth),
            leftBracket.heightAnchor.constraint(equalToConstant: bracketHeight),

            // Right bracket — centered to label, snug to trailing edge
            rightBracket.centerYAnchor.constraint(equalTo: label.centerYAnchor),
            rightBracket.leadingAnchor.constraint(equalTo: label.trailingAnchor, constant: bracketSpacing),
            rightBracket.widthAnchor.constraint(equalToConstant: hostWidth),
            rightBracket.heightAnchor.constraint(equalToConstant: bracketHeight)
        ])

        // Paths (flat ends to match your style)
        let color = UIColor(red: 255/255, green: 235/255, blue: 60/255, alpha: 1).cgColor

        let leftPath = UIBezierPath(
            arcCenter: CGPoint(x: radius, y: radius),
            radius: radius,
            startAngle: .pi / 2,         // bottom
            endAngle: .pi * 1.5,         // top
            clockwise: true
        )
        let leftLayer = CAShapeLayer()
        leftLayer.path = leftPath.cgPath
        leftLayer.strokeColor = color
        leftLayer.lineWidth = lineWidth
        leftLayer.fillColor = UIColor.clear.cgColor
        leftLayer.lineCap = .butt
        // Shift so the rightmost edge of the arc sits on bracket view’s trailing edge
        leftLayer.frame = CGRect(x: -radius + hostWidth, y: 0, width: bracketHeight, height: bracketHeight)
        leftBracket.layer.addSublayer(leftLayer)

        let rightPath = UIBezierPath(
            arcCenter: CGPoint(x: 0, y: radius),
            radius: radius,
            startAngle: .pi * 1.5,       // top
            endAngle: .pi / 2,           // bottom
            clockwise: true
        )
        let rightLayer = CAShapeLayer()
        rightLayer.path = rightPath.cgPath
        rightLayer.strokeColor = color
        rightLayer.lineWidth = lineWidth
        rightLayer.fillColor = UIColor.clear.cgColor
        rightLayer.lineCap = .butt
        // Shift so the leftmost edge of the arc sits on bracket view’s leading edge
        rightLayer.frame = CGRect(x: -hostWidth, y: 0, width: bracketHeight, height: bracketHeight)
        rightBracket.layer.addSublayer(rightLayer)
    }

    
    @objc func openQuizMenu() {
        let menuVC = QuizMenuViewController()
        navigationController?.pushViewController(menuVC, animated: true)
    }
}
