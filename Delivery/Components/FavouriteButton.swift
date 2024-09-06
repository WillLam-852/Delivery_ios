//
//  FavouriteButton.swift
//  Delivery
//
//  Created by Lam Wun Yin on 6/9/2024.
//

import SwiftUI

struct FavouriteButton: View {
    @State var isFilled: Bool
    var isInteractive: Bool
    var action: () -> Void
    
    var body: some View {
        if self.isInteractive {
            Button(action: {
                self.action()
            }, label: {
                Image(systemName: isFilled ? "heart.fill" : "heart")
                    .font(.system(size: 20))
            })
        } else {
            if self.isFilled {
                Image(systemName: "heart.fill")
                    .foregroundColor(.blue)
                    .font(.system(size: 20))
            } else {
                EmptyView()
            }
        }
    }
    
    init(isFilled: Bool, isInteractive: Bool, action: @escaping () -> Void) {
        self.isFilled = isFilled
        self.isInteractive = isInteractive
        self.action = action
    }
}

#Preview {
    return FavouriteButton(isFilled: false, isInteractive: true, action: {})
}
