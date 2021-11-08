import UIKit

extension UIViewController {
    
    func alertAddAddress(title: String, placeholder: String, completionHandler: @escaping (String) -> Void) {
    
        let alertController = UIAlertController(title: title, message: "", preferredStyle: .alert)
        alertController.addTextField { (tf) in
            tf.placeholder = placeholder
        }
        
        let alertOk = UIAlertAction(title: "OK", style: .default) { (action) in
            let textTF = alertController.textFields?.first
            guard let text = textTF?.text else { return }
            completionHandler(text)
        }
        let alertCancel = UIAlertAction(title: "Cancel", style: .default) { (_) in}
        
        alertController.addAction(alertOk)
        alertController.addAction(alertCancel)
        
        present(alertController, animated: true, completion: nil)
    }
    
    func alertError(title: String, message: String) {
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let alertOk = UIAlertAction(title: "OK", style: .default)
        
        alertController.addAction(alertOk)
        
        present(alertController, animated: true, completion: nil)
    } 
}
