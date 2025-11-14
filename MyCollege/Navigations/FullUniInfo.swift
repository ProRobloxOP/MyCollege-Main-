//
//  FullUniInfo.swift
//  MyCollege
//
//  Created by Tyson Yung on 12/13/25.
//

import SwiftUI
import SwiftData

struct FullUniInfo: View {
    var uniInfo: UniInfo
    
    var body: some View {
        VStack(alignment: .center, spacing: 30) {
            ZStack {
                RoundedRectangle(cornerRadius: 15)
                    .stroke(.duskBlue, lineWidth: 5)
                    .frame(width: 300, height: 400)
                
                Image(uiImage: uniInfo.Image)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 300, height: 400)
                    .clipShape(RoundedRectangle(cornerRadius: 15))
            }
            .padding(.leading, 20)
            .padding(.trailing, 20)
            .padding(.top, 10)
            .padding(.bottom, 10)
            
            Text("Academic Score: \(Int(uniInfo.AcademicScore))")
                .font(.custom("Courier New", size: 35))
                .foregroundStyle(.green)
            Text("Social Score: \(Int(uniInfo.SocialScore))")
                .font(.custom("Courier New", size: 35))
                .foregroundStyle(.purple)
            Text("Description: \(uniInfo.Desc)")
                .font(.custom("Courier New", size: 20))
                .foregroundStyle(.duskBlue)
                .padding()
            
            Spacer()
        }
    }
}
