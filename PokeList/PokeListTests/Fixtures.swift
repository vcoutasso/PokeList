import XCTest
@testable import PokeList

enum Fixtures {
    enum Pokemons {
        static let bulbasaur = Pokemon(id: 1, name: "bulbasaur", height: 7, weight: 69)
        static let charmander = Pokemon(id: 4, name: "charmander", height: 6, weight: 85)
        static let squirtle = Pokemon(id: 7, name: "squirtle", height: 5, weight: 90)

        static let threeStarters = [bulbasaur, charmander, squirtle]
    }
}
