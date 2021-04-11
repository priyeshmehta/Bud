import UIKit

extension UIImageView {
    func getImage(from url: String) {
        guard let url = URL(string: url) else {
            return
        }
        URLSession.shared.dataTask( with: url, completionHandler: {
            (data, response, error) -> Void in
            DispatchQueue.main.async {
                if let data = data {
                    self.image = UIImage(data: data)
                }
            }
        }).resume()
    }

    func withCircularEdges() {
        self.layer.cornerRadius = (self.frame.width / 2)
        self.layer.borderColor = UIColor.gray.cgColor
        self.layer.borderWidth = 0.5
    }
}
