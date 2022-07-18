//
//  PersonDataModel.swift
//  MovieDex
//
//  Created by Admin on 20.06.2022.
//

import Foundation

struct Person: MDBItem {
    
    var id: Int
    let type: MDBItemType = .person
    let name: String
    let gender: Int?
    let profilePath: String?
    let popularity: Double?
    let birthday: String?
    let deathday: String?
    
    let biography: String?
    let knownForDepartment: String?
    let placeOfBirth: String?
    let alsoKnownAs: [String]?
    
    private enum CodingKeys: String, CodingKey {
        case id, name, gender, profilePath, popularity, birthday, deathday, biography, knownForDepartment, placeOfBirth, alsoKnownAs
    }
    
    var titleString: String {
        return name
    }
    
    var knownAsString: String? {
        if let alsoKnownAs = alsoKnownAs {
            return alsoKnownAs.first
        } else {
            return nil
        }
    }
    
    var dateString: Date? {
        if let day = birthday,
              !day.isEmpty {
                return dateFormatter.date(from: day)
        } else {
            return nil
    }
        
    }
    
    var descriptionString: String {
        return "Gender: \(genderString)"
    }
    
    var ratingString: Double {
        return popularity ?? 0
    }
    
    var mainImagePath: String? {
        return profilePath
    }
    
    var genderString: String {
        switch gender {
        case 0:
            return "middle"
        case 1:
            return "Женщина"
        case 2:
            return "Мужчина"
        case 3:
            return "hz"
        default:
            return "animal"
        }
    }
    
}
