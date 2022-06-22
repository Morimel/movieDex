//
//  DetailedView.swift
//  MovieDex
//
//  Created by Admin on 20.06.2022.
//

import SwiftUI

struct DetailedView<Item: MDBItem>: View {
    
    @StateObject var viewModel = DetailedViewModel()
    
    var item: Item
    
    var body: some View {
        switch item {
        case is Movie:
            setupMovieView()
        case is TVShow:
            setupTVShowView()
        case is Person:
            setupPersonView()
        default:
            Text("error")
        }
    }
}

extension DetailedView {
    func setupMovieView() -> some View {
        if viewModel.currentItem == nil {
            viewModel.currentItem = item
        }
        guard let safeMovie = viewModel.movie else {
            return AnyView(
                ProgressView()
                    .progressViewStyle(.circular)
            )
        }
        return AnyView(
            VStack {
                Text(safeMovie.title)
                Text(safeMovie.dateString!,style: .date)
                Text(safeMovie.tagline ?? "")
                Text("\(safeMovie.runtime ?? 0)")
            }
        )
    }
    
    func setupTVShowView() -> some View {
        if viewModel.currentItem == nil {
            viewModel.currentItem = item
        }
        guard let safeTVShow = viewModel.tvShow else {
            return AnyView(
                ProgressView()
                    .progressViewStyle(.circular)
            )
        }
        return AnyView(
            VStack {
                Text(safeTVShow.name)
                Text(safeTVShow.dateString!,style: .date)
                Text(safeTVShow.tagline ?? "")
            }
        )
    }
    func setupPersonView() -> some View {
        if viewModel.currentItem == nil {
            viewModel.currentItem = item
        }
        guard let safePerson = viewModel.person else {
            return AnyView(
                ProgressView()
                    .progressViewStyle(.circular)
            )
        }
        return AnyView(
            VStack {
                Text(safePerson.name)
                Text("Gender: \(safePerson.gender)")
                Text(safePerson.dateString!,style: .date)
            }
        )
    }
}


//struct DetailsView_Previews: PreviewProvider {
//    static var previews: some View {
//        DetailsView()
//    }
//}
