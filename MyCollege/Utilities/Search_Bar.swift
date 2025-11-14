//
//  Search_Bar.swift
//  MyCollege
//
//  Created by Tyson Yung on 11/29/25.
//

import SwiftUI
import SwiftData

struct Search_Bar: View {
    @Binding var exploreText: String
    @FocusState private var isFocused: Bool
    var placementText: String = "Discover My College"
    
    var body: some View {
        HStack(alignment:.center) {
            Spacer()
            HStack{
                Image(systemName: "magnifyingglass")
                    .foregroundStyle(.duskBlue)
                TextField(placementText, text: $exploreText, prompt: Text(placementText).foregroundStyle(.duskBlue))
                    .focused($isFocused)
                    .contentShape(.rect)
                    .foregroundStyle(.duskBlue)
                    .tint(.duskBlue)
            }
            .font(.headline)
            .padding()
            .background() {
                RoundedRectangle(cornerRadius: 25)
                    .stroke(.duskBlue, lineWidth: 10)
                    .fill(.white)
            }
            
            Spacer()
        }
    }
}

struct Search_Bar_Prievews: PreviewProvider {
    static var previews: some View {
        Search_Bar(exploreText: .constant(""))
    }
}
