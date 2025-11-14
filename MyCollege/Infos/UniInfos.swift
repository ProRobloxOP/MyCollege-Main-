//
//  UniInfos.swift
//  MyCollege
//
//  Created by Tyson Yung on 12/13/25.
//

import SwiftUI
import SwiftData

struct UniInfo: Hashable, Identifiable {
    let id = UUID()
    
    var Name: String
    var Image: UIImage
    var AcademicScore: CGFloat
    var SocialScore: CGFloat
    var Desc: String
}

let MaxUniScore: CGFloat = 20

var Leaderboard: [UniInfo] = [
    UniInfo(
        Name: "MIT",
        Image: UIImage.MIT_MAIN,
        AcademicScore: 10,
        SocialScore: 10,
        Desc: "Founded to accelerate the nation’s industrial revolution, MIT is profoundly American. With ingenuity and drive, our graduates have invented fundamental technologies, launched new industries, and created millions of American jobs. At the same time, and without the slightest sense of contradiction, MIT is profoundly global. Our community gains tremendous strength as a magnet for talent from around the world. Through teaching, research, and innovation, MIT’s exceptional community pursues its mission of service to the nation and the world."
    ),
    
    UniInfo(
        Name: "Penn State",
        Image: UIImage.pennStateMAIN,
        AcademicScore: 7,
        SocialScore: 10,
        Desc: ""
    ),
    
    UniInfo(
        Name: "Columbia",
        Image: UIImage.columbiaMAIN,
        AcademicScore: 9,
        SocialScore: 8,
        Desc: ""
    )
]
