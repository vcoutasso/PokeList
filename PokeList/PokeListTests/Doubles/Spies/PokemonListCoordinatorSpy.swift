import XCTest
@testable import PokeList

final class PokemonListCoordinatorSpy: PokemonListCoordinatorProtocol {
    var navigationController: UINavigationController = UINavigationController()

    private(set) var startCalled = false
    func start() {
        startCalled = true
    }

    private(set) var showPokemonDetailCalled = false
    func showPokemonDetail(_ pokemon: Pokemon) {
        showPokemonDetailCalled = true
    }

}
