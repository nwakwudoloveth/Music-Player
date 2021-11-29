//
//  MusicViewController.swift
//  Player
//
//  Created by Loveth Nwakwudo on 11/29/21.
//

import UIKit
import AVFoundation

class MusicViewController: UIViewController {

    let playPausebutton = UIButton()
    let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
    let image = UIImage(systemName: "pause.fill")
    
    public var position:Int = 0
    public var songs: [Song] = []
    @IBOutlet var holder : UIView!
    
    var audioplayer : AVAudioPlayer?
    //userInterface Element
     let albumImageView = UIImageView()
       // let imageView = UIImageView()
     //  imageView.contentMode = .scaleAspectFill
     //   imageView.layer.cornerRadius = imageView.bounds.size.height/2
     //   return imageView
       
        
    
   
    private let songNameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
        
    }()
    private let albumNameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
        
    }()
    private let artistNameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
        
    }()

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       // holder.layer.contents = UIImage(named: "holder")
        
        
        backgroundImage.image = UIImage(named: "holder")
        backgroundImage.contentMode = UIView.ContentMode.scaleAspectFill
       
        
         //  hol.view.backgroundColor = UIColor(patternImage: UIImage(named: "background.png"))
            
      

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
      //  albumImageView.layer.cornerRadius = albumImageView.frame.height/2
      //  albumImageView.clipsToBounds = true
        if holder.subviews.count == 0
    
        
        
        { configure()
            
        }
    }
    // MARK: - Table view data source
    
    func configure() {
        //setup player
        let song = songs[position]
        let urlString = Bundle.main.path( forResource:song.name , ofType: "wav")
        do
        { try AVAudioSession.sharedInstance().setMode(.default)
            try AVAudioSession.sharedInstance().setActive(true, options: .notifyOthersOnDeactivation)

            guard let url = urlString else {
                print("url is nil")
                return
            }
            
        audioplayer = try! AVAudioPlayer(contentsOf: URL(string: url)!)
            
            guard let player = audioplayer else {
                
                print("player is nil")
                return
            }
            player.volume = 0.5
         //   player.prepareToPlay()
            player.play()
            rotateImage()
        }
         catch {
            print ("error occured")
    
}
        
      //set up UIelement
        albumImageView.frame = CGRect(x: 100, y: 250, width: holder.frame.size.width-200, height: holder.frame.size.width-200)
        albumImageView.layer.cornerRadius =  albumImageView.frame.height/2.0
        albumImageView.clipsToBounds = true
        albumImageView.image = UIImage(named: song.imageName)
      
        
        holder.addSubview(backgroundImage)
        holder.addSubview(albumImageView)
    
        //labels: song name, album, artist
        
      //  songNameLabel.frame = CGRect(x: 10, y: albumImageView.frame.size.height + 10 + 70 + 140, width: holder.frame.size.width-20, height: 70)
        
        albumNameLabel.frame = CGRect(x: 10, y: albumImageView.frame.size.height + 10 + 70 + 70 + 140, width: holder.frame.size.width-20, height: 70)
        
        artistNameLabel.frame = CGRect(x: 10, y: albumImageView.frame.size.height + 10 + 140 + 200, width: holder.frame.size.width-20, height: 70)
        
    //    songNameLabel.text = song.name
        albumNameLabel.text = song.album
        artistNameLabel.text = song.artistname
        
        
        
    //    holder.addSubview(songNameLabel)
        holder.addSubview(albumNameLabel)
        holder.addSubview(artistNameLabel)
        
        
        //player control
        
       
        let nextButton = UIButton()
        let backButton = UIButton()
        
        //Frame
        
        let yposition = artistNameLabel.frame.origin.y + 70  + 20
        let size : CGFloat = 45
        playPausebutton.frame = CGRect(x: (holder.frame.size.width - 75) / 2.0, y: yposition - 10, width: 80, height: 80)
            
        playPausebutton.backgroundColor = .systemPink

       
     
        playPausebutton.layer.cornerRadius = playPausebutton.bounds.size.width/2.0
      
           // view.layer.cornerRadius = view.bounds.size.width / 2.0
               // playPausebutton.clipsToBounds = true
        nextButton.frame = CGRect(x: (holder.frame.size.width - size - 20), y: yposition, width: size, height: size)
        
        
        backButton.frame = CGRect(x: 20, y: yposition, width: size, height: size)
        
        //add actions
        playPausebutton.addTarget(self, action:#selector(didTapPlayButton), for: .touchUpInside)
        
        
        nextButton.addTarget(self, action:#selector(didTapNextButton), for: .touchUpInside)
        
        backButton.addTarget(self, action:#selector(didTapBackButton), for: .touchUpInside)
        
        
       // images
        
        playPausebutton.setImage(image, for: .normal)
        
        playPausebutton.contentHorizontalAlignment = .fill
        playPausebutton.contentVerticalAlignment = . fill
        playPausebutton.imageEdgeInsets = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
    //    playPausebutton.setBackgroundImage(UIImage(systemName: "pause.fill"), for: .normal)
       
     nextButton.setBackgroundImage(UIImage(systemName: "forward.fill"), for: .normal)
    backButton.setBackgroundImage(UIImage(systemName: "backward.fill"), for: .normal)
       
        playPausebutton.tintColor = .white
        nextButton.tintColor = .white
        backButton.tintColor = .white
        
        holder.addSubview(playPausebutton)
        holder.addSubview(backButton)
        holder.addSubview(nextButton)
        //slider
        
        let slider = UISlider(frame: CGRect(x: 20, y: holder.frame.size.height-60, width: holder.frame.size.width-40, height: 50))
        
        slider.value = 0.5
        slider.addTarget(self, action:#selector(didSlideSLider(_:)), for: .valueChanged )
        holder.addSubview(slider)
        
        //actions
        
    }
    
    @objc func didTapBackButton(){
        if position > 0 {
            position = position - 1
            audioplayer?.stop()
            for subView in holder.subviews{ subView.removeFromSuperview()}
            
            configure()
        }
        
    }
    
    @objc func didTapNextButton(){
        if position < (songs.count-1) {
            position = position + 1
            audioplayer?.stop()
            for subView in holder.subviews{ subView.removeFromSuperview()}
            
            configure()
        
    }
    }
    
    
    func rotateImage() {
    let rotateAnimation = CABasicAnimation(keyPath: "transform.rotation")
    rotateAnimation.fromValue = 0.0
    rotateAnimation.toValue = CGFloat(.pi * 2.0)
    rotateAnimation.duration = 20.0  // Change this to change how many seconds a rotation takes
    rotateAnimation.repeatCount = Float.greatestFiniteMagnitude

        self.albumImageView.layer.add(rotateAnimation, forKey: "rotate")
    }
    
    @objc func didTapPlayButton(){
        
        if audioplayer?.isPlaying == true {
            rotateImage()
            audioplayer?.pause()
            playPausebutton.setImage(UIImage(systemName: "play.fill"), for: .normal)
            
            
            //shrink
            
//
//            UIView.animate(withDuration: 0.2, animations:{ self.albumImageView.frame = CGRect(x: 30, y: 30, width: self.holder.frame.size.width-60, height: self.holder.frame.size.width-60)
//
    //    };)
        }
        else {
            albumImageView.layer.removeAnimation(forKey: "rotate")
            audioplayer?.play()
            playPausebutton.setImage(UIImage(systemName: "pause.fill"), for: .normal)
            
            
            //increase size
//
//            UIView.animate(withDuration: 0.2, animations:{ self.albumImageView.frame = CGRect(x: 10, y: 10, width: self.holder.frame.size.width-20, height: self.holder.frame.size.width-20)
//
        }}
    //     )   }
  //  }
    @objc func didSlideSLider(_ slider: UISlider){
        let value = slider.value
       // audioplayer?.volume = value
    }
      
    override func   viewWillDisappear(_ animated: Bool){
        super.viewWillDisappear(animated)
        if let player = audioplayer {
            player.stop()
        
        }
       
        

//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 0
//    }
//
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        // #warning Incomplete implementation, return the number of rows
//        return 0
//    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
}
  

