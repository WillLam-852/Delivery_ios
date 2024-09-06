//
//  GoodsPictureAsyncImage.swift
//  Delivery
//
//  Created by Lam Wun Yin on 6/9/2024.
//

import Foundation
import SwiftUI

struct GoodsPictureAsyncImage: View {
    var url: URL
    
    var body: some View {
        AsyncImage(url: url) { phase in
            switch phase {
                case .empty:
                    ProgressView()
                case .success(let image):
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                case .failure:
                    Image(systemName: "photo")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .foregroundColor(.gray)
                @unknown default:
                    EmptyView()
            }
        }
    }
    
}

#Preview {
    GoodsPictureAsyncImage(url: URL(string: "https://loremflickr.com/320/240/cat?lock=9953")!)
}
