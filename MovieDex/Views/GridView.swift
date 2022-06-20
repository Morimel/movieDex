//
//  GridView.swift
//  MovieDex
//
//  Created by Admin on 20.06.2022.
//

import SwiftUI

struct GridView<Content, Data>: View
where Content: View,
      Data: RandomAccessCollection,
      Data.Element: MDBItem {
    
    let data: Data
    let cols: Int
    let spacing: CGFloat
    let cellViewBuilder: (Data.Element) -> Content
    
    init(data: Data, cols: Int, spacing: CGFloat, cellViewBuilder: @escaping (Data.Element) -> Content) {
        self.data = data
        self.cols = cols
        self.spacing = spacing
        self.cellViewBuilder = cellViewBuilder
    }
    
    var body: some View {
        ScrollView {
            self.setupView().padding(spacing)
        }
        if data.isEmpty {
            Text("No movies")
        }
        
    }
    
    private func setupView() -> some View {
        
        let columns: [GridItem] = Array(repeating: GridItem(.flexible(), spacing: spacing, alignment: .top), count: cols)
        
        return LazyVGrid(columns: columns, alignment: .center) {
            ForEach(data, id: \.id) { item in
                self.cellViewBuilder(item)
            }
        }
    }
}

