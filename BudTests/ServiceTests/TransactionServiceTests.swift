import Quick
import Nimble

@testable import Bud

final class TransactionServiceTests: QuickSpec {
    override func spec() {
        var service: TransactionService!
        var urlSessionMock: URLSessionMock!

        describe("TransactionService Tests") {
            context("When there is a valid response") {
                beforeEach {
                    urlSessionMock = .init(data: DataTestHelper.transactionsJson,
                                           mockURL: URLSessionMock.mockUrl,
                                           statusCode: 200)
                    service = .init(session: urlSessionMock)
                }
                it("should return a valid model") {
                    waitUntil { done in
                        service.getTransactions { response in
                            switch response {
                            case .success(let response):
                                expect(response).toNot(beNil())
                                expect(response).to(beAKindOf(Transactions.self))
                                expect(response.data).to(beAKindOf([Transaction].self))
                                expect(response.data.count).to(equal(10))
                                expect(response.data.first?.id).to(equal("13acb877dc4d8030c5dacbde33d3496a2ae3asdc000db4c793bda9c3228baca1a28"))
                                expect(response.data.first?.category).to(equal("General"))
                                expect(response.data.first?.description).to(equal("Forbidden planet"))
                                done()
                            case .failure(let error):
                                expect(error).to(beNil())
                                done()
                            }
                        }
                    }
                }
            }

            context("When there is a no data response") {
                beforeEach {
                    urlSessionMock = .init(data: nil,
                                           mockURL: URLSessionMock.mockUrl,
                                           statusCode: 200)
                    service = .init(session: urlSessionMock)
                }
                it("should return the correct error response") {
                    waitUntil { done in
                        service.getTransactions { response in
                            switch response {
                            case .success(let response):
                                expect(response).to(beNil())
                                done()
                            case .failure(let error):
                                expect(error.localizedDescription).to(equal("No Data Found"))
                                done()
                            }
                        }
                    }
                }
            }

            context("When there is a invalid response") {
                beforeEach {
                    urlSessionMock = .init(data: DataTestHelper.transactionsJson,
                                           mockURL: URLSessionMock.mockUrl,
                                           statusCode: 400)
                    service = .init(session: urlSessionMock)
                }
                it("should return the correct error response") {
                    waitUntil { done in
                        service.getTransactions { response in
                            switch response {
                            case .success(let response):
                                expect(response).to(beNil())
                                done()
                            case .failure(let error):
                                expect(error.localizedDescription).to(equal("Server Error"))
                                done()
                            }
                        }
                    }
                }
            }

            context("When there is a invalid json") {
                beforeEach {
                    urlSessionMock = .init(data: DataTestHelper.invalidJson,
                                           mockURL: URLSessionMock.mockUrl,
                                           statusCode: 200)
                    service = .init(session: urlSessionMock)
                }
                it("should return the correct error response") {
                    waitUntil { done in
                        service.getTransactions { response in
                            switch response {
                            case .success(let response):
                                expect(response).to(beNil())
                                done()
                            case .failure(let error):
                                expect(error.localizedDescription).to(equal("Unexpected response from the backend"))
                                done()
                            }
                        }
                    }
                }
            }
        }
    }
}


