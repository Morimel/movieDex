//
//  DetailedView.swift
//  MovieDex
//
//  Created by Admin on 20.06.2022.
//

import SwiftUI
import CachedAsyncImage

struct DetailedView<Item: MDBItem>: View {
    
    @Environment(\.dismiss) private var dismiss
    
    @StateObject var viewModel = DetailedViewModel()
    
    var item: Item
    
    var body: some View {
        GeometryReader { geometry in
            switch item.type {
            case .movie:
                setupMovieView(with: geometry)
            case .tvShow:
                setupTVShowView()
            case .person:
                setupPersonView()
            }
        }
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                navBackButton()
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                navLikeButton()
            }
        }
    }
}

extension DetailedView {
    func setupMovieView(with geometry: GeometryProxy) -> some View {
        
        let frame = geometry.frame(in: .global)
        
        if viewModel.currentItem == nil {
            viewModel.currentItem = item
        }
        guard let movie = viewModel.movie else {
            return AnyView(
                ProgressView()
                    .progressViewStyle(.circular)
            )
        }
        return AnyView(
            VStack {
                ZStack(alignment: .bottom) {
                    CachedAsyncImage(url: viewModel.getImageUrl(size: .backdrop, path: movie.backdropPath)) { image in
                        image.resizable()
                            .scaledToFill()
                            .frame(height: frame.height * 0.4)
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
                    Text(movie.title)
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
                ScrollView {
                    VStack(alignment: .leading) {
                        HStack(alignment: .top) {
                            CachedAsyncImage(url: viewModel.getImageUrl(size: .poster, path: movie.posterPath)) { image in
                                image.resizable()
                                    .scaledToFill()
                                    .frame(width: frame.width * 0.3)
                            } placeholder: {
                                ProgressView().progressViewStyle(.circular)
                            }
                            VStack(alignment: .leading, spacing: 10) {
                                Text(movie.originalTitle)
                                    .font(.headline)
                                    .lineLimit(2)
                                    .minimumScaleFactor(0.1)
                                if let tagline = movie.tagline,
                                   tagline != "" {
                                    Text(tagline)
                                        .font(.subheadline)
                                        .fontWeight(.light)
                                        .lineLimit(2)
                                        .minimumScaleFactor(0.1)
                                }
                                if let genres = movie.genres,
                                   !genres.isEmpty {
                                    printGenres(genres)
                                }
                                if let date = movie.dateString {
                                    Label {
                                        Text(date, style: .date)
                                            .font(.subheadline)
                                    } icon: {
                                        Image(systemName: "calendar")
                                    }
                                }
                                if let time = movie.timeString {
                                    Label {
                                        Text(time)
                                            .font(.subheadline)
                                    } icon: {
                                        Image(systemName: "timer")
                                    }
                                }
                            }
                            Spacer()
                        }
                        if let overview = movie.overview {
                            Text(overview)
                        }
                        
                    }
                    .padding([.leading, .trailing], 10)
                }
                Spacer()
            }
                .edgesIgnoringSafeArea([.top, .leading, .trailing])
        )
    }
    
    func setupTVShowView() -> some View {
        if viewModel.currentItem == nil {
            viewModel.currentItem = item
        }
        guard let tvShow = viewModel.tvShow else {
            return AnyView(
                ProgressView()
                    .progressViewStyle(.circular)
            )
        }
        return AnyView(
            VStack {
                Text(tvShow.name)
                Text(tvShow.dateString!,style: .date)
                Text(tvShow.tagline ?? "")
            }
        )
    }
    func setupPersonView() -> some View {
        if viewModel.currentItem == nil {
            viewModel.currentItem = item
        }
        guard let person = viewModel.person else {
            return AnyView(
                ProgressView()
                    .progressViewStyle(.circular)
            )
        }
        return AnyView(
            VStack {
                Text(person.name)
                Text("Gender: \(person.gender)")
                Text(person.dateString!,style: .date)
            }
        )
    }
    
    func printGenres(_ genres: [Genre]) -> some View {
        
        var baseString = ""
        
        genres.forEach { item in
            baseString += "\(item.name?.capitalized ?? "") "
        }
        return Text(baseString)
            .font(.subheadline)
            .fontWeight(.thin)
    } 
}


//struct DetailsView_Previews: PreviewProvider {
//    static var previews: some View {
//        DetailsView()
//    }
//}

extension DetailedView {
    
    func navBackButton() -> some View {
        return Button{
            dismiss()
        } label: {
            Image(systemName: "chevron.backward")
                .imageScale(.large)
                .foregroundColor(.primary)
                .shadow(color: Color(uiColor: .systemBackground), radius: 1)
                .shadow(color: Color(uiColor: .systemBackground), radius: 1)
                .shadow(color: Color(uiColor: .systemBackground), radius: 1)
        }
    }
    
    func navLikeButton() -> some View {
        return Button{
            viewModel.likePressed(for: item)
        } label: {
            Image(systemName: viewModel.isItemLiked(item) ? "heart.fill" : "heart")
                .imageScale(.large)
                .foregroundColor(Color(uiColor: .systemPink))
                .shadow(color: Color(uiColor: .systemBackground), radius: 1)
                .shadow(color: Color(uiColor: .systemBackground), radius: 1)
                .shadow(color: Color(uiColor: .systemBackground), radius: 1)
        }
    }
}
