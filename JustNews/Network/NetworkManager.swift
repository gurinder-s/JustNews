//
//  NetworkManager.swift
//  JustNews
//
//  Created by G on 04/02/2024.
//

import Foundation

class NetworkManager{
    static let shared = NetworkManager()
    private let baseURL = "https://api.thenewsapi.com/v1/news/"
    private init(){}
    private let apiToken = "SMlMaWVpbElU69HJc2iiwEZ8URed8I2082G9K4Pi"
    
    func fetchTopStories(completed: @escaping(Result<NewsResponse, JNError>) -> Void){
        let endpoint = baseURL + "top?api_token=" + apiToken + "&locale=us&limit=3"
        guard let url = URL(string: endpoint) else{
            completed(.failure(.unableToComplete))
            return
        }
        let task = URLSession.shared.dataTask(with: url) {data,response,error in
            if let _ = error{
                completed(.failure(.unableToComplete))
                return
            }
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else{
                completed(.failure(.unableToComplete))
                return
            }
            guard let data = data else{
                completed(.failure(.invalidData))
                return
            }
            do{
                let decoder = JSONDecoder()
                let topStories = try decoder.decode(NewsResponse.self,from:data)
                completed(.success(topStories))
            }catch{
                completed(.failure(.cantDecode))
            }
        }
        task.resume()
    }
}
