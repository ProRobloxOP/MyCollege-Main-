//
//  MyCollegeApp.swift
//  MyCollege
//
//  Created by Tyson Yung on 11/13/25.
//

import SwiftUI
import SwiftData

@main
struct MyCollegeApp: App {
    @StateObject var sectionSettings = SectionSettings()
    
    var body: some Scene {
        WindowGroup {
            SectionController()
                .padding(.bottom, 20)
                .environmentObject(sectionSettings)
                .background(.white)
                .ignoresSafeArea()
        }
    }
}
