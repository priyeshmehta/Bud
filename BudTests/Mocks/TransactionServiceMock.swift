import Foundation

@testable import Bud

final class TransactionServiceMock: TransactionServiceType {
    var isSuccessfulResponse: Bool = true
    var error: NetworkError = .genericError("generic error")
    var methodsCalled = [String]()

    func getTransactions(completion: @escaping (Result<Transactions, NetworkError>) -> Void) {
        methodsCalled.append(#function)
        isSuccessfulResponse ?
            completion(.success(DataTestHelper.transactions))
        : completion(.failure(error))
    }


}
