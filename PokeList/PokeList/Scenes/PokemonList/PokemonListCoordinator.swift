import Foundation
import UIKit

protocol PokemonListCoordinatorProtocol: Coordinator {
    func showPokemonDetail(_ pokemon: Pokemon)
}

final class PokemonListCoordinator: PokemonListCoordinatorProtocol {
    let navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let viewController = PokemonListFactory.makeViewController(navigationController: navigationController)
        navigationController.pushViewController(viewController, animated: true)
    }

    func showPokemonDetail(_ pokemon: Pokemon) {
        let viewController = PokemonDetailFactory.makeViewController(for: pokemon)
        navigationController.pushViewController(viewController, animated: true)
    }
}
