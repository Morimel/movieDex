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
        NavigationView{
            VStack {
                searchBar()
                feed(for: viewModel.movies)
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    NavBarSelectItemTypeButton(type: $viewModel.currentItemType)
                }
            }
            .labelStyle(.titleAndIcon)
        }
        .navigationViewStyle(.stack)
        
    }
}

extension SearchView {
    func feed<Data: RandomAccessCollection>(for data: Data) -> some View where Data.Element: MDBItem {
        
        return GridView(data: data,
                        cols: 2,
                        spacing: 10,
                        cellViewBuilder: { item in
            GridCell(item: item,
                     isLiked: viewModel.isItemLiked(item),
                     cellType: .short,
                     imageURL: viewModel.getImageUrl(path: item.mainImagePath),
                     likePressed: { item in viewModel.likePressed(for: item) })
                .onAppear {
                    Task {
                        await viewModel.loadMoreContent(currentItem: item, in: data)
                    }
                }
        })
            .onAppear {
            viewModel.reloadLikes()
        }
    }
    
    func searchBar() -> some View {
        HStack {
            Button(action: {
                print("filters")
            }) {
                Image(systemName: "slider.horizontal.3")
                
            }
            .padding()
            .foregroundColor(.secondary)
            .background(Color(.secondarySystemBackground))
            .clipShape(Capsule())
            HStack {
                TextField("Type movie title", text: $viewModel.searchText, onEditingChanged: { isEditing in
                    //self.showCancelButton = true
                }, onCommit: {
                    print("onCommit")
                }).foregroundColor(.primary)
                Button(action: {
                    self.viewModel.searchText = ""
                }) {
                    Image(systemName: "xmark.circle.fill").opacity(viewModel.searchText == "" ? 0 : 1)
                }
                .disabled(viewModel.searchText == "")
            }
            .padding()
            .foregroundColor(.secondary)
            .background(Color(.secondarySystemBackground))
            .clipShape(Capsule())
            Button(action: {
                print("search")
                viewModel.reloadList()
            }) {
                Image(systemName: "magnifyingglass")
                
            }
            .padding()
            .foregroundColor(.secondary)
            .background(Color(.secondarySystemBackground))
            .clipShape(Capsule())
        }
        .fixedSize(horizontal: false, vertical: true)
    }
}

//struct SearchView_Previews: PreviewProvider {
//    static var previews: some View {
//        SearchView()
//    }
//}
