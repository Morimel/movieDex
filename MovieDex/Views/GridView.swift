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
    let cellViewBuilder: (Data.Element) -> Content
    
    init(data: Data, cellViewBuilder: @escaping (Data.Element) -> Content) {
        self.data = data
        self.cellViewBuilder = cellViewBuilder
    }
    
    var body: some View {
        
        let columns: [GridItem] = Array(repeating: GridItem(.flexible()), count: 2)
        
        LazyVGrid(columns: columns) {
            ForEach(data, id: \.id) { item in
                self.cellViewBuilder(item)
            }
        }
        .padding(.horizontal, 10)
    }
}

