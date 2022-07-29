import Foundation
import UIKit

protocol PokemonListFactoryProtocol {
    static func makeViewController(navigationController: UINavigationController) -> UIViewController
    static func makeService() -> PokeApiService<Pokemon>
}

final class PokemonListFactory: PokemonListFactoryProtocol {
    private init() {
        // This class should not be instantiated and is only used to access its static methods
    }

    static func makeViewController(navigationController: UINavigationController) -> UIViewController {
        let service = PokemonListFactory.makeService()
        let coordinator = PokemonListCoordinator(navigationController: navigationController)
        let presenter = PokemonListPresenter(remoteService: service, coordinator: coordinator, dispatchQueue: DispatchQueue.main)
        let adapter = PokemonTableAdapter()
        let viewController = PokemonListViewController(presenter: presenter, adapter: adapter)

        return viewController
    }

    static func makeService() -> PokeApiService<Pokemon> {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "pokeapi.co"
        components.path = "/api/v2/pokemon"

        guard let endpointUrl = components.url else { fatalError("Malformed \(String(describing: self)) URL") }

        let decoder = JSONDecoder()

        return PokeApiService<Pokemon>(endpointUrl: endpointUrl, decoder: decoder)
    }
}
