import Foundation

protocol PokemonListPresentationLogic: AnyObject {
    var displayLogicDelegate: PokemonListDisplayLogic? { get }
    var remoteService: PokeApiService<Pokemon> { get }

    func fetchDataRequested()

    func registerDisplayLogicDelegate(_ delegate: PokemonListDisplayLogic)
}

final class PokemonListPresenter: PokemonListPresentationLogic {
    // MARK: - Protocol properties

    weak var displayLogicDelegate: PokemonListDisplayLogic?
    let remoteService: PokeApiService<Pokemon>

    // MARK: - Private properties

    private var pokemons: [Pokemon] = []

    // MARK: - Initialization

    init(remoteService: PokeApiService<Pokemon>) {
        self.remoteService = remoteService
    }

    // MARK: - Protocol methods

    func fetchDataRequested() {
        remoteService.fetchNextPage { [weak self] pokemonPage, pokemonCount in
            guard let self = self else { return }
            self.pokemons.append(contentsOf: pokemonPage)
            
            DispatchQueue.main.async {
                self.displayLogicDelegate?.displayPokemons(self.pokemons, pokemonCount: pokemonCount)
            }
        }
    }

    func registerDisplayLogicDelegate(_ delegate: PokemonListDisplayLogic) {
        self.displayLogicDelegate = delegate
    }
}
