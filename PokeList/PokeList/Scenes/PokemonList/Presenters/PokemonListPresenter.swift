import Foundation
import UIKit

protocol PokemonListPresentationLogic: AnyObject {
    associatedtype ServiceType: PokeApiServiceProtocol

    var displayLogicDelegate: PokemonListDisplayLogic? { get }
    var remoteService: ServiceType { get }

    func fetchDataRequested()
    func showPokemonDetailRequested(for pokemon: Pokemon)

    func registerDisplayLogicDelegate(_ delegate: PokemonListDisplayLogic)
}

final class PokemonListPresenter<PokeApiServiceType: PokeApiServiceProtocol>: PokemonListPresentationLogic where PokeApiServiceType.RequestData == Pokemon {
    // MARK: - Protocol properties

    weak var displayLogicDelegate: PokemonListDisplayLogic?
    let remoteService: PokeApiServiceType
    let coordinator: PokemonListCoordinator

    // MARK: - Initialization

    init(remoteService: PokeApiServiceType, navigationController: UINavigationController) {
        self.remoteService = remoteService
        self.coordinator = PokemonListCoordinator(navigationController: navigationController)
    }

    // MARK: - Protocol methods

    func fetchDataRequested() {
        remoteService.fetchNextPage { [weak self] pokemonPage, pokemonCount in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.displayLogicDelegate?.displayPokemons(pokemonPage, pokemonCount: pokemonCount)
            }
        }
    }

    func showPokemonDetailRequested(for pokemon: Pokemon) {
        coordinator.showPokemonDetail(pokemon)
    }

    func registerDisplayLogicDelegate(_ delegate: PokemonListDisplayLogic) {
        self.displayLogicDelegate = delegate
    }
}
