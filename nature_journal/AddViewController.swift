//
//  AddViewController.swift
//  nature_journal
//
//  Created by Regina Imhoff on 9/16/17.
//  Copyright © 2017 Regina Imhoff. All rights reserved.
//

import UIKit

class AddViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var itemImageView: UIImageView!
    @IBOutlet weak var titleTextField: UITextField!
    
    var imagePicker = UIImagePickerController()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePicker.delegate = self
        
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
            
            try? context.save()
            
            navigationController?.popViewController(animated: true)
        }
    }

    @IBAction func recordTapped(_ sender: Any) {
    }
    
    @IBAction func locationTapped(_ sender: Any) {
    }
}
