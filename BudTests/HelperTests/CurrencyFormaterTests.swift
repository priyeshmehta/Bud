import Quick
import Nimble

@testable import Bud

final class CurrencyFormaterTests: QuickSpec {

    override func spec() {
        var currencyFormater: CurrencyFormater!

        describe("CurrencyFormaterTests") {
            beforeEach {
                currencyFormater = .init(for: DataTestHelper.mockTransaction(id: "123"))
            }
            it("should return the formatted amount") {
                expect(currencyFormater.transactionAmountWithLocale).to(equal("£10.00"))
            }
        }
    }
}
