//
//  FavouriteButton.swift
//  Delivery
//
//  Created by Lam Wun Yin on 6/9/2024.
//

import SwiftUI

struct FavouriteButton: View {
    @Binding var isFavourite: Bool
    var isInteractive: Bool
    
    var body: some View {
        if self.isInteractive {
            Button(action: {
                self.isFavourite.toggle()
            }, label: {
                Image(systemName: self.isFavourite ? "heart.fill" : "heart")
                    .font(.system(size: 20))
            })
        } else {
            if self.isFavourite {
                Image(systemName: "heart.fill")
                    .foregroundColor(.blue)
                    .font(.system(size: 20))
            } else {
                EmptyView()
            }
        }
    }
}

#Preview {
    @State var isFavourite = false
    return FavouriteButton(isFavourite: $isFavourite, isInteractive: true)
}
