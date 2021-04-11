import Foundation

@testable import Bud

final class DataTestHelper {
    static let transactionsJson = """
    {
        "data": [{
                "id": "13acb877dc4d8030c5dacbde33d3496a2ae3asdc000db4c793bda9c3228baca1a28",
                "date": "2018-03-19",
                "description": "Forbidden planet",
                "category": "General",
                "currency": "GBP",
                "amount": {
                    "value": 13,
                    "currency_iso": "GBP"
                },
                "product": {
                    "id": 4279,
                    "title": "Lloyds Bank",
                    "icon": "https://storage.googleapis.com/budcraftstorage/uploads/products/lloyds-bank/Llyods_Favicon-1_161201_091641.jpg"
                }
            },
            {
                "id": "13acb877dc4d8030c5dacasdbde33d3496a2ae3c000db4c793bda9c3228baca1a28",
                "date": "2018-03-19",
                "description": "Yamaha music london",
                "category": "General",
                "currency": "GBP",
                "amount": {
                    "value": 14.99,
                    "currency_iso": "GBP"
                },
                "product": {
                    "id": 4279,
                    "title": "Lloyds Bank",
                    "icon": "https://storage.googleapis.com/budcraftstorage/uploads/products/lloyds-bank/Llyods_Favicon-1_161201_091641.jpg"
                }
            },
            {
                "id": "13acb877dc4d8030c5dacbde33d3496a2ae3c000db4c793bda9sdasc3228baca1a28",
                "date": "2018-03-18",
                "description": "Blizzard entertainment",
                "category": "General",
                "currency": "GBP",
                "amount": {
                    "value": 11.38,
                    "currency_iso": "GBP"
                },
                "product": {
                    "id": 4279,
                    "title": "Lloyds Bank",
                    "icon": "https://storage.googleapis.com/budcraftstorage/uploads/products/lloyds-bank/Llyods_Favicon-1_161201_091641.jpg"
                }
            },
            {
                "id": "13acb877dc4d8030c5dacbdasde33d3496a2ae3c000db4c793bda9c3228baca1a28",
                "date": "2018-03-16",
                "description": "Thames water",
                "category": "Bills",
                "currency": "GBP",
                "amount": {
                    "value": 34.74,
                    "currency_iso": "GBP"
                },
                "product": {
                    "id": 4279,
                    "title": "Lloyds Bank",
                    "icon": "https://storage.googleapis.com/budcraftstorage/uploads/products/lloyds-bank/Llyods_Favicon-1_161201_091641.jpg"
                }
            },
            {
                "id": "13acb877dc4d8030c5dacbde33d3496a2ae3c000db4c793231bda9c3228baca1a28",
                "date": "2018-03-05",
                "description": "Vue bsl ltd",
                "category": "Entertainment",
                "currency": "GBP",
                "amount": {
                    "value": 9.98,
                    "currency_iso": "GBP"
                },
                "product": {
                    "id": 4279,
                    "title": "Lloyds Bank",
                    "icon": "https://storage.googleapis.com/budcraftstorage/uploads/products/lloyds-bank/Llyods_Favicon-1_161201_091641.jpg"
                }
            },
            {
                "id": "13acb877dc4d8030c5dacbde41235433d3496a2ae3c000db4c793bda9c3228baca1a28",
                "date": "2018-03-05",
                "description": "Five guys",
                "category": "Food / Drink",
                "currency": "GBP",
                "amount": {
                    "value": 32,
                    "currency_iso": "GBP"
                },
                "product": {
                    "id": 4279,
                    "title": "Lloyds Bank",
                    "icon": "https://storage.googleapis.com/budcraftstorage/uploads/products/lloyds-bank/Llyods_Favicon-1_161201_091641.jpg"
                }
            },
            {
                "id": "13acb877dc4d8030c5dacbde33d3496a2ae3c000db4c793bda9c3225548baca1a28",
                "date": "2018-03-01",
                "description": "Sainsburys's mkts",
                "category": "Groceries",
                "currency": "GBP",
                "amount": {
                    "value": 23.9,
                    "currency_iso": "GBP"
                },
                "product": {
                    "id": 4279,
                    "title": "Lloyds Bank",
                    "icon": "https://storage.googleapis.com/budcraftstorage/uploads/products/lloyds-bank/Llyods_Favicon-1_161201_091641.jpg"
                }
            },
            {
                "id": "13acb877dc4d8030c5dac1223bde33d3496a2ae3c000db4c793bda9c3228baca1a28",
                "date": "2018-03-01",
                "description": "Just eat",
                "category": "Food / Drink",
                "currency": "GBP",
                "amount": {
                    "value": 13,
                    "currency_iso": "GBP"
                },
                "product": {
                    "id": 4279,
                    "title": "Lloyds Bank",
                    "icon": "https://storage.googleapis.com/budcraftstorage/uploads/products/lloyds-bank/Llyods_Favicon-1_161201_091641.jpg"
                }
            },
            {
                "id": "13acb877dc4d8030c5dacbde33d67643496a2ae3c000db4c793bda9c3228baca1a28",
                "date": "2018-03-01",
                "description": "Co-op energy",
                "category": "Bills",
                "currency": "GBP",
                "amount": {
                    "value": 79,
                    "currency_iso": "GBP"
                },
                "product": {
                    "id": 4279,
                    "title": "Lloyds Bank",
                    "icon": "https://storage.googleapis.com/budcraftstorage/uploads/products/lloyds-bank/Llyods_Favicon-1_161201_091641.jpg"
                }
            },
            {
                "id": "13acb877dc4d8030c5dacbdewfdge33d3496a2ae3c000db4c793bda9c3228baca1a28",
                "date": "2018-03-01",
                "description": "Dumplings legend",
                "category": "Food / Drink",
                "currency": "GBP",
                "amount": {
                    "value": 77.3,
                    "currency_iso": "GBP"
                },
                "product": {
                    "id": 4279,
                    "title": "Lloyds Bank",
                    "icon": "https://storage.googleapis.com/budcraftstorage/uploads/products/lloyds-bank/Llyods_Favicon-1_161201_091641.jpg"
                }
            }

        ]
    }
    """.data(using: .utf8)!

    static var transactions: Transactions {
        let json = try! JSONDecoder().decode(Transactions.self, from: transactionsJson)
        return json
    }

    static let invalidJson = """
    {}
    """.data(using: .utf8)!

    static func mockTransaction(id: String) -> Transaction {
        Transaction(id: id,
                    category: "Bills",
                    description: "Five Guys",
                    amount: .init(value: 10,
                                  currencyISO: .gbp),
                    product: .init(icon: "icon"))
    }
}
