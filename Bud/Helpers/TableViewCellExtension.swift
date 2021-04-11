import UIKit

extension UITableViewCell {
    func setupSelectedCell() {
        let cellSelectedBackgroundView = UIView()
        cellSelectedBackgroundView.backgroundColor = UIColor.red.withAlphaComponent(0.5)
        self.selectedBackgroundView = cellSelectedBackgroundView
    }
}
