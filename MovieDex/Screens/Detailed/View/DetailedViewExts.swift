//
//  DetailedViewExts.swift
//  MovieDex
//
//  Created by Admin on 12.07.2022.
//

import Foundation
import SwiftUI
import CachedAsyncImage

extension DetailedView {
  
    struct BackdropImage: View {
        
        let url: URL?
        let height: CGFloat
        
        var body: some View {
            CachedAsyncImage(url: url) { image in
                image.resizable()
                    .scaledToFill()
                    .frame(height: height)
                    .frame(minWidth: .zero, maxWidth: .infinity)
                    .clipped()
                    .overlay(
                        LinearGradient(stops: [.init(color: Color(uiColor: .systemBackground), location: 0.0),
                                               .init(color: Color(uiColor: .systemBackground).opacity(0.0), location: 0.5),
                                               .init(color: Color(uiColor: .systemBackground).opacity(0.0), location: 0.7),
                                               .init(color: Color(uiColor: .systemBackground), location: 1.0)],
                                       startPoint: .bottom,
                                       endPoint: .top)
                    )
            } placeholder: {
                ProgressView().progressViewStyle(.circular)
            }
        }
    }
    
    struct PosterImage: View {
        
        let url: URL?
        let width: CGFloat
        
        var body: some View {
            CachedAsyncImage(url: url) { image in
                image.resizable()
                    .scaledToFill()
                    .frame(width: width)
                    .clipped()
            } placeholder: {
                ProgressView().progressViewStyle(.circular)
            }
        }
    }
    
    struct Title: View {
        
        let title: String
        
        var body: some View {
            Text(title)
                .font(.largeTitle)
                .fontWeight(.bold)
                .lineLimit(2)
                .minimumScaleFactor(0.1)
                .multilineTextAlignment(.center)
                .foregroundColor(.primary)
                .padding([.leading, .trailing], 10)
                .shadow(color: Color(uiColor: .systemBackground), radius: 1)
                .shadow(color: Color(uiColor: .systemBackground), radius: 1)
                .shadow(color: Color(uiColor: .systemBackground), radius: 1)
        }
    }
    
    struct Overview: View {
        
        let text: String?
        
        var body: some View {
            if let text = text,
               text != "" {
                Text(text)
            }
        }
        
    }
}
