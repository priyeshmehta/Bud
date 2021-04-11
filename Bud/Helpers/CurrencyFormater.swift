import Foundation

struct CurrencyFormater {
    private let transaction: Transaction

    init(for transaction: Transaction) {
        self.transaction = transaction
    }

    var transactionAmountWithLocale: String {
        let currencyFormatter = NumberFormatter()
        currencyFormatter.numberStyle = .currency

        let value = transaction.amount.value as NSNumber

        switch transaction.amount.currencyISO {
        case .gbp:
            currencyFormatter.locale = Locale(identifier: "en_GB")
        }

        return currencyFormatter.string(from: value) ?? String.empty
    }
}
