import Foundation

extension String {
    static var empty = ""

    var localized: String {
        NSLocalizedString(self, comment: .empty)
    }

    func localizedWith(_ params: [CVarArg]) -> String {
        String(format: localized, arguments: params)
    }
}
