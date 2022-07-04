//
//  TVShowDataModel.swift
//  MovieDex
//
//  Created by Admin on 20.06.2022.
//

import Foundation

struct TVShow: MDBItem {
    
    var id: Int
    let type: MDBItemType = .tvShow
    let originalName: String
    let name: String
    let overview: String
    let posterPath: String?
    let firstAirDate: String
    let voteAverage: Double
    let voteCount: Int
    
    let tagline: String?
    
    private enum CodingKeys: String, CodingKey {
        case id, originalName, name, overview, posterPath, firstAirDate, voteAverage, voteCount, tagline
    }
    
    var titleString: String {
        return name
    }
    
    var dateString: Date? {
        if firstAirDate.isEmpty {
            return nil
        } else {
            return dateFormatter.date(from: firstAirDate)
        }
    }
    
    var descriptionString: String {
        return overview
    }
    
    var ratingString: Double {
        return voteAverage
    }
    
    var mainImagePath: String? {
        if let posterPath = posterPath {
            return posterPath
        } else {
            return nil
        }
    }
}


