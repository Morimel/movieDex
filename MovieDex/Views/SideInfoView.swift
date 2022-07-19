//
//  SideInfoView.swift
//  MovieDex
//
//  Created by Admin on 18.07.2022.
//

import Foundation
import SwiftUI


struct SideInfo<Item: MDBItem>: View {
    
    let item: Item
    
    var body: some View {
        switch item.type {
        case .movie:
            setupMovieSideInfo(movie: item as? Movie ?? nil)
        case .tvShow:
            setupTVShowSideInfo(tvShow: item as? TVShow ?? nil)
        case .person:
            setupPersonSideInfo(person: item as? Person ?? nil)
        }
    }
    
    func setupMovieSideInfo(movie: Movie?) -> some View {
        guard let movie = movie else {
            return AnyView(
                ProgressView()
                    .progressViewStyle(.circular)
            )
        }
        return AnyView(
            VStack(alignment: .leading, spacing: 10) {
                OriginalTitle(title: movie.originalTitle)
                Tagline(tagline: movie.tagline)
                Genres(genres: movie.genres)
                ReleaseDate(releaseDate: movie.dateString)
                Runtime(runtime: movie.timeString)
                Spacer()
            }
                .frame(minWidth: .zero, maxWidth: .infinity, alignment: .leading)
        )
    }
    
    func setupTVShowSideInfo(tvShow: TVShow?) -> some View {
        guard let tvShow = tvShow else {
            return AnyView(
                ProgressView()
                    .progressViewStyle(.circular)
            )
        }
        return AnyView(
            VStack(alignment: .leading, spacing: 10) {
                OriginalTitle(title: tvShow.originalName)
                Tagline(tagline: tvShow.tagline)
                Genres(genres: tvShow.genres)
                ReleaseDate(releaseDate: tvShow.dateString)
                Status(status: tvShow.statusString)
                NumberOfEpisodes(number: tvShow.numberOfEpisodesString)
                Runtime(runtime: tvShow.runtime)
                Spacer()
            }
                .frame(minWidth: .zero, maxWidth: .infinity, alignment: .leading)
        )
    }
    
    func setupPersonSideInfo(person: Person?) -> some View {
        guard let person = person else {
            return AnyView(
                ProgressView()
                    .progressViewStyle(.circular)
            )
        }
        return AnyView(
            VStack(alignment: .leading, spacing: 10) {
                OriginalTitle(title: person.knownAsString)
                Tagline(tagline: person.knownForDepartment)
                Tagline(tagline: person.genderString)
                ReleaseDate(releaseDate: person.dateString)
                Spacer()
            }
                .frame(minWidth: .zero, maxWidth: .infinity, alignment: .leading)
        )
    }
}

extension SideInfo {
    struct OriginalTitle: View {
        
        let title: String?
        
        var body: some View {
            if let title = title {
                Text(title)
                    .font(.headline)
                    .lineLimit(2)
                    .minimumScaleFactor(0.1)
            }
        }
    }
    
    struct Tagline: View {
        
        let tagline: String?
        
        var body: some View {
            if let tagline = tagline,
               tagline != "" {
                Text(tagline)
                    .font(.subheadline)
                    .fontWeight(.light)
                    .lineLimit(2)
                    .minimumScaleFactor(0.1)
            }
        }
    }
    
    struct NumberOfEpisodes: View {
        
        let number: String?
        
        var body: some View {
            if let number = number {
                Label {
                Text(number)
                    .font(.subheadline)
                    .fontWeight(.light)
                    .lineLimit(2)
                    .minimumScaleFactor(0.1)
                } icon: {
                    Image(systemName: "play.circle")
                }
            }
        }
    }
    
    struct Status: View {
        
        let status: String?
        
        var body: some View {
            if let status = status {
                Label {
                Text(status)
                    .font(.subheadline)
                } icon: {
                    Image(systemName: "tv").imageScale(.small)
                }
            }
        }
    }
    
    struct Runtime: View {
        
        let runtime: String?
        
        var body: some View {
            if let runtime = runtime {
                Label {
                    Text(runtime)
                        .font(.subheadline)
                        .fontWeight(.light)
                        .lineLimit(2)
                        .minimumScaleFactor(0.1)
                } icon: {
                    Image(systemName: "timer")
                }
            }
        }
    }
    
    struct Genres: View {
        
        let genres: [Genre]?
        
        var body: some View {
            if let genres = genres,
               !genres.isEmpty {
                let output = genres.map { $0.name }.joined(separator: " / ")
                
                Text(output)
                    .font(.subheadline)
                    .fontWeight(.thin)
                    .lineLimit(2)
                    .minimumScaleFactor(0.5)
            }
        }
    }
    
    struct ReleaseDate: View {
        
        let releaseDate: Date?
        
        var body: some View {
            if let releaseDate = releaseDate {
                Label {
                    VStack(alignment: .leading) {
                        Text(releaseDate, style: .date)
                            .font(.subheadline)
                    }
                } icon: {
                    Image(systemName: "calendar")
                }
            }
        }
    }
}
