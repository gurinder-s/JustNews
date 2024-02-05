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
    
    func downloadImage(from urlString: String){
        guard let url = URL(string: urlString) else { return }
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            if error != nil {return}
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else{ return }
            guard let data = data else{return}
            guard let image = UIImage(data: data) else { return }
            DispatchQueue.main.async {
                self?.image = image
            }
        }
        task.resume()
    }

}
