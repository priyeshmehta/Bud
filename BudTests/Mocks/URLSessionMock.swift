import Foundation

final class URLSessionMock: URLSession {

    private let data: Data?
    private let error: Error?
    private var response: HTTPURLResponse?

    init(data: Data?, error: Error? = nil, mockURL: URL, statusCode: Int) {
        self.data = data
        self.error = error
        self.response = response ?? HTTPURLResponse(url: mockURL,
                                                    statusCode: statusCode,
                                                    httpVersion: nil,
                                                    headerFields: nil)!
    }

    override func dataTask(with url: URL,
                           completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void
    ) -> URLSessionDataTask {
        return URLSessionDataTaskMock {
            completionHandler(self.data, self.response, self.error)
        }
    }
}

extension URLSessionMock {
    static var mockUrl: URL {
        URL(string: "https://google.com")!
    }
}

private class URLSessionDataTaskMock: URLSessionDataTask {
    private let closure: () -> Void
    
    init(closure: @escaping () -> Void) {
        self.closure = closure
    }

    override func resume() {
        closure()
    }
}

