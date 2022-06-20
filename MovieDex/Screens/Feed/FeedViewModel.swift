//
//  FeedViewModel.swift
//  MovieDex
//
//  Created by Admin on 20.06.2022.
//

import Foundation
import SwiftUI

class FeedViewModel: ObservableObject {
    
    let userDefaults = UserDefaults.standard
    
    let networkManager = NetworkManager()
    
    @Published var searchText = ""
    
    @Published var cols: Int = 2
    
    @Published var gridView: Bool = true {
        didSet {
            changeColsCount()
        }
    }
    
    @Published var spacing: CGFloat = 10
    
    @Published var movies: [Movie] = []
    @Published var tvshows: [TVShow] = []
    @Published var persons: [Person] = []
    
    @Published var likedMovies: Set<Int> = []
    @Published var likedTVShows: Set<Int> = []
    @Published var likedPersons: Set<Int> = []
        
    @Published var currentPage: Int = 1
    private var totalPages: Int = 999
    
    @Published var currentListType: MDBListType = .popular {
        didSet{
            reloadList()
        }
    }
    
    @Published var currentItemType: MDBItemType = .movie {
        didSet {
            reloadList()
        }
    }
    
    init() {
        likedMovies = Set(userDefaults.array(forKey: "likedMovies") as? [Int] ?? [])
        likedTVShows = Set(userDefaults.array(forKey: "likedTVShows") as? [Int] ?? [])
        likedPersons = Set(userDefaults.array(forKey: "likedPersons") as? [Int] ?? [])
        reloadList()
        networkManager.delegate = self
    }
    
    func changeColsCount() {
        if gridView {
            cols = 2
        } else {
            cols = 1
        }
    }
    
    func isItemLiked(with id: Int) -> Bool {
        switch currentItemType {
        case .movie:
            return likedMovies.contains(id)
        case .tvShow:
            return likedTVShows.contains(id)
        case .person:
            return likedPersons.contains(id)
        }
    }
    
    func likePressed(id: Int) {
        switch currentItemType {
        case .movie:
            if likedMovies.contains(id) {
                likedMovies.remove(id)
            } else {
                likedMovies.insert(id)
            }
            userDefaults.set(Array(likedMovies), forKey: "likedMovies")
        case .tvShow:
            if likedTVShows.contains(id) {
                likedTVShows.remove(id)
            } else {
                likedTVShows.insert(id)
            }
            userDefaults.set(Array(likedTVShows), forKey: "likedTVShows")
        case .person:
            if likedPersons.contains(id) {
                likedPersons.remove(id)
            } else {
                likedPersons.insert(id)
            }
            userDefaults.set(Array(likedPersons), forKey: "likedPersons")
        }
    }
    
    func loadMoreContent<Data, Item>(currentItem item: Item, in data: Data) async
    where Data: RandomAccessCollection,
          Data.Element: MDBItem,
          Item: MDBItem {
        let thresholdIndex = data.index(data.endIndex, offsetBy: -3)
        if data[thresholdIndex].id == item.id {
            currentPage += 1
            await getList()
        }
    }
    
    private func reloadList() {
        movies = []
        tvshows = []
        persons = []
        currentPage = 1
        Task {
            await getList()
        }
    }
    
    func getList() async {
        await networkManager.fetchList(of: currentListType, currentItemType, on: currentPage)
    }
        
    func getImageUrl(path: String?) -> URL? {
        guard let path = path else {
            return nil
        }
        return networkManager.imageURL(size: .poster, path: path)
    }
    
    func searchResult<Data>(from data: Data) -> [Data.Element]
    where Data: RandomAccessCollection,
          Data.Element: MDBItem {
              guard !searchText.isEmpty else { return data.filter { _ in true }}
              return data.filter { item in
                  item.titleString.lowercased().contains(searchText.lowercased())
              }
          }
}

extension FeedViewModel: NetworkManagerDelegate {
    func didMovieListUpdate(data: [Movie]) {
        movies.append(contentsOf: data)
    }
    
    func didTVShowListUpdate(data: [TVShow]) {
        tvshows.append(contentsOf: data)
    }
    
    func didPersonListUpdate(data: [Person]) {
        persons.append(contentsOf: data)
    }
    
    func didFailWithError(error: Error) {
        print(error.localizedDescription)
    }
    
    
}
