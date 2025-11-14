//
//  Navigation_Bar.swift
//  MyCollege
//
//  Created by Tyson Yung on 11/29/25.
//

import SwiftUI
import SwiftData
import Combine

class SectionSettings: ObservableObject {
     @Published var view: String = "Home"
}

struct SectionButton: View {
    @EnvironmentObject var sectionSettings: SectionSettings
    let sectionName : String
    let imageName: String
    var systemImg: Bool = false
    
    var body: some View {
        Button {
            sectionSettings.view = sectionName
        } label: {
            VStack(spacing: 6) {
                let img: Image = (systemImg) ? Image(systemName: imageName) : Image(imageName)
                img.resizable()
                    .renderingMode(.template)
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 37, height: 37)
                    .foregroundStyle((sectionName == sectionSettings.view) ? .coolSky : .white)
                
                Text(sectionName)
                    .foregroundStyle((sectionName == sectionSettings.view) ? .coolSky : .white)
                    .font(.custom("Microsoft Sans Serif", fixedSize: 13))
            }
        }
        .controlSize(.regular)
    }
}

struct Navigation_Bar: View {
    @EnvironmentObject var sectionSettings : SectionSettings
    
    var body: some View {
        ZStack {
            Rectangle()
                .frame(maxWidth: .infinity, maxHeight: 100)
                .foregroundStyle(.primary.opacity(0))
                .background(.duskBlue)
            HStack(spacing: 58) {
                SectionButton(sectionName: "Home", imageName: "house.fill", systemImg: true)
                    .environmentObject(sectionSettings)
                SectionButton(sectionName: "Search", imageName: "magnifyingglass", systemImg: true)
                    .environmentObject(sectionSettings)
                SectionButton(sectionName: "Post", imageName: "Post")
                    .environmentObject(sectionSettings)
                SectionButton(sectionName: "Profile", imageName: "person.crop.circle.fill", systemImg: true)
                    .environmentObject(sectionSettings)
            }
            .padding(.top, -25)
        }
        .padding(.bottom, -40)
    }
}

struct Navigation_Bar_Previews: PreviewProvider {
    static var previews: some View {
        Navigation_Bar()
    }
}
