//
//  MovieDatabaseModel.swift
//  MovieDex
//
//  Created by Admin on 20.06.2022.
//

import Foundation

// MDB - Movie Database

protocol MDBItem: Decodable {
    var id: Int {get}
    var titleString: String { get }
    var dateString: Date? { get }
    var descriptionString: String { get }
    var ratingString: Double { get }
    var mainImagePath: String? { get }
}

protocol URLPathItemType {
    var rawValue: String {get}
}

struct MovieListResults: Decodable {
    let results: [Movie]
}

struct TVShowListResuls: Decodable {
    let results: [TVShow]
}

struct PersonListResults: Decodable {
    let results: [Person]
}


enum MDBItemType: String, URLPathItemType, Identifiable, CaseIterable {
    case movie
    case tvShow = "tv"
    case person
    
    var id: Self { self }
}

enum MDBListType: String, URLPathItemType, Identifiable, CaseIterable {
    case popular
    case topRated = "top_rated"
    
    var id: Self { self }
}

enum MDBImageSize: String, URLPathItemType {
    case original
    case poster = "w500"
    case backdrop = "w1280"
}

let dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd"
    return formatter
}()
