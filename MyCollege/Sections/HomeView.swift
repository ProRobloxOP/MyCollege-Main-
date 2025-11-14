//
//  HomeView.swift
//  MyCollege
//
//  Created by Tyson Yung on 11/13/25.
//

import SwiftUI
import SwiftData

struct WelcomeMsg: View {
    var body: some View {
        LazyVStack {
            HStack {
                Text("Welcome")
                    .font(.custom("Courier New", size: 50))
                    .scaledToFit()
                    .foregroundStyle(.duskBlue)
                Spacer()
            }
            HStack {
                Text("\(Username)")
                    .font(.custom("Courier New", size: 30))
                    .scaledToFit()
                    .foregroundStyle(.duskBlue)
                Spacer()
            }
        }
        .padding()
    }
}

struct GemButton: View {
    var body: some View {
        GeometryReader { proxy in
            Button {
                
            } label: {
                HStack {
                    Text("Use Points Here ->")
                        .foregroundStyle(.coolSky)
                        .font(.custom("Courier New", size: 15))
                        .padding(.leading, 20)
                    
                    Spacer()
                    
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(.duskBlue, lineWidth: 4)
                        HStack {
                            Image(.diamond)
                                .resizable()
                                .renderingMode(.original)
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 40, height: 40)
                            
                            Text("\(Gems)")
                                .foregroundStyle(.duskBlue)
                                .font(.custom("Courier New", size: 25))
                        }
                    }
                    .frame(width: proxy.size.width/3)
                    .padding(.trailing, 20)
                }
            }
        }
    }
}

struct HomeView: View {
    @EnvironmentObject private var sectionSettings: SectionSettings
    @State private var discoverText: String = ""
    
    var body: some View {
        GeometryReader { proxy in
            ScrollView(.vertical){
                SectionHeader()
                    .environmentObject(sectionSettings)
                WelcomeMsg()
                    .padding(.top, proxy.size.height*0.15)
                    .padding(.bottom, -10)
                GemButton()
                    .padding(.bottom, 40)
                
                Search_Bar(exploreText: $discoverText)
                
                Divider()
                    .frame(width: proxy.size.width, height: 3)
                    .background(.steelBlue)
                    .padding(.top, 20)
                    .padding(.bottom, 20)
                
                ExpierenceFeed(proxy: proxy)
            }
        }
        
        Spacer()
        Navigation_Bar()
            .environmentObject(sectionSettings)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
