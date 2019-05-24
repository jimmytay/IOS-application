//
//  AddViewController.swift
//  12b
//
//  Created by Guest User on 21/08/2018.
//  Copyright © 2018 Guest User. All rights reserved.
//

import UIKit
import CoreData

class AddViewController: UIViewController {

    @IBOutlet weak var directorLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var rateSelectedLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var titleText: UITextField!
    @IBOutlet weak var statusText: UITextField!
    @IBOutlet weak var directorText: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var rateSlider: UISlider!
    
    
    
    var managedContext: NSManagedObjectContext!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        rateSlider.value = 1
        rateSelectedLabel.text = "1"
        rateSlider.minimumValue = 1
        rateSlider.maximumValue = 5
        
        guard let delegate = UIApplication.shared.delegate as?AppDelegate
            else{
                print("Error")
                return
        }
        var appDelegate: AppDelegate!
        appDelegate=delegate
        managedContext=appDelegate.persistentContainer.viewContext

    }
    
    
    @IBAction func sliderChanged(_ sender: UISlider) {
        let currentRate = lroundf(sender.value)
        rateSelectedLabel.text = "\(currentRate)"
    }
    
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let entity = NSEntityDescription.entity(forEntityName: "Movie", in: managedContext)!
        
        let Movies = NSManagedObject(entity:entity, insertInto:managedContext)
        let selectedDate = datePicker.date
    let currentRate = rateSlider.value
    
        if let title = titleText.text{
            
                        Movies.setValue(title, forKey:"title")
                        Movies.setValue(directorText.text, forKey:"director")
                        Movies.setValue(selectedDate, forKey:"releasedDate")
                        Movies.setValue(currentRate, forKey:"rating")
                        Movies.setValue(statusText.text, forKey:"status")
                        print("Movie Added")
    
            }
        
        
        do{
            try managedContext.save()
            print("Data Saved")
            let tableVC = segue.destination as! MasterTableViewController
            
            tableVC.newMovies = Movies
            
        }catch{
            print("Error editing data")
        }
    }
    
}


   


