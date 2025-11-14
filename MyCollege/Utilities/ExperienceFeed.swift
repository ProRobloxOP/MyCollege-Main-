//
//  ExperienceFeed.swift
//  MyCollege
//
//  Created by Tyson Yung on 12/14/25.
//

import SwiftUI
import SwiftData
import Foundation

struct Post {
    var Title: String
    var Username: String
    var ImgData: Data?
    var Desc: String
    
    var id = UUID()
}

var GlobalFeed: [Post] = []

struct CommentMainComment: View {
    @Binding var viewingPost: Bool
    var post: Post
    
    var body: some View {
        ScrollView(.vertical){
            SectionHeader(sectionName: post.Title)
                .padding(.bottom, 80)
            VStack(spacing: 35) {
                HStack {
                    Text("User: \(post.Username)")
                        .font(.custom("Courier New", size: 30))
                        .foregroundStyle(.duskBlue)
                        .padding(.top, 80)
                    Spacer()
                }
                .padding(.leading)
                ZStack {
                    RoundedRectangle(cornerRadius: 25)
                        .stroke(.duskBlue, lineWidth: 7)
                        .fill(.white)
                        .frame(width: 350, height: 350)
                    if (post.ImgData != nil){
                        Image(uiImage: UIImage(data: post.ImgData!)!)
                            .resizable()
                            .renderingMode(.original)
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 350, height: 350)
                            .clipShape(RoundedRectangle(cornerRadius: 25))
                    }
                }
                HStack {
                    Text("Description: \(post.Desc)")
                        .font(.custom("Courier New", size: 30))
                        .foregroundStyle(.duskBlue)
                        .padding(.top, 80)
                    Spacer()
                }
                .padding(.leading)
                
                Divider()
                    .frame(maxWidth: .infinity)
                    .frame(height: 3)
                    .background(.steelBlue)
                    .padding(.top, 20)
                    .padding(.bottom, 20)
                
                Text("Comment Section")
                    .font(.custom("Courier New", size: 30))
                    .foregroundStyle(.duskBlue)
                    .padding(.top, 30)
            }
            
        }
    }
}

struct CommentSection: View {
    @Binding var viewingPost: Bool
    var post: Post
    
    var body: some View {
        GeometryReader { parent in
            ZStack {
                CommentMainComment(viewingPost: $viewingPost, post: post)
                
                VStack(spacing: 10) {
                    Button {
                        
                    } label: {
                        ZStack {
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(.blueState, lineWidth: 3)
                                .fill(.icyBlue)
                                .frame(width: 250, height: 50)
                            Text("Comment")
                                .font(.custom("Courier New", size: 20))
                                .foregroundStyle(.duskBlue)
                        }
                    }
                    
                    Button {
                        viewingPost.toggle()
                    } label: {
                        ZStack {
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(.duskBlue, lineWidth: 3)
                                .fill(.coolSky)
                                .frame(width: 250, height: 50)
                            Text("Close")
                                .font(.custom("Courier New", size: 20))
                                .foregroundStyle(.duskBlue)
                        }
                    }
                }
                .padding(.top, parent.size.height*4/5)
            }
        }
    }
}

struct CreatePostContent: View {
    @State var viewingPost = false
    let proxy: GeometryProxy
    let Post: Post
    
    var body: some View {
        VStack {
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .stroke(.duskBlue)
                    .frame(width: proxy.size.width*0.95, height: proxy.size.height * 0.4)
                if (Post.ImgData != nil){
                    Image(uiImage: UIImage(data: Post.ImgData!)!)
                        .resizable()
                        .renderingMode(.original)
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 300, height: 300)
                }
            }
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .stroke(.duskBlue)
                VStack(alignment: .leading, spacing: 10) {
                    HStack {
                        Text(Post.Title)
                            .font(.custom("Courier New", size: 17))
                            .foregroundStyle(.duskBlue)
                        Spacer()
                    }
                    HStack {
                        Text(Post.Username)
                            .font(.custom("Courier New", size: 17))
                            .foregroundStyle(.duskBlue)
                        Spacer()
                    }
                    HStack {
                        Text(Post.Desc)
                            .font(.custom("Courier New", size: 15))
                            .foregroundStyle(.duskBlue)
                        Spacer()
                        Button {
                            viewingPost.toggle()
                        } label: {
                            ZStack {
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(.duskBlue, lineWidth: 3)
                                    .fill(.icyBlue)
                                    .frame(width: 100, height: 30)
                                Text("View Post`")
                                    .font(.custom("Courier New", size: 12))
                                    .foregroundStyle(.duskBlue)
                            }
                            .padding(.bottom, -5)
                        }
                        .fullScreenCover(isPresented: $viewingPost){
                            CommentSection(viewingPost: $viewingPost, post: Post)
                                .background(.white)
                                .ignoresSafeArea()
                        }
                    }
                }
                .padding()
            }
            .frame(width: proxy.size.width*0.95, height: proxy.size.height * 0.15)
        }
    }
}

struct ExpierenceFeed: View {
    let proxy: GeometryProxy
    
    var body: some View {
        VStack(spacing: 25) {
            if (GlobalFeed.count > 0){
                LazyVStack(spacing: 25){
                    ForEach(0...GlobalFeed.count - 1, id:\.self){ i in
                        CreatePostContent(proxy: proxy, Post: GlobalFeed[i])
                    }
                }
            } else {
                Spacer()
                Text("No Post Have Been Submitted Globally!")
                    .font(.custom("Courier New", size: 30))
                    .foregroundStyle(.duskBlue)
            }
        }
    }
}
