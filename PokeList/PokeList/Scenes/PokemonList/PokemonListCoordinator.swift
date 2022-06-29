import Foundation
import UIKit

final class PokemonListCoordinator: Coordinator {
    let navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let viewController = PokemonListFactory.makeViewController(navigationController: navigationController)
        navigationController.pushViewController(viewController, animated: true)
    }

    func showPokemonDetail(_ pokemon: Pokemon) {
        let viewController = PokemonDetailViewController(pokemon: pokemon)
        navigationController.pushViewController(viewController, animated: true)
    }
}
