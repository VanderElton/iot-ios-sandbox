//
//  PlantViewController.swift
//  iot-ios-sandbox
//
//  Created by ITLABS WEG on 06/05/19.
//  Copyright © 2019 WEG. All rights reserved.
//

import UIKit

class PlantViewController: UITableViewController {

    var plants: Array<Plant> = []
    
    @IBOutlet var plantView: UITableView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        PlantsAPI().getPlants() { (resp) in
            self.plants = resp
            self.plantView?.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return plants.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let plant = plants[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! PlantViewCell
        
        cell.nameLabel.text = plant.name
        cell.descriptionLabel.text = plant.description
        
        return cell
    }
    
    @IBAction func LogoutAction(_ sender: Any) {
        do {
            try MSALAuthentication.shared.signOut()
        } catch let error {
            print ("Sign out error:\(error)")
        }
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.showLoginViewController()
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
    
    /*func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
     if let cell = plantView.cellForRow(at: indexPath){
     plantSelected = plants[indexPath.row]
     
     performSegue(withIdentifier: plantSpecified, sender: self)
     }
     }*/
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
