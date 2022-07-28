//
//  NavBarCustomButtons.swift
//  MovieDex
//
//  Created by Admin on 18.07.2022.
//

import Foundation
import SwiftUI

struct NavBarBackButton: View {
    
    let action: DismissAction
    
    var body: some View {
        Button{
            action()
        } label: {
            Image(systemName: "chevron.backward")
                .imageScale(.large)
                .foregroundColor(.primary)
                .shadow(color: Color(uiColor: .systemBackground), radius: 1)
                .shadow(color: Color(uiColor: .systemBackground), radius: 1)
                .shadow(color: Color(uiColor: .systemBackground), radius: 1)
        }
    }
}

struct NavBarLikeButton: View {
    let isLiked: Bool
    let action: () -> Void
    var body: some View {
        Button{
            action()
        } label: {
            Image(systemName: isLiked ? "heart.fill" : "heart")
                .imageScale(.large)
                .foregroundColor(Color(uiColor: .systemPink))
                .shadow(color: Color(uiColor: .systemBackground), radius: 1)
                .shadow(color: Color(uiColor: .systemBackground), radius: 1)
                .shadow(color: Color(uiColor: .systemBackground), radius: 1)
        }
    }
}

struct NavBarSelectItemTypeButton: View {
    @Binding var type: MDBItemType
    var icon: String {
        switch type {
        case .movie:
            return "film"
        case .tvShow:
            return "tv"
        case .person:
            return "person"
        }
    }
    var body: some View {
        Menu {
            VStack {
                Picker("Item type", selection: $type) {
                    ForEach(MDBItemType.allCases) { type in
                        Text(type.rawValue.capitalized)
                    }
                }
            }
        } label: {
            Label(type.rawValue.capitalized, systemImage: icon)
                .foregroundColor(.primary)
        }
    }
}

struct NavBarSelectListTypeButton: View {
    @Binding var type: MDBListType
    var icon: String {
        switch type {
        case .popular:
            return "list.star"
        case .topRated:
            return "list.number"
        }
    }
    var body: some View {
        Menu {
            VStack {
                Picker("List type", selection: $type) {
                    ForEach(MDBListType.allCases) { type in
                        Text(type.rawValue.capitalized)
                    }
                }
            }
        } label: {
            Label(type.rawValue.capitalized, systemImage: icon)
                .foregroundColor(.primary)
        }
    }
}
