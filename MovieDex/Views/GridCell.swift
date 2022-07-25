//
//  GridCell.swift
//  MovieDex
//
//  Created by Admin on 20.06.2022.
//

import SwiftUI
import CachedAsyncImage

struct GridCell<Item: MDBItem>: View {
    
    var item: Item
    var isLiked: Bool = false
    var cellType: GridCellType
    var imageURL: URL?
    var likePressed: (Item) -> Void
    
    var body: some View {
        NavigationLink(destination: DetailedView(item: item)) {
            switch cellType {
            case .short:
                setupShortCell()
            case .detailed:
                setupDetailedCell()
            }
        }
    }
    
    private func setupShortCell() -> some View {
        return VStack(spacing: .zero) {
                CachedAsyncImage(url: imageURL) { image in
                    image
                        .resizable()
                        .scaledToFill()
                } placeholder: {
                    ProgressView()
                        .progressViewStyle(.circular)
                }
            VStack(spacing: 10) {
                Text("\(item.titleString)")
                    .font(.title)
                    .fontWeight(.bold)
                    .lineLimit(2)
                    .minimumScaleFactor(0.1)
                if let date = item.dateString {
                    Text(date, style: .date)
                        .font(.footnote)
                        .foregroundColor(Color(uiColor: .systemGray))
                }
                HStack(spacing: 10) {
                    Text(String.init(format: "%.0f", item.ratingString * 10) + "%")
                        .padding(10)
                        .frame(minWidth: .zero, maxWidth: .infinity)
                        .background(alignment: .center) {
                            RoundedRectangle(cornerRadius: 10, style: .continuous)
                                .foregroundColor(Color(uiColor: ratingColor()).opacity(0.75))
                        }
                    Button {
                        likePressed(item)
                    } label: {
                        Image(systemName: isLiked ? "heart.fill" : "heart")
                        
                            .padding(10)
                            .frame(minWidth: .zero, maxWidth: .infinity)
                            .background(alignment: .center) {
                                RoundedRectangle(cornerRadius: 10, style: .continuous)
                                    .foregroundColor(Color(uiColor: .systemPink).opacity(isLiked ? 1.0 : 0.3))
                            }
                    }
                }
            }
            .frame(minHeight: .zero, maxHeight: .infinity)
            .padding(10)
        }
        .foregroundColor(.primary)
        .frame(minHeight: .zero, maxHeight: .infinity)
        .cornerRadius(10)
        .background(RoundedRectangle(cornerRadius: 10, style: .continuous)
                        .foregroundColor(Color(uiColor: .secondarySystemBackground)))
        .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.secondary, lineWidth: 0.5))
    }
    
    private func setupDetailedCell() -> some View {
        return HStack(spacing: .zero) {
            CachedAsyncImage(url: imageURL) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            } placeholder: {
                ProgressView()
                    .progressViewStyle(.circular)
            }
            VStack(spacing: 5) {
                Text("\(item.titleString)")
                    .font(.title)
                    .fontWeight(.bold)
                    .lineLimit(3)
                    .minimumScaleFactor(0.1)
                if let date = item.dateString {
                    Spacer()
                    Text(date, style: .date)
                        .font(.footnote)
                }
                Spacer()
                HStack {
                    Spacer()
                    Label("\(item.ratingString)", systemImage: "star")
                    Spacer()
                    Button {
                        likePressed(item)
                    } label: {
                        Label("Like", systemImage: isLiked ? "heart.fill" : "heart")
                            .labelStyle(.titleAndIcon)
                    }
                    Spacer()
                }
                Spacer()
                Text("\(item.descriptionString)")
                    .lineLimit(6)
                    .minimumScaleFactor(0.8)
                    .multilineTextAlignment(.leading)
            }
            .foregroundColor(.primary)
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .frame(maxWidth: .infinity)
        .cornerRadius(10)
        .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.secondary, lineWidth: 0.3))
    }
    

}

extension GridCell {
    
    enum GridCellType {
        case detailed
        case short
    }
    
    private func ratingColor() -> UIColor {
        switch item.ratingString {
        case 0..<2.5 :
            return .systemRed
        case 2.5..<5.0:
            return .systemOrange
        case 5.0..<7.0:
            return .systemYellow
        case 7.0...:
            return .systemGreen
        default:
            return .systemGreen
        }
    }
}
