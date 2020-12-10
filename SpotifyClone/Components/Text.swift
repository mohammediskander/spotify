//
//  Text.swift
//  SpotifyClone
//
//  Created by Mohammed Iskandar on 10/12/2020.
//

import UIKit


class CustomText: UIView{
    
    
    var label: UILabel = {
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
    
    // MARK: - Setup views
    
    private func setupViews(){
        layer.cornerRadius = 20
        layer.borderWidth = 0.1
        layer.borderColor = .init(red: 0.1, green: 0.1, blue: 0.2, alpha: 1)

        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: topAnchor),
            bottomAnchor.constraint(equalTo: bottomAnchor),
            leadingAnchor.constraint(equalTo: leadingAnchor),
            trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
        
        addSubview(label)

        NSLayoutConstraint.activate([
            label.centerYAnchor.constraint(equalTo: centerYAnchor),
            label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
        ])
        
        // To keep label wide
        label.setContentHuggingPriority(UILayoutPriority(rawValue: 249), for: .horizontal)
        
        label.setContentCompressionResistancePriority(UILayoutPriority(rawValue: 749), for: .horizontal)

    }
    
}
