//
//  ViewController.swift
//  Player
//
//  Created by Loveth Nwakwudo on 11/29/21.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var table : UITableView!
    var songs = [Song]()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        table.delegate = self
        table.dataSource = self
        configureSongs()
    }
    func configureSongs(){
        songs.append(Song ( name:"B",
                           album :"123 somethong",
                           artistname: "cold Play",
                           trackName: "song3",
                           imageName: "heers"
                            ))
        
        songs.append(Song ( name:"A",
                            album :"123 something",
                            artistname: "cool Play",
                           trackName: "song4",
                            imageName: "pink"))
                        
    }
        
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return songs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "celll", for: indexPath)
        let song = songs[indexPath.row]
        cell.textLabel?.text = song.name
        cell.imageView?.image = UIImage(named: song.imageName)
        
       // cell.detailTextLabel?.text = song.album
        cell.accessoryType = .disclosureIndicator
        cell.textLabel?.font = UIFont(name: "Helvetica-Bold", size: 18)
     //   cell.detailTextLabel?.font = UIFont(name: "Helvetica", size: 18)
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        table.deselectRow(at: indexPath, animated: true)
        let position = indexPath.row
        guard let vc = storyboard?.instantiateViewController(identifier: "play") as? MusicViewController else {
            return
         
        }
        vc.songs = songs
        vc.position = position
        present(vc, animated: true)
       
        }
   
    
    }


struct Song {
    let name : String
    let album: String
    let artistname: String
    let trackName:String
    let imageName :String
    
}

