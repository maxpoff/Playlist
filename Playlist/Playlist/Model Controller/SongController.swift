//
//  SongController.swift
//  Playlist
//
//  Created by Cameron Stuart on 12/15/20.
//

import Foundation

class SongController {

    static func createSong(title: String, artist: String, playlist: Playlist) {
        let newSong = Song(title: title, artist: artist)
        playlist.songs.append(newSong)
        print("Successfully added \(title) to \(playlist.name).")
        PlaylistController.shared.saveToPersistenceStore()
    }
    
    static func deleteSong(song: Song, playlist: Playlist) {
        guard let index = playlist.songs.firstIndex(of: song) else { return }
        playlist.songs.remove(at: index)
        print("Successfully deleted \(song.songTitle) from \(playlist.name).")
        PlaylistController.shared.saveToPersistenceStore()
    }
    
    static func updateSong(song: Song, newSongTitle: String, newArtist: String) {
        
        song.songTitle = newSongTitle
        song.artist = newArtist
        
        PlaylistController.shared.saveToPersistenceStore()
    }
}//End of class
