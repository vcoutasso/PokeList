import Foundation

protocol Coordinator: AnyObject {
    var childCoordinators: [Coordinator] { get set }
    var parent: Coordinator? { get set }

    func start()
}
