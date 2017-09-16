//
//  ItemsTableViewController.swift
//  nature_journal
//
//  Created by Regina Imhoff on 9/16/17.
//  Copyright © 2017 Regina Imhoff. All rights reserved.
//

import UIKit

class ItemsTableViewController: UITableViewController {

    var items : [Item] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

 
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getItems()
    }

    func getItems() {
        if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
            if let coreDataContents = try? context.fetch(Item.fetchRequest()) as? [Item] {
                if let coreDataItems = coreDataContents {
                    items = coreDataItems
                    tableView.reloadData()
                }
            }
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return items.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        let item = items[indexPath.row]
    
        cell.textLabel?.text = item.title
        
        if let imageData = item.image {
            cell.imageView?.image = UIImage(data: imageData as Data)
        }
        
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */
}
