//
//  StoryViewCell.swift
//  JustNews
//
//  Created by G on 04/02/2024.
//

import UIKit

class StoryViewCell: UICollectionViewCell {
    static let reuseID = "StoryCell"
    
    let newsStoryImage = JNStoryImageView(frame: .zero)
    let newsStoryTitle = JNTitleLabel(textAlignment: .left, fontSize: 16)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(newsstory: NewsModel){
        newsStoryTitle.text = newsstory.title
        newsStoryImage.downloadImage(from: newsstory.imageURL)
    }
    
    private func configure(){
        let padding:CGFloat = 8
        addSubview(newsStoryImage)
        addSubview(newsStoryTitle)
        
        NSLayoutConstraint.activate([
            newsStoryImage.topAnchor.constraint(equalTo: topAnchor, constant: padding+10),
            newsStoryImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            newsStoryImage.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            newsStoryImage.heightAnchor.constraint(equalTo: newsStoryImage.widthAnchor),
            
            newsStoryTitle.topAnchor.constraint(equalTo: newsStoryImage.bottomAnchor, constant: 12),
            newsStoryTitle.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            newsStoryTitle.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            newsStoryTitle.heightAnchor.constraint(equalToConstant: 20),
        ])
        translatesAutoresizingMaskIntoConstraints = false
    }
}
