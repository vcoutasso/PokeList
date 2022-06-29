import Foundation
import UIKit

final class AppCoordinator: Coordinator {
    // MARK: - Properties

    private let window: UIWindow
    private let initialCoordinator: Coordinator

    let navigationController: UINavigationController
    
    // MARK: - Initialization

    init(window: UIWindow, navigationController: UINavigationController) {
        self.window = window
        self.navigationController = navigationController
        self.initialCoordinator = PokemonListCoordinator(navigationController: navigationController)

        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }

    // MARK: - Coordinator methods

    func start() {
        initialCoordinator.start()
    }
}
