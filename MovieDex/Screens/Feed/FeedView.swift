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
        NavigationView {
            switch viewModel.currentItemType {
            case .movie:
                feed(for: viewModel.movies)
            case .tvShow:
                feed(for: viewModel.tvshows)
            case .person:
                feed(for: viewModel.persons)
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

extension FeedView {
    func feed<Data: RandomAccessCollection>(for data: Data) -> some View where Data.Element: MDBItem {
        
        return GridView(data: viewModel.searchResult(from: data),
                              cols: viewModel.cols,
                              spacing: viewModel.spacing,
                              cellViewBuilder: { item in
            GridCell(item: item,
                     isLiked: viewModel.isItemLiked(with: item.id),
                     cellType: viewModel.gridView ? .short : .detailed,
                     imageURL: viewModel.getImageUrl(path: item.mainImagePath),
                     likePressed: { id in viewModel.likePressed(id: id) })
                .onAppear {
                    Task {
                        await viewModel.loadMoreContent(currentItem: item, in: data)
                    }
                }
        })
            .searchable(text: $viewModel.searchText,
                        placement: .navigationBarDrawer(displayMode: .always),
                        prompt: "Type movie title")
            .navigationBarTitle("All movies", displayMode: .inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        viewModel.gridView.toggle()
                    } label: {
                        let imageName = viewModel.gridView ? "rectangle.grid.2x2" : "rectangle.grid.1x2"
                        Image(systemName: imageName)
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Menu {
                        VStack {
                            Picker("List type", selection: $viewModel.currentListType) {
                                ForEach(MDBListType.allCases) { type in
                                    Text(type.rawValue.capitalized)
                                }
                            }
                            Picker("Item type", selection: $viewModel.currentItemType) {
                                ForEach(MDBItemType.allCases) { type in
                                    Text(type.rawValue.capitalized)
                                }
                            }
                        }
                    } label: {
                        Image(systemName: "slider.horizontal.3")
                    }
                }
            }
    }
}


//struct AllMoviesView_Previews: PreviewProvider {
//    static var previews: some View {
//        AllMoviesView()
//    }
//}
