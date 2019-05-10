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
    
    var plantSelected: Plant?
    
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

    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let cell = plantView.cellForRow(at: indexPath){
            
            plantSelected = plants[indexPath.row]
            performSegue(withIdentifier: "plantDetail", sender: self)
        }
     }
    
    
     // MARK: - Navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "plantDetail" {
            if let plantDetail = segue.destination as? PlantDetailViewController {
                plantDetail.plant = plantSelected
            }
        }
     }
 
    
}
