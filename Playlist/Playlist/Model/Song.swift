//
//  Song.swift
//  Playlist
//
//  Created by Cameron Stuart on 12/15/20.
//

import Foundation

class Song: Codable {
    
    var songTitle: String
    var artist: String
    
    init(title: String, artist: String) {
        self.songTitle = title
        self.artist = artist
    }
}//End of class

//MARK: - Extension
extension Song: Equatable {
    static func == (lhs: Song, rhs: Song) -> Bool {
        return rhs.songTitle == lhs.songTitle && rhs.artist == lhs.artist
    }
}//End of extension
