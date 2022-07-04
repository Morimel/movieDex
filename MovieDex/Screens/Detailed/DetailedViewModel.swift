//
//  DetailedViewModel.swift
//  MovieDex
//
//  Created by Admin on 20.06.2022.
//

import Foundation

class DetailedViewModel: ObservableObject {
    
    var networkManager = NetworkManager()
    
    var currentItem: MDBItem? {
        didSet {
            Task {
                await fetchDetails()
            }
        }
    }
    
    @Published var movie: Movie?
    @Published var tvShow: TVShow?
    @Published var person: Person?
    
    func fetchDetails() async {
        guard let currentItem = currentItem else { return }
        switch currentItem.type {
        case .movie:
            let detailedMovie = await networkManager.fetchDetailedData(for: currentItem as! Movie)
            DispatchQueue.main.async {
                self.movie = detailedMovie
            }
        case .tvShow:
            let detailedTVShow = await networkManager.fetchDetailedData(for: currentItem as! TVShow)
            DispatchQueue.main.async {
                self.tvShow = detailedTVShow
            }
        case .person:
            let detailedPerson = await networkManager.fetchDetailedData(for: currentItem as! Person)
            DispatchQueue.main.async {
                self.person = detailedPerson
            }
        }
    }
    
    func getImageUrl(size: MDBImageSize, path: String?) -> URL? {
        guard let path = path else {
            return nil
        }
        return networkManager.imageURL(size: size, path: path)
    }
    
}
