//
//  JNStoryImageView.swift
//  JustNews
//
//  Created by G on 04/02/2024.
//

import UIKit

class JNStoryImageView: UIImageView {
    let placeholderImage = UIImage(named: "newspaper")
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func configure(){
        layer.cornerRadius = 10
        clipsToBounds = true
        image = placeholderImage
        translatesAutoresizingMaskIntoConstraints = false
    }


}
