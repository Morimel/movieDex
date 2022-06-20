//
//  DetailedView.swift
//  MovieDex
//
//  Created by Admin on 20.06.2022.
//

import SwiftUI

struct DetailedView<Item: MDBItem>: View {
    
    var item: Item
    
    var body: some View {
        
        VStack {
            Text("\(item.id)")
            //Text(item.originalTitle)
            //if let date = item.validReleaseDate {
            //    Text(date, style: .date)
            //} else {
            //    Text("TBA")
            //}
            //Text(item.overview)
            
        }
    }
}

//struct DetailsView_Previews: PreviewProvider {
//    static var previews: some View {
//        DetailsView()
//    }
//}
