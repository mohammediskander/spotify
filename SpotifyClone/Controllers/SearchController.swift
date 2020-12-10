//
//  SearchController.swift
//  SpotifyClone
//
//  Created by Mohammed Iskandar on 10/12/2020.
//

import UIKit

class SearchController: UIViewController{
    override func viewDidLoad() {
        self.setupView()
    }
    
    func setupView(){
        let searchView = SearchView(frame: self.view.bounds)
        
        let button = CustomButton(frame: CGRect(x: 50, y: 100, width: 200, height: 50))
        let text = CustomTextField(frame: CGRect(x: 50, y: 170, width: 300, height: 35))
        let label = CustomText(frame: CGRect(x: 50, y: 220, width: 200, height: 50))
        
        button.backgroundColor = .systemGreen
        button.button.setTitle("     SHUFFLE PLAY", for: .normal)
        
        label.label.text = "Label"
        label.label.textColor = .black
        label.backgroundColor = .red
        
        text.textField.text = "TextField"
        text.backgroundColor = .white
        text.textField.textColor = .black
        view.backgroundColor = .yellow
        text.icon = UIImage(systemName: "magnifyingglass")
        text.icon?.withTintColor(.black)
        
        self.view.addSubview(label)
        self.view.addSubview(text)
        self.view.addSubview(button)
        self.view.addSubview(searchView)
    }
}

