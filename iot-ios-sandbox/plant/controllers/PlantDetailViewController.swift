//
//  PlantDetailViewController.swift
//  iot-ios-sandbox
//
//  Created by ITLABS WEG on 10/05/19.
//  Copyright © 2019 WEG. All rights reserved.
//

import UIKit

class PlantDetailViewController: UIViewController {

    @IBOutlet weak var idLabel: UILabel?
    @IBOutlet weak var plantTypeLabel: UILabel!

    var plant: Plant?

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.idLabel?.backgroundColor = UIColor.yellow
        PlantsAPI().getPlantById(id: (plant?.id)!) { response in
            self.idLabel?.text = response.id
            self.plantTypeLabel?.text = response.plantType
        }
    }

}
