import Quick
import Nimble

@testable import Bud

final class TransactionModelTests: QuickSpec {
    override func spec() {
        var model: Transactions!

        describe("TransactionModel") {
            context("When parsing json data") {
                beforeEach {
                    let data = DataTestHelper.transactionsJson
                    model = try! JSONDecoder().decode(Transactions.self, from: data)
                }
                it("should correctly decode the values") {
                    expect(model.data.first?.id).to(equal("13acb877dc4d8030c5dacbde33d3496a2ae3asdc000db4c793bda9c3228baca1a28"))
                    expect(model.data.first?.category).to(equal("General"))
                    expect(model.data.first?.description).to(equal("Forbidden planet"))
                    expect(model.data.first?.amount.value).to(equal(13))
                    expect(model.data.first?.amount.currencyISO.rawValue).to(equal("GBP"))
                    expect(model.data.first?.product.icon).to(equal("https://storage.googleapis.com/budcraftstorage/uploads/products/lloyds-bank/Llyods_Favicon-1_161201_091641.jpg"))
                }
            }
        }
    }
}
