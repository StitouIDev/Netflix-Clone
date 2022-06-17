//
//  YoutubeResponse.swift
//  Netflix Clone
//
//  Created by HAMZA on 17/6/2022.
//

import Foundation


struct YoutubeResponse: Codable {
    let items: [YoutubeElement]
}


struct YoutubeElement: Codable {
    let id: idYoutubeElement
}

struct idYoutubeElement: Codable {
    let kind: String
    let videoId: String
}
