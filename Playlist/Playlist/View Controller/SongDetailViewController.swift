//
//  SongDetailViewController.swift
//  Playlist
//
//  Created by Maxwell Poffenbarger on 4/20/21.
//

import UIKit

class SongDetailViewController: UIViewController {
    
    //MARK: - Outlets
    @IBOutlet weak var songTitleTextField: UITextField!
    @IBOutlet weak var artistTextField: UITextField!
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateViews()
    }
    
    //MARK: - Properties
    var playlist: Playlist?
    var song: Song?
    
    //MARK: - Actions
    @IBAction func saveButtonTapped(_ sender: Any) {
        
        guard let songTitle = songTitleTextField.text, !songTitle.isEmpty,
              let artist = artistTextField.text, !artist.isEmpty,
              let playlist = playlist else {return}
        
        if let song = song {
            
            SongController.updateSong(song: song, newSongTitle: songTitle, newArtist: artist)
            
        } else {
            SongController.createSong(title: songTitle, artist: artist, playlist: playlist)
        }
        
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func clearTextButtonTapped(_ sender: Any) {
        songTitleTextField.text = ""
        artistTextField.text = ""
    }
    
    //MARK: - Functions
    func updateViews() {
        guard let song = song else {return}
        songTitleTextField.text = song.songTitle
        artistTextField.text = song.artist
    }
}//End of class
