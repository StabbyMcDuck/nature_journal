//
//  AddViewController.swift
//  nature_journal
//
//  Created by Regina Imhoff on 9/16/17.
//  Copyright © 2017 Regina Imhoff. All rights reserved.
//

import UIKit
import AVFoundation

class AddViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var itemImageView: UIImageView!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var locationButton: UIButton!
    
    var audioRecorder : AVAudioRecorder?
    var audioPlayer : AVAudioPlayer?
    var audioURL : URL?
    
    var imagePicker = UIImagePickerController()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Image Picker
        imagePicker.delegate = self
        
        // Audio Session
        let session = AVAudioSession.sharedInstance()
        try? session.setCategory(AVAudioSessionCategoryPlayAndRecord)
        try? session.overrideOutputAudioPort(.speaker)
        try? session.setActive(true)
        
        // URL to save audio
        if let baseDirectoryPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first {
            
            let pathComponents = [baseDirectoryPath, "itemAudio.m4a"]
            if let audioURL = NSURL.fileURL(withPathComponents: pathComponents) {
                // Settings
                self.audioURL = audioURL
                var audioSettings : [String:Any] = [:]
                audioSettings[AVFormatIDKey] = Int(kAudioFormatMPEG4AAC)
                audioSettings[AVSampleRateKey] = 44100.0
                audioSettings[AVNumberOfChannelsKey] = 2
                
                // Create audio recorder
                try? audioRecorder = AVAudioRecorder(url: audioURL, settings: audioSettings)
                audioRecorder?.prepareToRecord()
            }
        }
        
        playButton.isEnabled = false
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func photoTapped(_ sender: Any) {
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func cameraTapped(_ sender: Any) {
        imagePicker.sourceType = .camera
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let chosenImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            itemImageView.image = chosenImage
        }
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveTapped(_ sender: Any) {
        
        if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
            let item = Item(entity: Item.entity(), insertInto: context)
            
            item.title = titleTextField.text
            
            if let image = itemImageView.image {
                if let imageData = UIImagePNGRepresentation(image) {
                    item.image = imageData as NSData
                }
            }
            
            if let audioURL = self.audioURL {
                item.audioData = try? NSData(contentsOf: audioURL)
            }
        
            try? context.save()
            
            navigationController?.popViewController(animated: true)
            
            print("AAAAAHHHAHAHAHHAHAHAHHA\n")
            print(audioURL?.absoluteString as Any)
            
        }
    }
    
    @IBAction func recordTapped(_ sender: Any) {
        
        if let audioRecorder = self.audioRecorder{
            if audioRecorder.isRecording {
                audioRecorder.stop()
                recordButton.setImage(#imageLiteral(resourceName: "microphone"), for: .normal)
                
            } else {
                audioRecorder.record()
                recordButton.setImage(#imageLiteral(resourceName: "stop"), for: .normal)
            }
        }
        
        playButton.isEnabled = true
    }
    
    @IBAction func locationTapped(_ sender: Any) {
        
    }
    
    @IBAction func playTapped(_ sender: Any) {
        if let audioURL = self.audioURL {
            audioPlayer = try? AVAudioPlayer(contentsOf: audioURL)
            audioPlayer?.play()
        }
        
        
    }
    
    
    
    
}
