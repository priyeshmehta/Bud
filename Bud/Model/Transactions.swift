import Foundation

struct Transactions: Decodable {
    let data: [Transaction]
}

struct Transaction: Decodable {
    let id: String
    let category: String
    let description: String
    let amount: Amount
    let product: Product
}

struct Amount: Decodable {
    let value: Double
    let currencyISO: Currency

    enum CodingKeys: String, CodingKey {
        case value
        case currencyISO = "currency_iso"
    }
}

struct Product: Decodable {
    let icon: String
}

enum Currency: String, Codable {
    case gbp = "GBP"
}
