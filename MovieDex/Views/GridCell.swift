//
//  GridCell.swift
//  MovieDex
//
//  Created by Admin on 20.06.2022.
//

import SwiftUI
import CachedAsyncImage

struct GridCell<Item: MDBItem>: View {
    
    var item: Item
    var isLiked: Bool = false
    var imageURL: URL?
    var frame: CGRect
    var likePressed: (Item) -> Void
    
    var cellHeight: CGFloat {
        frame.height / 2
    }
    var posterHeight: CGFloat {
        cellHeight * 0.7
    }
    var infoHeight: CGFloat {
        cellHeight * 0.3
    }
    var buttonsHeight: CGFloat {
        infoHeight * 0.3
    }
    
    var body: some View {
        NavigationLink(destination: DetailedView(item: item)) {
            switch item.type {
            case .movie:
                setupMovieCell()
            case .tvShow:
                setupTVShowCell()
            case .person:
                setupPersonCell()
            }
        }
    }
    
    private func setupMovieCell() -> some View {
        let movie = item as! Movie
        return VStack(spacing: 0) {
            PosterImage(url: imageURL, height: posterHeight)
            VStack(spacing: 5) {
                Title(title: movie.title)
                ReleaseDate(date: movie.dateString)
                HStack(spacing: 10) {
                    RatingButton(value: movie.voteAverage, height: buttonsHeight)
                    LikeButton(item: item,
                               isLiked: isLiked,
                               height: buttonsHeight,
                               action: { item in likePressed(item) })
                }
            }
            .padding(10)
            .frame(height: infoHeight)
            .frame(minWidth: .zero, maxWidth: .infinity)
        }
        .modifier(RoundedCorners(value: 10))
    }
    
    private func setupTVShowCell() -> some View {
        let tvShow = item as! TVShow
        return VStack(spacing: 0) {
            PosterImage(url: imageURL, height: posterHeight)
            VStack(spacing: 5) {
                Title(title: tvShow.name)
                ReleaseDate(date: tvShow.dateString)
                HStack(spacing: 10) {
                    RatingButton(value: tvShow.voteAverage, height: buttonsHeight)
                    LikeButton(item: item,
                               isLiked: isLiked,
                               height: buttonsHeight,
                               action: { item in likePressed(item) })
                }
            }
            .padding(10)
            .frame(height: infoHeight)
            .frame(minWidth: .zero, maxWidth: .infinity)
        }
        .modifier(RoundedCorners(value: 10))
    }
    
    private func setupPersonCell() -> some View {
        let person = item as! Person
        return VStack(spacing: 0) {
            PosterImage(url: imageURL, height: posterHeight)
            VStack(spacing: 5) {
                Title(title: person.name)
                HStack {
                    Information(value: person.knownForDepartment)
                    Information(value: person.localizedGender)
                }
                LikeButton(item: item,
                           isLiked: isLiked,
                           height: buttonsHeight,
                           action: { item in likePressed(item) })
            }
            .padding(10)
            .frame(height: infoHeight)
            .frame(minWidth: .zero, maxWidth: .infinity)
        }
        .modifier(RoundedCorners(value: 10))
    }
}

extension GridCell {
    
    struct Title: View {
        let title: String
        var body: some View {
            Text(title)
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.primary)
                .lineLimit(3)
                .minimumScaleFactor(0.2)
                .frame(minHeight: .zero, maxHeight: .infinity)
                .foregroundColor(.primary)
        }
    }
    
    struct ReleaseDate: View {
        let date: Date?
        var body: some View {
            if let date = date {
                Text(date, style: .date)
                    .font(.footnote)
                    .foregroundColor(Color(uiColor: .systemGray))
            }
        }
    }
    
    struct Information: View {
        let value: String?
        var body: some View {
            if let value = value {
                Text(value)
                    .font(.footnote)
                    .foregroundColor(Color(uiColor: .systemGray))
            }
        }
    }
    
    struct RatingButton: View {
        let value: Double
        let height: CGFloat
        var body: some View {
            Text(String.init(format: "%.0f", value * 10) + "%")
                .font(.title)
                .minimumScaleFactor(0.1)
                .padding(5)
                .frame(minWidth: .zero, maxWidth: .infinity)
                .frame(height: height)
                .foregroundColor(.primary)
                .background(alignment: .center) {
                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                        .foregroundColor(Color(uiColor: ratingColor()).opacity(0.75))
                }
        }
        
        func ratingColor() -> UIColor {
            switch value {
            case 0..<2.5 :
                return .systemRed
            case 2.5..<5.0:
                return .systemOrange
            case 5.0..<7.0:
                return .systemYellow
            case 7.0...:
                return .systemGreen
            default:
                return .systemGray
            }
        }
    }
    
    struct LikeButton: View {
        let item: Item
        let isLiked: Bool
        let height: CGFloat
        let action: (Item) -> Void
        var body: some View {
            Button {
                action(item)
            } label: {
                Image(systemName: isLiked ? "heart.fill" : "heart")
                    .resizable()
                    .scaledToFit()
                    .minimumScaleFactor(0.5)
                    .padding(5)
                    .frame(minWidth: .zero, maxWidth: .infinity)
                    .frame(height: height)
                    .foregroundColor(.primary)
                    .background(alignment: .center) {
                        RoundedRectangle(cornerRadius: 10, style: .continuous)
                            .foregroundColor(Color(uiColor: .systemPink).opacity(isLiked ? 1.0 : 0.3))
                    }
            }
        }
    }
    
    struct PosterImage: View {
        let url: URL?
        let height: CGFloat
        var body: some View {
            CachedAsyncImage(url: url) { image in
                image
                    .resizable()
                    .scaledToFill()
                    .frame(alignment: .bottom)
            } placeholder: {
                ProgressView()
                    .progressViewStyle(.circular)
            }
            .frame(height: height)
            .clipped()
        }
    }
    
    struct RoundedCorners: ViewModifier {
        let value: CGFloat
        func body(content: Content) -> some View {
            return content
                .cornerRadius(10)
                .background(RoundedRectangle(cornerRadius: value, style: .continuous)
                                .foregroundColor(Color(uiColor: .secondarySystemBackground)))
                .overlay(RoundedRectangle(cornerRadius: value).stroke(Color.secondary, lineWidth: 0.5))
        }
    }
}
