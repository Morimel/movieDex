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
    
    struct SideInfo: View {
        
        var originalTitle: String?
        var tagline: String?
        var genres: [Genre]?
        var releaseDate: Date?
        var lastAirDate: Date?
        var runtime: String?
        var birthday: Date?
        var deathday: Date?
        var gender: String?
        
        var body: some View {
            VStack(alignment: .leading, spacing: 10) {
                if let originalTitle = originalTitle {
                    Text(originalTitle)
                        .font(.headline)
                        .lineLimit(2)
                        .minimumScaleFactor(0.1)
                }
                if let tagline = tagline,
                   tagline != "" {
                    Text(tagline)
                        .font(.subheadline)
                        .fontWeight(.light)
                        .lineLimit(2)
                        .minimumScaleFactor(0.1)
                }
                if let genres = genres,
                   !genres.isEmpty {
                    printGenres(genres)
                }
                
                if let releaseDate = releaseDate {
                    Label {
                        VStack(alignment: .leading) {
                            Text(releaseDate, style: .date)
                                .font(.subheadline)
                            if let lastAirDate = lastAirDate {
                                Text(". . .")
                                Text(lastAirDate, style: .date)
                                    .font(.subheadline)
                                Spacer()
                            }
                        }
                    } icon: {
                        Image(systemName: "calendar")
                    }
                }
                if let runtime = runtime {
                    Label {
                        Text(runtime)
                            .font(.subheadline)
                    } icon: {
                        Image(systemName: "timer")
                    }
                }
                Spacer()
            }
        }
        
        func printGenres(_ genres: [Genre]) -> some View {
            
            let output = genres.map { $0.name.capitalized }.joined(separator: " / ")
            
            return Text(output)
                .font(.subheadline)
                .fontWeight(.thin)
        }
    }
    
    
    
}
