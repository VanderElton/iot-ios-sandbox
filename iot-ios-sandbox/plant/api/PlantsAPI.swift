
import Foundation
import Alamofire

class PlantsAPI {

    func getPlants(completion: @escaping(_ plants: Array<Plant>) -> Void) {

        Alamofire.request(APIRouter.getPlant).validate().responseJSON { response in
            switch response.result {
            case .success:
                if let value = response.result.value as? Dictionary<String, Any> {
                    guard let json = value["value"] as? Array<Dictionary<String, Any>> else {return}
                    let plants = PlantMapper().toArray(json)
                    completion(plants)
                }

            case .failure:

                MSALAuthentication.shared.verifyExpiredToken()
                print (response.error!)
            }

        }
    }

    func getPlantById(id: String, completation: @escaping(_ plant: Plant) -> Void) {

        Alamofire.request(APIRouter.getPlantById(id)).validate().responseJSON { reponse in
            switch reponse.result {
            case .success:
                if let resp = reponse.result.value as? Dictionary<String, Any> {
                    let plant = PlantMapper().toObject(resp)
                    completation(plant)
                }
            case .failure:
                MSALAuthentication.shared.verifyExpiredToken()
                print(reponse.error!)
            }
        }
    }
}
