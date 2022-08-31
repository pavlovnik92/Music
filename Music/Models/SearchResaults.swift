//
//  SearchResaults.swift
//  Music
//
//  Created by Alice Romanova on 10.06.2022.
//

import Foundation


struct SearchResaults: Decodable {
    
    var resultCount: Int
    var results: [SongParameters]
}

struct SongParameters: Decodable {
    
    var artistName: String?
    var trackName: String?
    var artworkUrl100: String?
}
