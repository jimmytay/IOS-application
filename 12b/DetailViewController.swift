//
//  ViewController.swift
//  12b
//
//  Created by Guest User on 15/08/2018.
//  Copyright © 2018 Guest User. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class DetailViewController: UIViewController {

    @IBOutlet weak var directorLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!

    @IBOutlet weak var releasedDateLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    var selectedItem: NSManagedObject!
    let dateFormatter = DateFormatter()
    override func viewDidLoad() {
        super.viewDidLoad()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        // get the selected item (assigned before transition)
        if let theItem = selectedItem {
            
            let title = theItem.value(forKey: "title") as? String
            let director = theItem.value(forKey: "director") as? String
            let rate = theItem.value(forKey: "rating") as? Int
            let status = theItem.value(forKey: "status") as? String
            
            titleLabel.text = "Title: \(title!)"
            directorLabel.text = "Director: \(director!)"
            releasedDateLabel.text = "Date: \(dateFormatter.string(from: theItem.value(forKey:"releasedDate") as! Date))"
            ratingLabel.text = "Rate: \(rate!)"
            statusLabel.text = "Status: \(status!)"
            
            
        }
    }
    override func prepare(for segue: UIStoryboardSegue,
                          sender: Any?) {
        
        // get the view controller of the destination scene
        let editVC = segue.destination as! EditViewController
        
        // set selectedItem property of the destination scene
        editVC.selectedItem = selectedItem
    }
    
    @IBAction func returnFromEdit(segue: UIStoryboardSegue) {
        // For testing purpose
        print("Returning from Edit")
        
        let title = selectedItem.value(forKey: "title") as? String
        let director = selectedItem.value(forKey: "director") as? String
        let rate = selectedItem.value(forKey: "rating") as? Int
        let status = selectedItem.value(forKey: "status") as? String
        
        titleLabel.text = "Title: \(title!)"
        directorLabel.text = "Director: \(director!)"
        releasedDateLabel.text = "Date: \(dateFormatter.string(from: selectedItem.value(forKey:"releasedDate") as! Date))"
        ratingLabel.text = "Rate: \(rate!)"
        statusLabel.text = "Status: \(status!)"
        
    }

   


}

