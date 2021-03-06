import XCTest
@testable import PokeList

final class PokemonListDisplayLogicSpy: PokemonListDisplayLogic {
    private(set) var displayPokemonsCalled = false
    func displayPokemons(_ pokemons: [Pokemon], pokemonCount: Int) {
        displayPokemonsCalled = true
    }

    private(set) var displayPokemonDetailCalled = false
    func displayPokemonDetail(_ pokemon: Pokemon) {
        displayPokemonDetailCalled = true
    }

}
