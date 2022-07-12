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
                setupTVShowView(with: geometry)
            case .person:
                setupPersonView()
            }
        }
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                NavBarBackButton(action: dismiss)
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                NavBarLikeButton(action: { viewModel.likePressed(for: item) },
                                 isLiked: viewModel.isItemLiked(item))
            }
        }
    }

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
                    BackdropImage(url: viewModel.getImageUrl(size: .backdrop, path: movie.backdropPath),
                                  height: frame.height * 0.4)
                    Title(title: movie.title)
                }
                ScrollView {
                    VStack(alignment: .leading) {
                        HStack(alignment: .top) {
                            PosterImage(url: viewModel.getImageUrl(size: .poster, path: movie.posterPath),
                                        width: frame.width * 0.3)
                            SideInfo(originalTitle: movie.originalTitle,
                                     tagline: movie.tagline,
                                     genres: movie.genres,
                                     releaseDate: movie.dateString,
                                     runtime: movie.timeString)
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
    
    func setupTVShowView(with geometry: GeometryProxy) -> some View {
        
        let frame = geometry.frame(in: .global)
        
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
                ZStack(alignment: .bottom) {
                    BackdropImage(url: viewModel.getImageUrl(size: .backdrop, path: tvShow.backdropPath),
                                  height: frame.height * 0.4)
                    Title(title: tvShow.name)
                }
                ScrollView {
                    VStack(alignment: .leading) {
                        HStack(alignment: .top) {
                            PosterImage(url: viewModel.getImageUrl(size: .poster, path: tvShow.posterPath),
                                        width: frame.width * 0.3)
                            SideInfo(originalTitle: tvShow.originalName,
                                     tagline: tvShow.tagline,
                                     genres: tvShow.genres,
                                     releaseDate: tvShow.dateString,
                                     lastAirDate: tvShow.lastAirDateString)
                            Spacer()
                        }
                        if let overview = tvShow.overview {
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
}


//struct DetailsView_Previews: PreviewProvider {
//    static var previews: some View {
//        DetailsView()
//    }
//}

