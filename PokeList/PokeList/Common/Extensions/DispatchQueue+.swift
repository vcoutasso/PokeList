import Foundation

// MARK: - DispatchQueue + Dispatchable

extension DispatchQueue: Dispatchable {
    func async(execute work: @escaping () -> Void) {
        async(group: nil, qos: .unspecified, flags: [], execute: work)
    }
}
