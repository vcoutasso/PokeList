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
        let presenter = PokemonDetailPresenter()
        let viewController = PokemonDetailViewController(presenter: presenter, pokemon: pokemon)
        navigationController.pushViewController(viewController, animated: true)
    }
}
