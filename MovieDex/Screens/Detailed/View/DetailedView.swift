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
                setupPersonView(with: geometry)
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
                                        width: frame.width * 0.35)
                            SideInfo(item: movie)
                            Spacer()
                        }
                        Overview(text: movie.overview)
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
            VStack(alignment: .leading) {
                ZStack(alignment: .bottom) {
                    BackdropImage(url: viewModel.getImageUrl(size: .backdrop, path: tvShow.backdropPath),
                                  height: frame.height * 0.4)
                    Title(title: tvShow.name)
                }
                ScrollView {
                    VStack(alignment: .leading) {
                        HStack(alignment: .top) {
                            PosterImage(url: viewModel.getImageUrl(size: .poster, path: tvShow.posterPath),
                                        width: frame.width * 0.35)
                            SideInfo(item: tvShow)
                            Spacer()
                        }
                        Overview(text: tvShow.overview)
                    }
                    .padding([.horizontal], 10)
                }
            }
                .edgesIgnoringSafeArea([.top, .leading, .trailing])
        )
    }
    func setupPersonView(with geometry: GeometryProxy) -> some View {
        
        let frame = geometry.frame(in: .global)
        
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
            ScrollView {
                VStack(alignment: .leading) {
                    HStack(alignment: .top) {
                        PosterImage(url: viewModel.getImageUrl(size: .poster, path: person.profilePath),
                                    width: frame.width * 0.35)
                        SideInfo(item: person)
                            .border(.green)
                        //Spacer()
                    }
                    Overview(text: person.biography)
                }
                .padding([.horizontal], 10)
            }
                .navigationTitle(person.name)
        )
    }
}


//struct DetailsView_Previews: PreviewProvider {
//    static var previews: some View {
//        DetailsView()
//    }
//}

