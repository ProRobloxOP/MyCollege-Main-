//
//  SectionController.swift
//  MyCollege
//
//  Created by Tyson Yung on 11/30/25.
//

import SwiftUI
import SwiftData

struct SectionController: View {
    @EnvironmentObject private var sectionSettings: SectionSettings
    
    var body: some View {
        if (sectionSettings.view == "Home"){
            HomeView()
                .environmentObject(sectionSettings)
        }
        if (sectionSettings.view == "Search"){
            SearchView()
                .environmentObject(sectionSettings)
        }
        if (sectionSettings.view == "Profile"){
            ProfileView()
                .environmentObject(sectionSettings)
        }
        if (sectionSettings.view == "Post"){
            PostPage()
                .environmentObject(sectionSettings)
        }
    }
}

#Preview {
    SectionController()
}
