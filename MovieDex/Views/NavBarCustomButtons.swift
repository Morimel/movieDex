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
    
    let action: () -> Void
    let isLiked: Bool
    
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
