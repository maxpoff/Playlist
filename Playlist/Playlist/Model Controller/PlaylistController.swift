//
//  PlaylistController.swift
//  Playlist
//
//  Created by Cameron Stuart on 12/15/20.
//

import Foundation

class PlaylistController {
    
    //MARK: - Properties
    static let shared = PlaylistController()
    var playlists: [Playlist] = []
    
    //MARK: - Functions
    func createPlaylist(name: String) {
        let newPlaylist = Playlist(name: name)
        playlists.append(newPlaylist)
        saveToPersistenceStore()
    }
    
    func deletePlaylist(playlist: Playlist) {
        guard let index = playlists.firstIndex(of: playlist) else { return }
        playlists.remove(at: index)
        saveToPersistenceStore()
    }
    
    //MARK: - Persistence
    func createPersistenceStore() -> URL {
        let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let fileURL = url[0].appendingPathComponent("Playlist.json")
        return fileURL
    }
    
    // Save
    func saveToPersistenceStore() {
        do {
            let data = try JSONEncoder().encode(playlists)
            try data.write(to: createPersistenceStore())
        } catch {
            print("Error encoding our playlists: \(error) -- \(error.localizedDescription)")
        }
    }
    
    // Load
    func loadFromPersistenceStore() {
        do {
            let data = try Data(contentsOf: createPersistenceStore())
            playlists = try JSONDecoder().decode([Playlist].self, from: data)
        } catch {
            print("Error decoding our data into playlists: \(error) -- \(error.localizedDescription)")
        }
    }
}//End of class
