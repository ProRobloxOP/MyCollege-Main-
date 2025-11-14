//
//  HomeView.swift
//  MyCollege
//
//  Created by Tyson Yung on 11/13/25.
//

import SwiftUI
import SwiftData
import PhotosUI

struct MainPostContent: View {
    @EnvironmentObject private var sectionSettings: SectionSettings
    @State private var PostTitle = ""
    @State private var PostDesc = "Description:\n\n\n\n\n"
    @State private var PostPickerImg: PhotosPickerItem?
    @State private var PostImg: UIImage?
    
    @FocusState private var TitleFocus
    @FocusState private var DescFocus
    
    private var defaultPostTitle = "Post Title"
    private var defaultPostDesc = "Description:\n\n\n\n\n"
    
    @Binding var EarnedPoints: Double
    
    init(EarnedPoints: Binding<Double>){
        self._EarnedPoints = EarnedPoints
    }
    
    var body: some View {
        ScrollView(.vertical){
            SectionHeader()
                .environmentObject(sectionSettings)
                .padding(.bottom, 80)
            
            VStack(alignment: .leading) {
                ZStack {
                    RoundedRectangle(cornerRadius: 3)
                        .stroke(.duskBlue, lineWidth: 3)
                        .fill(.white)
                    HStack {
                        TextField("PostTile", text: $PostTitle,
                                  prompt: Text(defaultPostTitle).foregroundStyle(.duskBlue).font(.custom("Courier New", size: 25))
                        )
                            .foregroundStyle(.duskBlue)
                            .font(.custom("Courier New", size: 25))
                            .focused($TitleFocus)
                        Spacer()
                    }
                    .padding(.leading, 5)
                }
                
                Text("User: \(Username)")
                    .font(.custom("Courier New", size: 25))
                    .foregroundStyle(.duskBlue)
            }
            .padding(.top, 50)
            .padding()
            
            VStack{
                PhotosPicker(selection: $PostPickerImg, matching: .images, photoLibrary: .shared()){
                    ZStack {
                        RoundedRectangle(cornerRadius: 25)
                            .stroke(.duskBlue, lineWidth: 7)
                            .frame(width: 350, height: 350)
                        if (PostImg != nil){
                            Image(uiImage: PostImg!)
                                .resizable()
                                .renderingMode(.original)
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 325, height: 325)
                        } else {
                            Image(systemName: "dot.crosshair")
                                .resizable()
                                .renderingMode(.original)
                                .foregroundStyle(.duskBlue)
                                .frame(width: 200, height: 200)
                        }
                    }
                }
                .onChange(of: PostPickerImg){
                    Task {
                        if let data = try await PostPickerImg?.loadTransferable(type: Data.self) {
                            PostImg = UIImage(data: data)
                        }
                    }
                }
            }
            
            VStack(alignment: .leading) {
                ZStack {
                    RoundedRectangle(cornerRadius: 3)
                        .stroke(.duskBlue, lineWidth: 3)
                        .fill(.white)
                    HStack {
                        TextField("PostDesc",
                                  text: $PostDesc,
                                  prompt: Text(defaultPostDesc).foregroundStyle(.duskBlue).font(.custom("Courier New", size: 25)),
                                  axis: .vertical
                        )
                            .foregroundStyle(.duskBlue)
                            .font(.custom("Courier New", size: 25))
                            .focused($DescFocus)
                        Spacer()
                    }
                    .padding(.leading, 5)
                }
                
            }
            .padding(.top, 30)
            .padding(.bottom, 100)
            .padding()
            
            Button {
                if (!PostTitle.isEmpty){
                    let newPost = Post(
                        Title: PostTitle,
                        Username: Username,
                        ImgData: PostImg?.pngData(),
                        Desc: PostDesc
                    )
                    
                    PostTitle = ""
                    PostDesc = defaultPostDesc
                    PostImg = nil
                    
                    GlobalFeed.append(newPost)
                    EarnedPoints = 1.0
                    
                    Gems += 1
                }
            } label: {
                ZStack {
                    RoundedRectangle(cornerRadius: 15)
                        .stroke(.duskBlue, lineWidth: 3)
                        .fill(.steelBlue)
                        .frame(width: 350, height: 50)
                    Text("Create Post")
                        .font(.custom("Courier New", size: 20))
                        .foregroundStyle(.duskBlue)
                }
            }
        }
        .onTapGesture {
            TitleFocus = false
            DescFocus = false
        }
    }
}

struct PostPage: View {
    @EnvironmentObject private var sectionSettings: SectionSettings
    @State private var EarnedPoints = 0.0
    
    var body: some View {
        ZStack {
            MainPostContent(EarnedPoints: $EarnedPoints)
                .environmentObject(sectionSettings)
            if (EarnedPoints != 0.0){
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(.duskBlue, lineWidth: 3)
                        .fill(.steelBlue)
                        .frame(width: 250, height: 40)
                    HStack(spacing: 30) {
                        Image(.diamond)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 40, height: 40)
                        Text("1")
                            .font(.custom("Courier New", size: 30))
                            .foregroundStyle(.duskBlue)
                    }
                }
                .opacity(EarnedPoints)
                .padding(.top, -300)
                .onAppear {
                    withAnimation(.easeInOut(duration: 2)) {
                        EarnedPoints = (EarnedPoints == 1.0) ? 0.0 : 1.0
                    }
                }
            }
        }
        
        Spacer()
        Navigation_Bar()
            .environmentObject(sectionSettings)
    }
}

