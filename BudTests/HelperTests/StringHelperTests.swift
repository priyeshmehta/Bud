import Quick
import Nimble

@testable import Bud

final class StringHelperTests: QuickSpec {
    override func spec() {
        describe("String Helper tests") {
            context("empty string") {
                var foo: String!
                beforeEach {
                    foo = String.empty
                }
                it("should have the correct value") {
                    expect(foo).to(equal(""))
                }
            }

            context("localized string") {
                var bar = ""
                beforeEach {
                    bar = "transactionViewControllerTitle".localized
                }
                it("should equal the correct string") {
                    expect(bar).to(equal("Transactions"))
                }
            }
        }
    }
}
