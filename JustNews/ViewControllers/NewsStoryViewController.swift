//
//  NewsStoryViewController.swift
//  JustNews
//
//  Created by G on 04/02/2024.
//

import UIKit

class NewsStoryViewController: UIViewController {
    var newsStoryUUID: String!
    var newsStory: NewsModel!
    //UI Components
    let newsStoryImage = JNStoryImageView(frame: .zero)
    let newsStoryTitle = JNNewsTitle(textAlignment: .left, fontSize: 24)
    let sourceImageView = UIImageView()
    let source = JNSecondaryLabel(fontSize: 18)
    var newsDescription = JNBodyLabel(textAlignment: .left)
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        retrieveStoryObject(uuid: newsStoryUUID)
        addSubview()
        layoutUI()
        
    }
    
    init(){
        super.init(nibName: nil, bundle: nil)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func retrieveStoryObject(uuid: String){
        
        NetworkManager.shared.fetchStory(uuid: self.newsStoryUUID) {[weak self] result in
            switch result{
            case .success(let story):
                print(story)
                self?.newsStory=story
                self?.configureUIElement()
            case .failure(let error):
                print(error)
                break
                
            }
        }
    }
    func addSubview(){
        view.addSubview(newsStoryImage)
        view.addSubview(newsStoryTitle)
        view.addSubview(sourceImageView)
        view.addSubview(source)
        view.addSubview(newsDescription)
    }
    func configureUIElement(){
        DispatchQueue.main.async { [self] in
            self.newsStoryImage.downloadImage(from: newsStory.imageURL)
            self.newsStoryTitle.text = newsStory.title
            self.source.text = newsStory.source
            self.newsDescription.text = newsStory.description
            self.sourceImageView.image = UIImage(systemName: "link.circle")
            self.sourceImageView.tintColor = .secondaryLabel
        }
        
    }
    func layoutUI(){
        let padding:CGFloat = 20
        
        sourceImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            // Title constraints
            newsStoryTitle.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 1),
            newsStoryTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            newsStoryTitle.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            //newsStoryTitle.heightAnchor.constraint(equalToConstant: 38),
            
            // Image constraints
            newsStoryImage.topAnchor.constraint(equalTo: newsStoryTitle.bottomAnchor, constant: padding),
            newsStoryImage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            newsStoryImage.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            newsStoryImage.heightAnchor.constraint(equalTo: newsStoryImage.widthAnchor),
            
            // Source image view constraints
            sourceImageView.topAnchor.constraint(equalTo: newsStoryImage.bottomAnchor, constant: padding),
            sourceImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            sourceImageView.heightAnchor.constraint(equalToConstant: 20),
            sourceImageView.widthAnchor.constraint(equalToConstant: 20),
            
            // Source label constraints
            source.centerYAnchor.constraint(equalTo: sourceImageView.centerYAnchor),
            source.leadingAnchor.constraint(equalTo: sourceImageView.trailingAnchor, constant: 5),
            source.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            
            // News description constraints
            newsDescription.topAnchor.constraint(equalTo: sourceImageView.bottomAnchor, constant: padding),
            newsDescription.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            newsDescription.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            newsDescription.bottomAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -padding), // Allows dynamic height
            
        ])
    }
    
}
