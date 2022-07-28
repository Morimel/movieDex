//
//  FeedView.swift
//  MovieDex
//
//  Created by Admin on 20.06.2022.
//

import SwiftUI
import CachedAsyncImage

struct FeedView: View {
    
    @StateObject var viewModel = FeedViewModel()
    
    var body: some View {
        GeometryReader { geometry in
            let frame = geometry.frame(in: .global)
            NavigationView {
            switch viewModel.currentItemType {
            case .movie:
                feed(for: viewModel.movies, frame: frame)
            case .tvShow:
                feed(for: viewModel.tvshows, frame: frame)
            case .person:
                feed(for: viewModel.persons, frame: frame)
            }
        }
        .navigationViewStyle(.stack)
        }
    }
}

extension FeedView {
    func feed<Data: RandomAccessCollection>(for data: Data, frame: CGRect) -> some View where Data.Element: MDBItem {
        
        return GridView(data: viewModel.searchResult(from: data),
                        cellViewBuilder: { item in
            GridCell(item: item,
                     isLiked: viewModel.isItemLiked(item),
                     imageURL: viewModel.getImageUrl(path: item.mainImagePath),
                     frame: frame,
                     likePressed: { item in viewModel.likePressed(for: item) })
                .onAppear {
                    Task {
                        await viewModel.loadMoreContent(currentItem: item, in: data)
                    }
                }
        })
            .searchable(text: $viewModel.searchText,
                        placement: .navigationBarDrawer(displayMode: .always),
                        prompt: "Type title here")
            .navigationTitle("Feed")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    NavBarSelectItemTypeButton(type: $viewModel.currentItemType)
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavBarSelectListTypeButton(type: $viewModel.currentListType)
                }
            }
            .onAppear {
                viewModel.reloadLikes()
            }
    }
}


//struct AllMoviesView_Previews: PreviewProvider {
//    static var previews: some View {
//        AllMoviesView()
//    }
//}
