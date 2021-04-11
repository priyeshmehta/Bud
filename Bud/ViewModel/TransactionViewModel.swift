import Foundation

protocol TransactionViewModelType {
    var transactions: [Transaction] { get }
    var tempTransactionsArray: [Transaction] { get }
    var numberOfRowsInSection: Int { get }

    func getTransactions(completion: @escaping (Result<(), NetworkError>) -> Void)
    func deleteTranscations(completion: @escaping () -> Void)
    func deSelectItem(_ indexPath: IndexPath)
    func selectItemToDelete(_ indexPath: IndexPath)
    func resetTempArray()
}

final class TransactionViewModel: TransactionViewModelType {

    private let service: TransactionServiceType
    private (set) public var transactions: [Transaction]
    private (set) public var tempTransactionsArray: [Transaction]

    init(service: TransactionServiceType = TransactionService(),
         transactions: [Transaction] = [Transaction](),
         tempTransactionsArray: [Transaction] = [Transaction]()) {
        self.service = service
        self.transactions = transactions
        self.tempTransactionsArray = tempTransactionsArray
    }

    func getTransactions(completion: @escaping (Result<(), NetworkError>) -> Void) {
        service.getTransactions { [weak self] result in
            switch result {
            case.success(let transactionsList):
                self?.transactions.append(contentsOf: transactionsList.data)
                completion(.success(()))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    var numberOfRowsInSection: Int {
        transactions.count
    }

    func selectItemToDelete(_ indexPath: IndexPath) {
        tempTransactionsArray.append(transactions[indexPath.row])
    }

    func deleteTranscations(completion: @escaping () -> Void) {
        if !tempTransactionsArray.isEmpty {
            transactions = transactions.filter { !tempTransactionsArray.map { $0.id }.contains($0.id) }
            completion()
        }
    }

    func deSelectItem(_ indexPath: IndexPath) {
        tempTransactionsArray.removeAll { $0.id == transactions[indexPath.row].id }
    }

    func resetTempArray() {
        if !tempTransactionsArray.isEmpty {
            tempTransactionsArray.removeAll()
        }
    }
}
