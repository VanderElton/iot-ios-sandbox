
import UIKit

class AuthViewController: UIViewController {

    @IBOutlet weak var acessButton: UIButton!

    // MARK: Properties

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: Actions
    @IBAction func actionAcessButton(_ sender: UIButton) {

        MSALAuthentication.shared.signInAccount { (_, _, error) in
            if let error = error {
                print ("App error: \(error)")

                let alert = UIAlertController(title: "Erro", message: "Verifique a conexao", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
                self.present(alert, animated: true, completion: nil)

                return
            }
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            appDelegate.showMainViewController()
        }
    }
}
