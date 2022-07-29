import Foundation

protocol Dispatchable {
    func async(execute work: @escaping () -> Void)
}
