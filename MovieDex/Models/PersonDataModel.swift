//
//  PersonDataModel.swift
//  MovieDex
//
//  Created by Admin on 20.06.2022.
//

import Foundation
import NaturalLanguage

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
    
    var dateString: Date? {
        if let day = birthday,
           !day.isEmpty {
            return dateFormatter.date(from: day)
        } else {
            return nil
        }
    }
    
    var dates: (Date, Date?, Int)? {
        guard let birthday = birthday,
              let birthdate = dateFormatter.date(from: birthday)
        else { return nil }
        let now = Date()
        let endDate = dateFormatter.date(from: deathday ?? "") ?? now
        let calendar = Calendar.current
        let ageComponents = calendar.dateComponents([.year], from: birthdate, to: endDate)
        let age = ageComponents.year!
        let deathdate = endDate == now ? nil : endDate
        return (birthdate, deathdate, age)
    }

    var descriptionString: String {
        return "Gender: \(localizedGender)"
    }
    
    var ratingString: Double {
        return popularity ?? 0
    }
    
    var mainImagePath: String? {
        return profilePath
    }
    
    var localizedGender: String {
        switch gender {
        case 0:
            return "Не определён"
        case 1:
            return "Женщина"
        case 2:
            return "Мужчина"
        case 3:
            return "Небинарный"
        default:
            return ""
        }
    }

    func localizedName() -> String {
        guard let names = alsoKnownAs,
              !names.isEmpty
        else { return name }
        for name in names {
            let language = NLLanguageRecognizer.dominantLanguage(for: name)
            if language == .russian || language == .bulgarian {
                return name
            }
        }
        return name
    }
}
