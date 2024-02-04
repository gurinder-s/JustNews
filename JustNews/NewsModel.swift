//
//  NewsModel.swift
//  JustNews
//
//  Created by G on 04/02/2024.
//
import Foundation

struct NewsResponse: Codable,Hashable{
    let meta: Meta
    let data: [NewsModel]
}

struct NewsModel: Codable, Hashable{

    let uuid: String
    let title: String
    let description: String
    let keywords: String
    let snippet: String
    let url: String
    let imageURL: String
    let language: String
    let publishedAt: String
    let source: String
    let categories: [String]
    let relevanceScore: Int?
    let locale: String
    
    enum CodingKeys: String, CodingKey{
        case uuid,title,description,keywords,snippet,url,language,source,categories,locale
        case imageURL = "image_url"
        case publishedAt = "published_at"
        case relevanceScore = "relevance_score"
    }
    


}

struct Meta: Codable, Hashable{
    let found: Int
    let returned: Int
    let limit: Int
    let page: Int
}
