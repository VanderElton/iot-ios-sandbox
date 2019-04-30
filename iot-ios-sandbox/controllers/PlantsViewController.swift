//
//  PlantsViewController.swift
//  iot-ios-sandbox
//
//  Created by ITLABS WEG on 30/04/19.
//  Copyright © 2019 WEG. All rights reserved.
//

import UIKit

class PlantsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var plants: Array<Plants> = []
    var plantSelected: Plants?
    
    @IBOutlet var plantView: UITableView?
    
    override func viewWillAppear(_ animated: Bool) {
        PlantsAPI().getPlants() { (resp) in
            self.plants = resp
            self.plantView?.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return plants.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let plant = plants[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! PlantViewCell
        
        cell.nameLabel.text = plant.name
        cell.descriptionLabel.text = plant.description
        
        return cell
    }
    
    /*func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if let cell = plantView.cellForRow(at: indexPath){
            plantSelected = plants[indexPath.row]
            
            performSegue(withIdentifier: plantSpecified, sender: self)
        }
    }*/

}
