//
//  SearchView.swift
//  MovieDex
//
//  Created by Admin on 20.06.2022.
//

import SwiftUI

struct SearchView: View {
    
    @StateObject var viewModel = SearchViewModel()
    
    var body: some View {
        GeometryReader { geometry in
            let frame = geometry.frame(in: .global)
            NavigationView {
                switch viewModel.currentItemType {
                case .movie:
                    setupSearchResult(data: viewModel.movies, frame: frame)
                case .tvShow:
                    setupSearchResult(data: viewModel.tvshows, frame: frame)
                case .person:
                    setupSearchResult(data: viewModel.persons, frame: frame)
                }
            }
            .searchable(text: $viewModel.searchText,
                        placement: .navigationBarDrawer(displayMode: .always),
                        prompt: "Type a title here")
            .onSubmit(of: .search) {
                viewModel.reloadList()
            }
            .navigationViewStyle(.stack)
        }
    }
}

extension SearchView {
    func setupSearchResult<Data>(data: Data, frame: CGRect) -> some View
    where Data: RandomAccessCollection, Data.Element: MDBItem {
        
        return GridView(data: data,
                        cellViewBuilder: { item in
            GridCell(item: item,
                     isLiked: viewModel.isLiked(item),
                     imageURL: viewModel.getImageUrl(item.mainImagePath),
                     frame: frame,
                     likePressed: { item in viewModel.likePressed(item) })
                .onAppear {
                    Task {
                        await viewModel.loadMoreContent(currentItem: item, from: data)
                    }
                }
        })
            .onAppear {
                viewModel.reloadLikes()
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    NavBarSelectItemTypeButton(type: $viewModel.currentItemType)
                }
            }
            .labelStyle(.titleAndIcon)
            .navigationTitle("Search")
            .navigationBarTitleDisplayMode(.inline)
    }
}

//struct SearchView_Previews: PreviewProvider {
//    static var previews: some View {
//        SearchView()
//    }
//}
