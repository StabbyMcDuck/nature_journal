//
//  ItemDetailViewController.swift
//  nature_journal
//
//  Created by Regina Imhoff on 9/17/17.
//  Copyright © 2017 Regina Imhoff. All rights reserved.
//

import UIKit
import AVFoundation

class ItemDetailViewController: UIViewController {
    
    var previousVC = ItemsTableViewController()
    var selectedItem = Item()

    @IBOutlet weak var itemImage: UIImageView!
    
    @IBOutlet weak var itemTitle: UILabel!
    
    @IBOutlet weak var itemAudio: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        itemImage.image = UIImage(data: (selectedItem.image as! NSData) as Data)
        itemTitle.text = selectedItem.title
        itemAudio.isEnabled = true
        
        /*
        if let image = selectedItem.image {
            if let imageData = UIImagePNGRepresentation(image) {
                item.image = imageData as NSData
                itemImage = item.image
            }
        }
        
        if let audioURL = self.audioURL {
            item.audioData = try? NSData(contentsOf: audioURL)
            try? context.save()
            
        }
         */
    }
    
    @IBAction func playTapped(_ sender: Any) {
        var audioPlayer : AVAudioPlayer?

        audioPlayer = try? AVAudioPlayer(data: selectedItem.audioData! as Data)

        audioPlayer?.prepareToPlay()
        audioPlayer?.play()
        
    }
    

}
