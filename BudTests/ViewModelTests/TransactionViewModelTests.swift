import Quick
import Nimble

@testable import Bud

final class TransactionViewModelTests: QuickSpec {
    override func spec() {
        var viewModel: TransactionViewModel!
        var service: TransactionServiceMock!

        describe("TransactionViewModel") {
            context("When the response is valid") {
                beforeEach {
                    service = .init()
                    viewModel = .init(service: service)
                }
                it("should return the current list of transaction") {
                    waitUntil { done in
                        viewModel.getTransactions { result in
                            switch result {
                            case .success(let response):
                                expect(response).toNot(beNil())
                                expect(viewModel.transactions.count).to(equal(10))
                                expect(viewModel.numberOfRowsInSection).to(equal(10))
                                expect(viewModel.tempTransactionsArray).to(beEmpty())
                                done()
                            case .failure(let error):
                                expect(error).to(beNil())
                                done()
                            }
                        }
                    }
                    expect(service.methodsCalled).to(equal(["getTransactions(completion:)"]))
                }
            }

            context("when there is no data from the backend") {
                beforeEach {
                    service = .init()
                    viewModel = .init(service: service)
                }
                it("should return the correct error") {
                    service.isSuccessfulResponse = false
                    service.error = .noData
                    waitUntil { done in
                        viewModel.getTransactions { result in
                            switch result {
                            case .success(let response):
                                expect(response).to(beNil())
                                done()
                            case .failure(let error):
                                expect(error.localizedDescription).to(equal("No Data Found"))
                                done()
                            }
                        }
                    }
                    expect(service.methodsCalled).to(equal(["getTransactions(completion:)"]))
                }
            }

            context("when there is a error with the decoding") {
                beforeEach {
                    service = .init()
                    viewModel = .init(service: service)
                }
                it("should return the correct error") {
                    service.isSuccessfulResponse = false
                    service.error = .decodingError
                    waitUntil { done in
                        viewModel.getTransactions { result in
                            switch result {
                            case .success(let response):
                                expect(response).to(beNil())
                                done()
                            case .failure(let error):
                                expect(error.localizedDescription).to(equal("Unexpected response from the backend"))
                                done()
                            }
                        }
                    }
                    expect(service.methodsCalled).to(equal(["getTransactions(completion:)"]))
                }
            }

            context("when there is a server error") {
                beforeEach {
                    service = .init()
                    viewModel = .init(service: service)
                }
                it("should return the correct error") {
                    service.isSuccessfulResponse = false
                    service.error = .serverError
                    waitUntil { done in
                        viewModel.getTransactions { result in
                            switch result {
                            case .success(let response):
                                expect(response).to(beNil())
                                done()
                            case .failure(let error):
                                expect(error.localizedDescription).to(equal("Server Error"))
                                done()
                            }
                        }
                    }
                    expect(service.methodsCalled).to(equal(["getTransactions(completion:)"]))
                }
            }

            context("when there is a generic error") {
                beforeEach {
                    service = .init()
                    viewModel = .init(service: service)
                }
                it("should return the correct error") {
                    service.isSuccessfulResponse = false
                    service.error = .genericError("Error String")
                    waitUntil { done in
                        viewModel.getTransactions { result in
                            switch result {
                            case .success(let response):
                                expect(response).to(beNil())
                                done()
                            case .failure(let error):
                                expect(error.localizedDescription).to(equal("Oops: Error String"))
                                done()
                            }
                        }
                    }
                    expect(service.methodsCalled).to(equal(["getTransactions(completion:)"]))
                }
            }

            context("when selecting a single transaction to delete") {
                beforeEach {
                    service = .init()
                    viewModel = .init(service: service,
                                      transactions: [DataTestHelper.mockTransaction(id: "123")])
                }
                it("should hold the correct transaction that have been selected") {
                    viewModel.selectItemToDelete(IndexPath(row: 0, section: 0))
                    expect(viewModel.tempTransactionsArray.count).to(equal(1))
                }
            }

            context("when selecting multipe transaction to delete") {
                beforeEach {
                    service = .init()
                    viewModel = .init(service: service,
                                      transactions: [DataTestHelper.mockTransaction(id: "123"),
                                                     DataTestHelper.mockTransaction(id: "456")])
                }
                it("should hold the correct transaction that have been selected") {
                    viewModel.selectItemToDelete(IndexPath(row: 0, section: 0))
                    viewModel.selectItemToDelete(IndexPath(row: 1, section: 0))
                    expect(viewModel.tempTransactionsArray.count).to(equal(2))
                }
            }

            context("when deleting transactions") {
                beforeEach {
                    service = .init()
                    viewModel = .init(service: service,
                                      transactions: [DataTestHelper.mockTransaction(id: "123"),
                                                     DataTestHelper.mockTransaction(id: "456")])
                }
                it("should delete the correct transaction") {
                    viewModel.selectItemToDelete(IndexPath(row: 0, section: 0))
                    waitUntil { done in
                        viewModel.deleteTranscations {
                            expect(viewModel.transactions.count).to(equal(1))
                            expect(viewModel.transactions.first?.id).to(equal("456"))
                            done()
                        }
                    }
                }
            }

            context("when de selecting a item to delete") {
                beforeEach {
                    service = .init()
                    viewModel = .init(service: service,
                                      transactions: [DataTestHelper.mockTransaction(id: "123"),
                                                    DataTestHelper.mockTransaction(id: "456")],
                                      tempTransactionsArray: [DataTestHelper.mockTransaction(id: "123"),
                                                              DataTestHelper.mockTransaction(id: "456")])
                }
                it("should remove the item from the temp array") {
                    viewModel.deSelectItem(IndexPath(row: 1, section: 0))
                    expect(viewModel.tempTransactionsArray.count).to(equal(1))
                    expect(viewModel.tempTransactionsArray.first?.id).to(equal("123"))
                }
            }

            context("when resetting the items selected") {
                beforeEach {
                    service = .init()
                    viewModel = .init(service: service,
                                      tempTransactionsArray: [DataTestHelper.mockTransaction(id: "123"),
                                                              DataTestHelper.mockTransaction(id: "456")])
                }
                it("should remove all transaction in the array") {
                    viewModel.resetTempArray()
                    expect(viewModel.tempTransactionsArray).to(beEmpty())
                }
            }
        }
    }
}
