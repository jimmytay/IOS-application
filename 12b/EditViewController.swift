//
//  EditViewController.swift
//  12b
//
//  Created by Guest User on 21/08/2018.
//  Copyright © 2018 Guest User. All rights reserved.
//

import UIKit
import CoreData
class EditViewController: UIViewController {
    
    var appDelegate: AppDelegate!
    
    // NSManagedObjectContext
    var managedContext: NSManagedObjectContext!
  
    @IBOutlet weak var directorLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    
    @IBOutlet weak var rateSlider: UISlider!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var directorText: UITextField!
    @IBOutlet weak var titleText: UITextField!
    @IBOutlet weak var statusText: UITextField!
    @IBOutlet weak var rateSelectedLabel: UILabel!
    var selectedItem:  NSManagedObject!

    override func viewDidLoad()  {
        super.viewDidLoad()
        rateSlider.value = 1
        rateSelectedLabel.text = "1"
        rateSlider.minimumValue = 1
        rateSlider.maximumValue = 5
        
        if let theItem = selectedItem {
            titleText.text = (theItem.value(forKey: "title") as? String)
            directorText.text = (theItem.value(forKey: "director") as? String)
            rateSelectedLabel.text = (theItem.value(forKey: "rating") as? String)
            statusText.text = (theItem.value(forKey: "status") as? String)
            
        }
        
        
        guard let delegate = UIApplication.shared.delegate as? AppDelegate
            else {
                print("Status: Error in app")
                return
        }
        
        appDelegate = delegate
        
        managedContext = appDelegate.persistentContainer.viewContext
    }
   
    @IBAction func sliderChanged(_ sender: UISlider) {
        let currentRate = lroundf(sender.value)
        rateSelectedLabel.text = "\(currentRate)"
    }
    
    
    // prepare for unwind segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let selectedDate = datePicker.date
        let currentRate = rateSlider.value
        if let title = titleText.text{
            
            selectedItem.setValue(title, forKey:"title")
            selectedItem.setValue(directorText.text, forKey:"director")
            selectedItem.setValue(selectedDate, forKey:"releasedDate")
            selectedItem.setValue(currentRate, forKey:"rating")
            selectedItem.setValue(statusText.text, forKey:"status")
            print("Movie Added")
            
            do {
                try managedContext.save()
                print("Status: Data saved")
            } catch {
                print("Status: Could not save data")
            }
        
            
        } else {
            print("fail to edit")
        }
    
    }
}

