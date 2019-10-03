
import Foundation

class Plant {
    let name: String?
    let description: String?
    let id: String?
    let plantType: String?
    let devices: [Device]

    init(name: String, description: String, id: String, plantType: String, devices: [Device]) {
        self.name = name
        self.description = description
        self.id = id
        self.plantType = plantType
        self.devices = devices
    }
}
