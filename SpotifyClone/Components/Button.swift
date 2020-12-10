//
//  Button.swift
//  SpotifyClone
//
//  Created by Mohammed Iskandar on 10/12/2020.
//

import UIKit

class CustomButton: UIView{
    
    // MARK: - Views
    
    var button: UIButton = {
    let button = UIButton()
        button.backgroundColor = .clear
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.textAlignment = .center
        
        return button
    }()
    
    
    // MARK: - Haptics
    
    private var feedbackGenerator: UIFeedbackGenerator = {
        var feedbackGenerator = UIFeedbackGenerator()
        feedbackGenerator.prepare()
        return feedbackGenerator
    }()
    
    // MARK: - Inits
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUpView()
    }
    
    private func setUpView() {
        
        layer.cornerRadius = 25
        layer.borderWidth = 0.1

        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: topAnchor),
            bottomAnchor.constraint(equalTo: bottomAnchor),
            leadingAnchor.constraint(equalTo: leadingAnchor),
            trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
        
        addSubview(button)
        
        NSLayoutConstraint.activate([
            button.centerYAnchor.constraint(equalTo: centerYAnchor),
            button.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
        ])
        
        
        // To keep text field wide
        button.setContentHuggingPriority(UILayoutPriority(rawValue: 249), for: .horizontal)

        // To compress textfield before label
        button.setContentCompressionResistancePriority(UILayoutPriority(rawValue: 749), for: .horizontal)
    
    }
}
