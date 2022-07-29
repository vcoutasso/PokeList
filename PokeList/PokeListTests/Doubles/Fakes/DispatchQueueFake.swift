import Foundation
@testable import PokeList

final class DispatchQueueFake: Dispatchable {
    func async(execute work: @escaping () -> Void) {
        work()
    }
}
