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
        switch currentItem {
        case is Movie:
            let detailedMovie = await networkManager.fetchDetailedData(for: currentItem as! Movie)
            DispatchQueue.main.async {
                self.movie = detailedMovie
            }
        case is TVShow:
            let detailedTVShow = await networkManager.fetchDetailedData(for: currentItem as! TVShow)
            DispatchQueue.main.async {
                self.tvShow = detailedTVShow
            }
        case is Person:
            let detailedPerson = await networkManager.fetchDetailedData(for: currentItem as! Person)
            DispatchQueue.main.async {
                self.person = detailedPerson
            }
        default:
            break
        }
    }
}
