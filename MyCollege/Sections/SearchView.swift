//
//  HomeView.swift
//  MyCollege
//
//  Created by Tyson Yung on 11/13/25.
//

import SwiftUI
import SwiftData
import Combine

class ViewingUniObject: ObservableObject {
    @Published var uniView: UniInfo?
}

struct UniRankDetails: View {
    @State private var showFullUniDetails = false
    let rankBarHeight: CGFloat = 10
    let uniInfo: UniInfo
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            Text(uniInfo.Name)
                .foregroundStyle(.duskBlue)
                .font(.custom("Microsoft Sans Serif", size: 30))
            
            VStack(alignment: .leading, spacing: -rankBarHeight) {
                RoundedRectangle(cornerRadius: 10)
                    .foregroundStyle(.icyBlue)
                    .frame(width: 170, height: rankBarHeight)
                RoundedRectangle(cornerRadius: 10)
                    .foregroundStyle(.coolSky)
                    .frame(width: 170 * ((uniInfo.AcademicScore + uniInfo.SocialScore) / MaxUniScore), height: rankBarHeight)
            }
            
            Button {
                showFullUniDetails.toggle()
            } label: {
                ZStack {
                    RoundedRectangle(cornerRadius: 30)
                        .stroke(.duskBlue, lineWidth: 3)
                        .frame(width: 150, height: 35)
                    Text("More Info")
                        .font(.custom("Microsoft Sans Serif", size: 20))
                        .foregroundStyle(.duskBlue)
                }
            }
            .fullScreenCover(isPresented: $showFullUniDetails){
                ZStack {
                    Color.white.ignoresSafeArea()
                    ScrollView(.vertical){
                        SectionHeader(sectionName: uniInfo.Name)
                            .padding(.bottom, 40)
                            .padding(.leading, -100)
                            .padding(.trailing, -100)
                        
                        HStack {
                            VStack {
                                Button{
                                    showFullUniDetails.toggle()
                                } label: {
                                    ZStack {
                                        RoundedRectangle(cornerRadius: 500)
                                            .stroke(.icyBlue, lineWidth: 6)
                                            .background(.white)
                                            .frame(width: 35, height: 35)
                                            .clipShape(RoundedRectangle(cornerRadius: 500))
                                        Image(systemName: "xmark")
                                            .resizable()
                                            .renderingMode(.template)
                                            .foregroundStyle(.icyBlue)
                                            .frame(width: 15, height: 15)
                                    }
                                }
                                Spacer()
                            }
                            Spacer()
                        }
                        .padding()
                        
                        FullUniInfo(uniInfo: uniInfo)
                            .padding(.top, 50)
                    }
                }
            }
        }
    }
}

struct UniRankView: View {
    let uniInfo: UniInfo
    
    var body: some View {
        HStack(spacing: 10) {
            Image(uiImage: uniInfo.Image)
                .resizable()
                .renderingMode(.original)
                .scaledToFill()
                .frame(width: 160, height: 190)
                .clipShape(RoundedRectangle(cornerRadius: 20))
            Spacer()
            
            UniRankDetails(uniInfo: uniInfo)
        }
    }
}

struct SearchView: View {
    @EnvironmentObject private var sectionSettings: SectionSettings
    @State private var exploreText: String = ""
    
    var body: some View {
        ScrollView(.vertical){
            SectionHeader(sectionName: "Leaderboard")
                .environmentObject(sectionSettings)
                .padding(.bottom, 150)
            Search_Bar(exploreText: $exploreText, placementText: "Search Colleges")
                .padding(.bottom, 30)
            
            LazyVStack(alignment: .leading, spacing: 30) {
                ForEach(0...Leaderboard.count - 1, id: \.self){ index in
                    let uniInfo: UniInfo = Leaderboard[index]
                    if (uniInfo.Name.firstRange(of: exploreText) != nil){
                        UniRankView(uniInfo: uniInfo)
                    }
                }
            }
            .padding()
        }
        
        Spacer()
        Navigation_Bar()
            .environmentObject(sectionSettings)
    }
}

struct RankingView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}

