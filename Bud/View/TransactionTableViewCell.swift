import UIKit

final class TransactionTableViewCell: UITableViewCell {

    @IBOutlet private weak var logoImageView: UIImageView!
    @IBOutlet private weak var transactionTitle: UILabel!
    @IBOutlet private weak var transactionDescription: UILabel!
    @IBOutlet private weak var transactionValue: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        self.setupSelectedCell()
    }

    override func draw(_ rect: CGRect) {
        logoImageView.withCircularEdges()
    }

    override func prepareForReuse() {
        logoImageView.image = nil
        transactionTitle.text = nil
        transactionDescription.text = nil
        transactionValue.text = nil
    }

    func configure(_ transaction: Transaction) {
        logoImageView.getImage(from: transaction.product.icon)
        transactionTitle.text = transaction.description
        transactionDescription.text = transaction.category
        transactionValue.text = CurrencyFormater(for: transaction).transactionAmountWithLocale
    }
}
