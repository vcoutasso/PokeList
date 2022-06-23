import Foundation

protocol PokemonListPresentationLogic: AnyObject {
    var viewController: PokemonListDisplayLogic? { get }
    var remoteService: PokeApiService<Pokemon> { get }

    func fetchDataRequested()

    func registerDisplayLogic(viewController: PokemonListDisplayLogic)
}

final class PokemonListPresenter: PokemonListPresentationLogic {
    // MARK: - Protocol properties

    weak var viewController: PokemonListDisplayLogic?
    let remoteService: PokeApiService<Pokemon>

    // MARK: - Initialization

    init(remoteService: PokeApiService<Pokemon>) {
        self.remoteService = remoteService
    }

    // MARK: - Protocol methods

    func fetchDataRequested() {
        remoteService.fetchNextPage { [weak self] pokemons in
            self?.viewController?.displayPokemons(pokemons)
        }
    }

    func registerDisplayLogic(viewController: PokemonListDisplayLogic) {
        self.viewController = viewController
    }
}
