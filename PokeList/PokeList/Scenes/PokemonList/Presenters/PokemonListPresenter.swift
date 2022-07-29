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

    private(set) weak var displayLogicDelegate: PokemonListDisplayLogic?
    let remoteService: PokeApiServiceType
    let coordinator: PokemonListCoordinatorProtocol
    let dispatchQueue: Dispatchable

    // MARK: - Initialization

    init(remoteService: PokeApiServiceType, coordinator: PokemonListCoordinatorProtocol, dispatchQueue: Dispatchable) {
        self.remoteService = remoteService
        self.coordinator = coordinator
        self.dispatchQueue = dispatchQueue
    }

    // MARK: - Protocol methods

    func fetchDataRequested() {
        remoteService.fetchNextPage { [weak self] pokemonPage, pokemonCount in
            guard let self = self else { return }
            self.dispatchQueue.async {
                self.displayLogicDelegate?.displayPokemons(pokemonPage, pokemonCount: pokemonCount)
            }
        }
    }

    func showPokemonDetailRequested(for pokemon: Pokemon) {
        coordinator.showPokemonDetail(pokemon)
    }

    func registerDisplayLogicDelegate(_ delegate: PokemonListDisplayLogic) {
        displayLogicDelegate = delegate
    }
}
