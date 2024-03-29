
import Foundation

class PlantMapper {

    func toObject(_ object: [String: Any]) -> Plant {
        let plant = Plant(name: object["name"] as? String ?? "", description: object["description"] as? String ?? "", id: object["id"] as? String ?? "", plantType: object["plantType"] as? String ?? "", devices: object["devices"] as? [Device] ?? [])

        return plant
    }

    func toArray(_ array: [[String: Any]]) -> Array<Plant> {
        var plants: [Plant] = []
        for plant in array {
            plants.append(self.toObject(plant))
        }

        return plants
    }

}
