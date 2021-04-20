//
//  PlaylistsViewController.swift
//  Playlist
//
//  Created by Cameron Stuart on 12/15/20.
//

import UIKit

class PlaylistsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    //MARK: - Outlets
    @IBOutlet weak var playlistTableView: UITableView!
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        playlistTableView.delegate = self
        playlistTableView.dataSource = self
        PlaylistController.shared.loadFromPersistenceStore()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        playlistTableView.reloadData()
    }
    
    //MARK: - Actions
    @IBAction func addPlaylistButtonTapped(_ sender: Any) {
        presentNewPlaylistAlert()
    }
    
    // MARK: - TableView DataSource Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return PlaylistController.shared.playlists.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = playlistTableView.dequeueReusableCell(withIdentifier: "playlistCell", for: indexPath)
        
        let playlist = PlaylistController.shared.playlists[indexPath.row]
        
        cell.textLabel?.text = playlist.name
        
        if playlist.songs.count == 1 {
            cell.detailTextLabel?.text = "1 Song"
        } else {
            cell.detailTextLabel?.text = "\(playlist.songs.count) Songs"
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let playlistToDelete = PlaylistController.shared.playlists[indexPath.row]
            PlaylistController.shared.deletePlaylist(playlist: playlistToDelete)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    //MARK: - Functions
    func presentNewPlaylistAlert() {
        
        let playlistAlert = UIAlertController(title: "New Playlist", message: "Enter new plalist name", preferredStyle: .alert)
        
        playlistAlert.addTextField { (textField) in
            textField.placeholder = "playlist name here..."
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: nil)
        
        let addAction = UIAlertAction(title: "Add", style: .default) { (_) in
            
            guard let playlistName = playlistAlert.textFields![0].text, !playlistName.isEmpty else {return}
            
            PlaylistController.shared.createPlaylist(name: playlistName)
            self.playlistTableView.reloadData()
        }
        
        playlistAlert.addAction(cancelAction)
        playlistAlert.addAction(addAction)
        
        present(playlistAlert, animated: true)
    }

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toSongListVC" {
            guard let indexPath = playlistTableView.indexPathForSelectedRow,
                  let destination = segue.destination as? SongTableViewController else { return }
            let playlist = PlaylistController.shared.playlists[indexPath.row]
            destination.playlist = playlist        }
    }
}//End of class
