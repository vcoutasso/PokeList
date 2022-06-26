import Foundation

protocol PokemonListPresentationLogic: AnyObject {
    associatedtype ServiceType: PokeApiServiceProtocol

    var displayLogicDelegate: PokemonListDisplayLogic? { get }
    var remoteService: ServiceType { get }

    func fetchDataRequested()

    func registerDisplayLogicDelegate(_ delegate: PokemonListDisplayLogic)
}

final class PokemonListPresenter<PokeApiServiceType: PokeApiServiceProtocol>: PokemonListPresentationLogic where PokeApiServiceType.RequestData == Pokemon {
    // MARK: - Protocol properties

    weak var displayLogicDelegate: PokemonListDisplayLogic?
    let remoteService: PokeApiServiceType

    // MARK: - Initialization

    init(remoteService: PokeApiServiceType) {
        self.remoteService = remoteService
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

    func registerDisplayLogicDelegate(_ delegate: PokemonListDisplayLogic) {
        self.displayLogicDelegate = delegate
    }
}
