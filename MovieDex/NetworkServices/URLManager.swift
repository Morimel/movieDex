//
//  URLManager.swift
//  MovieDex
//
//  Created by Admin on 20.06.2022.
//

import Foundation

struct URLManager {
    
    private var baseURLComponents: URLComponents = {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.themoviedb.org"
        components.path = "/3"
        components.queryItems = []
        components.setQueryItems(with: [.apiKey: "42666b8d685dd5cc80ec6a103467da9a",
                                        .language: "ru-RU"])
        return components
    }()
    
    private var baseImageURLComponents: URLComponents = {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "image.tmdb.org"
        components.path = "/t/p"
        return components
    }()
    
    func detailedURL(for type: MDBItemType, id: Int) -> URL? {
        var urlComponents = baseURLComponents
        urlComponents.setPath(with: [type])
        urlComponents.addToPath(id: id)
        return urlComponents.url
    }
    
    func listURL(listType: MDBListType, itemType: MDBItemType, page: Int) -> URL? {
        var urlComponents = baseURLComponents
        urlComponents.setPath(with: [itemType, listType])
        urlComponents.setQueryItems(with: [.page: String(page)])
        return urlComponents.url
    }
    
    func searchURL(itemType: MDBItemType, query: String, page: Int) -> URL? {
        var urlComponents = baseURLComponents
        urlComponents.addToPath(value: "/search")
        urlComponents.setPath(with: [itemType])
        urlComponents.setQueryItems(with: [.query: query,
                                           .page: String(page)])
        return urlComponents.url
    }
    
    func imageURL(size: MDBImageSize, path: String) -> URL? {
        var urlComponents = baseImageURLComponents
        urlComponents.setPath(with: [size])
        urlComponents.addToPath(value: path)
        return urlComponents.url
    }
}

extension URLComponents {
    enum URLQueryItemType: String {
        case apiKey = "api_key"
        case language
        case page
        case query
    }
    
    mutating func setQueryItems(with parameters: [URLQueryItemType : String]) {
        self.queryItems?.append(contentsOf: parameters.map { URLQueryItem(name: $0.key.rawValue, value: $0.value) })
    }
    
    mutating func setPath(with parameters: [URLPathItemType]) {
        parameters.forEach { self.path += "/\($0.rawValue)" }
    }
    
    mutating func addToPath(id: Int) {
        self.path += "/\(id)"
    }
    
    mutating func addToPath(value: String) {
        self.path += value
    }
}
