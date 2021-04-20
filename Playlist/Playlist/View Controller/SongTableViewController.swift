//
//  SongTableViewController.swift
//  Playlist
//
//  Created by Cameron Stuart on 12/15/20.
//

import UIKit

class SongTableViewController: UITableViewController {
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
    }

    //MARK: - Properties
    var playlist: Playlist?
    
    //MARK: - Actions
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return playlist?.songs.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "songCell", for: indexPath)

        guard let playlist = playlist else { return cell }
        
        let song = playlist.songs[indexPath.row]

        cell.textLabel?.text = song.songTitle
        cell.detailTextLabel?.text = song.artist

        return cell
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            guard let playlist = playlist else { return }
            let songToDelte = playlist.songs[indexPath.row]
            SongController.deleteSong(song: songToDelte, playlist: playlist)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let playlist = self.playlist
        guard let destinationVC = segue.destination as? SongDetailViewController else {return}
        destinationVC.playlist = playlist
        
        if segue.identifier == "toSongDetailVC" {
            
            guard let indexPath = tableView.indexPathForSelectedRow,
            
                  let song = playlist?.songs[indexPath.row] else {return}
            
            destinationVC.song = song
        }
    }
}//End of class
