//
//  SectionHeader.swift
//  MyCollege
//
//  Created by Tyson Yung on 12/11/25.
//

import SwiftUI
import SwiftData

struct SectionHeader: View {
    @EnvironmentObject private var sectionSettings: SectionSettings
    var sectionName: String?
    
    var body: some View {
        GeometryReader { proxy in
            ZStack {
                Rectangle()
                    .frame(height: proxy.size.height*100)
                    .foregroundStyle(.duskBlue)
                    .padding(.top, -(proxy.size.height*87))
                LazyHStack {
                    Spacer()
                    ScrollView(.horizontal){
                        Text(sectionName ?? sectionSettings.view)
                            .font(.custom("Microsoft Sans Serif", size: proxy.size.height*4))
                            .lineLimit(1)
                            .minimumScaleFactor(0.25)
                    }
                    Spacer()
                }
                .padding(.top, proxy.size.height*5)
            }
            .frame(maxWidth: .infinity)
        }
    }
}

struct SectionHeader_Previews: PreviewProvider {
    static var previews: some View {
        SectionHeader()
    }
}
