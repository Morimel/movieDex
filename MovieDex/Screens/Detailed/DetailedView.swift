//
//  DetailedView.swift
//  MovieDex
//
//  Created by Admin on 20.06.2022.
//

import SwiftUI
import CachedAsyncImage

struct DetailedView<Item: MDBItem>: View {
    
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
                                                       .init(color: .black.opacity(0.0), location: 0.7),
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
                        .padding(10)
                        .shadow(color: Color(uiColor: .systemBackground), radius: 1)
                        .shadow(color: Color(uiColor: .systemBackground), radius: 1)
                        .shadow(color: Color(uiColor: .systemBackground), radius: 1)
                }
                ScrollView {
                    VStack {
                        Text(movie.originalTitle)
                        HStack {
                            Spacer()
                            if let date = movie.dateString {
                                Text(date, style: .date)
                                    .font(.subheadline)
                            }
                            if let time = movie.timeString {
                                Spacer()
                                Text(time)
                                    .font(.subheadline)
                            }
                            Spacer()
                        }
                    }
                }
                Spacer()
            }
                
                .ignoresSafeArea()
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
}


//struct DetailsView_Previews: PreviewProvider {
//    static var previews: some View {
//        DetailsView()
//    }
//}
