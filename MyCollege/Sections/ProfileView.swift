//
//  HomeView.swift
//  MyCollege
//
//  Created by Tyson Yung on 11/13/25.
//

import SwiftUI
import SwiftData

struct ProfileView: View {
    @EnvironmentObject private var sectionSettings: SectionSettings
    
    var body: some View {
        
        
        Spacer()
        Navigation_Bar()
            .environmentObject(sectionSettings)
    }
}

struct MyList_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}

