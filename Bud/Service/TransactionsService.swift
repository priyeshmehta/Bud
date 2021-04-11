import Foundation

protocol TransactionServiceType {
    func getTransactions(completion: @escaping (Result<Transactions, NetworkError>) -> Void)
}

enum NetworkError: Error {
    case genericError(String)
    case serverError
    case noData
    case decodingError

    var localizedDescription: String {
        switch self {
        case .genericError(let error):
            return "genericError".localizedWith([error])
        case .serverError:
            return "serverError".localized
        case .noData:
            return "noDataFound".localized
        case .decodingError:
            return "decodingError".localized
        }
    }
}

final class TransactionService: TransactionServiceType {

    private let session: URLSession

    init(session: URLSession = .shared) {
        self.session = session
    }

    func getTransactions(completion: @escaping (Result<Transactions, NetworkError>) -> Void) {
        guard let url = URL(string: urlPath) else {
            return
        }

        let task = session.dataTask(with: url) { (data, response, error) in
            guard error == nil else {
                completion(.failure(.genericError(error?.localizedDescription ?? "N/A")))
                return
            }

            guard let data  = data else {
                completion(.failure(.noData))
                return
            }

            guard self.responseParser(for: response as? HTTPURLResponse) else {
                return completion(.failure(.serverError))
            }

            guard let json = try? JSONDecoder().decode(Transactions.self, from: data) else {
                completion(.failure(.decodingError))
                return
            }
            return completion(.success(json))
        }
        task.resume()
    }
}

private extension TransactionService {
    enum Constants {
        static let scheme = "http"
        static let host = "mocky.io"
        static let path = "/v2/5b36325b340000f60cf88903"
    }

    var urlPath: String {
        var components = URLComponents()
        components.scheme = Constants.scheme
        components.host = Constants.host
        components.path = Constants.path

        guard let urlString  = components.url?.absoluteString else {
            fatalError("URL could not be constructed")
        }
        return urlString
    }

    func responseParser(for response: HTTPURLResponse?) -> Bool {
        guard let response = response else {
            return false
        }

        switch response.statusCode {
        case 200...299:
            return true
        default:
            return false
        }
    }
}
