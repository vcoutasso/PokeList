import Foundation
import UIKit

final class AppCoordinator: Coordinator {
    // MARK: - Properties

    var childCoordinators: [Coordinator]
    var parent: Coordinator?

    private let window: UIWindow
    private let navigationController: UINavigationController

    // MARK: - Initialization

    init(window: UIWindow) {
        self.window = window
        self.childCoordinators = []

        let service = PokemonServiceFactory.create()
        let presenter = PokemonListPresenter(remoteService: service)
        let adapter = PokemonTableAdapter()
        let rootViewController = PokemonListViewController(presenter: presenter, adapter: adapter)

        self.navigationController = UINavigationController(rootViewController: rootViewController)
    }

    // MARK: - Coordinator methods

    func start() {
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
}
