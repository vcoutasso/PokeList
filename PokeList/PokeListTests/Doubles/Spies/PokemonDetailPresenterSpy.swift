import XCTest
@testable import PokeList

final class PokemonDetailPresenterSpy: PokemonDetailPresentationLogic {
    var displayLogicDelegate: PokemonDetailDisplayLogic?

    private(set) var registerDisplayLogicDelegateCalled = false
    func registerDisplayLogicDelegate(_ delegate: PokemonDetailDisplayLogic) {
        registerDisplayLogicDelegateCalled = true
    }
}
