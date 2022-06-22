//
//  NetworkManager.swift
//  MovieDex
//
//  Created by Admin on 20.06.2022.
//

import Foundation
import UIKit

protocol NetworkManagerDelegate {
    func didMovieListUpdate(data: [Movie])
    func didTVShowListUpdate(data: [TVShow])
    func didPersonListUpdate(data: [Person])
    func didFailWithError(error: Error)
}

class NetworkManager {
    
    var delegate: NetworkManagerDelegate?
    
    private var urlManager = URLManager()
    
    func fetchDetailedData<Item: MDBItem>(for item: Item) async -> Item? {
        let type: MDBItemType
        
        switch item {
        case is Movie:
            type = .movie
        case is TVShow:
            type = .tvShow
        case is Person:
            type = .person
        default:
            return nil
        }
        
        guard let url = urlManager.detailedURL(for: type, id: item.id) else { return nil }
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            return try decoder.decode(Item.self, from: data)
        } catch {
            print(error)
            return nil
        }
    }
    
    func fetchList(of listType: MDBListType, _ itemType: MDBItemType, on page: Int) async {
        guard let url = urlManager.listURL(listType: listType, itemType: itemType, page: page) else {
            print("Bad url")
            return
        }
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        do {
            print(url)
            let (data,_) = try await URLSession.shared.data(from: url)
            switch itemType {
            case .movie:
                let decodedData = try decoder.decode(MovieListResults.self, from: data)
                DispatchQueue.main.async {
                    self.delegate?.didMovieListUpdate(data: decodedData.results)
                }
            case .tvShow:
                let decodedData = try decoder.decode(TVShowListResuls.self, from: data)
                DispatchQueue.main.async {
                    self.delegate?.didTVShowListUpdate(data: decodedData.results)
                }
            case .person:
                let decodedData = try decoder.decode(PersonListResults.self, from: data)
                DispatchQueue.main.async {
                    self.delegate?.didPersonListUpdate(data: decodedData.results)
                }
            }
        } catch {
            delegate?.didFailWithError(error: error)
        }
    }
    
    func fetchImage(size: MDBImageSize, path: String) async -> UIImage? {
        guard let url = urlManager.imageURL(size: size, path: path) else { return nil }
        do {
            let (data,_) = try await URLSession.shared.data(from: url)
            return UIImage(data: data)
        } catch {
            print(error)
            return nil
        }
    }
    
    func imageURL(size: MDBImageSize, path: String) -> URL? {
        urlManager.imageURL(size: size, path: path)
    }
    
}

