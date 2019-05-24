//
//  MasterTableViewController.swift
//  12b
//
//  Created by Guest User on 15/08/2018.
//  Copyright © 2018 Guest User. All rights reserved.
//

import UIKit
import CoreData

class MasterTableViewController: UITableViewController {

    // AppDelegate object
    var appDelegate: AppDelegate!
    
    // NSManagedObjectContext
    var managedContext: NSManagedObjectContext!
    
    var Movies = [NSManagedObject!]()
    var newMovies : NSManagedObject!
    
    override func viewDidLoad() {
         super.viewDidLoad()
        navigationItem.leftBarButtonItem = editButtonItem
        guard let delegate = UIApplication.shared.delegate as? AppDelegate
            else {
                print("Status: Error in app")
                return
        }
        
        appDelegate = delegate
        
        managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest =
            NSFetchRequest<NSManagedObject>(entityName: "Movie")

        do{
            Movies = try managedContext.fetch(fetchRequest)
            
            if !Movies.isEmpty{
                print("Sucess")
            }else{
                print("error")
            }
        }catch {
            print("Status: Could not retrieve data")
        }


    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.tableView.reloadData()
        
    }
    
    @IBAction func returnFromAdd(segue: UIStoryboardSegue) {
        // For testing purpose
        print("Returning from Add")
        Movies.append(newMovies)
        let indexPath = IndexPath(row: Movies.count - 1, section: 0)
        
        tableView.insertRows(at: [indexPath], with: .automatic)
        
        
    }
  
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView,
                            numberOfRowsInSection section: Int) -> Int {
        return Movies.count
    }
    
    override func tableView(_ tableView: UITableView,
                            cellForRowAt indexPath: IndexPath)
        -> UITableViewCell {
            
            
            var cell: UITableViewCell!
            
            // the identifier name must be the same as the one set earlier
            cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell")
            
            if cell == nil {
                cell = UITableViewCell(style: UITableViewCellStyle.default,
                                       reuseIdentifier: "MovieCell")
            }
            
            cell!.textLabel!.text = Movies[indexPath.row].value(forKey: "title") as? String
            
            return cell!
    }
    
    override func tableView(_ tableView: UITableView,
                            commit editingStyle: UITableViewCellEditingStyle,
                            forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            
            // delete row from array
            Movies.remove(at: indexPath.row)
            
            // delete row from table view
            tableView.deleteRows(at: [indexPath as IndexPath], with: .fade)
        }
    }
    
    override func tableView(_ tableView: UITableView,
                            canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier {
            
            if identifier == "toDetail" {
        
        // get the index path of the row selected in the table
        if let indexPath = tableView.indexPathForSelectedRow {
            
            // get the view controller of the destination scene
            let detailVC = segue.destination as! DetailViewController
            
            // set the selectedFood property of the destination scene
            detailVC.selectedItem = Movies[indexPath.row]
        }
        else if identifier == "toAdd" {
            newMovies = nil
                }
            }
    }

    }

   

}
