//
//  TextField.swift
//  SpotifyClone
//
//  Created by Mohammed Iskandar on 10/12/2020.
//

import UIKit

class CustomTextField: UIView{
    
    // MARK: - Inspectabels
    
    @IBInspectable var icon: UIImage? = nil {
        didSet{
            imageView.image = icon
        }
    }
    
    // MARK: - Views
    
    var textField: UITextField =  {
        let textField = UITextField()
        textField.backgroundColor = .clear
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.textAlignment = .center
        
        return textField
    }()
    
    private var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    
    private var counterLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
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
    
    // MARK: - Setup views
    
    private func setUpView() {
        
        layer.cornerRadius = 10
        layer.borderWidth = 0.15
        layer.borderColor = .init(red: 0.1, green: 0.1, blue: 0.2, alpha: 1)

        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: topAnchor),
            bottomAnchor.constraint(equalTo: bottomAnchor),
            leadingAnchor.constraint(equalTo: leadingAnchor),
            trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
        
        addSubview(textField)
        addSubview(counterLabel)
        addSubview(imageView)

        NSLayoutConstraint.activate([
            imageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            imageView.trailingAnchor.constraint(equalTo: textField.leadingAnchor, constant: -5),
        ])
        
        NSLayoutConstraint.activate([
            textField.centerYAnchor.constraint(equalTo: imageView.centerYAnchor),
            textField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
        ])
        
        NSLayoutConstraint.activate([
            counterLabel.firstBaselineAnchor.constraint(equalTo: textField.firstBaselineAnchor),
            counterLabel.leadingAnchor.constraint(equalTo: textField.trailingAnchor, constant: 5),
            counterLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
        ])
        
        
        // To keep text field wide
        imageView.setContentHuggingPriority(UILayoutPriority(rawValue: 251), for: .horizontal)
        textField.setContentHuggingPriority(UILayoutPriority(rawValue: 249), for: .horizontal)
        counterLabel.setContentHuggingPriority(UILayoutPriority(rawValue: 251), for: .horizontal)

        // To compress textfield before label
        imageView.setContentCompressionResistancePriority(UILayoutPriority(rawValue: 751), for: .horizontal)
        textField.setContentCompressionResistancePriority(UILayoutPriority(rawValue: 749), for: .horizontal)
        counterLabel.setContentCompressionResistancePriority(UILayoutPriority(rawValue: 751), for: .horizontal)
    
    }

}
