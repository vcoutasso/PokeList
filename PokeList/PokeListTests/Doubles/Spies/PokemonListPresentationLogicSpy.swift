import XCTest
@testable import PokeList

final class PokemonListPresentationLogicSpy<PokeApiServiceType: PokeApiServiceProtocol>: PokemonListPresentationLogic where PokeApiServiceType.RequestData == Pokemon {
    var displayLogicDelegate: PokemonListDisplayLogic? = nil
    var remoteService: PokeApiServiceType

    init(remoteService: PokeApiServiceType) {
        self.remoteService = remoteService
    }

    private(set) var fetchDataRequestedCalled = false
    func fetchDataRequested() {
        fetchDataRequestedCalled = true
    }

    private(set) var registerDisplayLogicDelegateCalled = false
    func registerDisplayLogicDelegate(_ delegate: PokemonListDisplayLogic) {
        registerDisplayLogicDelegateCalled = true
    }

    private(set) var showPokemonDetailRequested = false
    func showPokemonDetailRequested(for pokemon: Pokemon) {
        showPokemonDetailRequested = false
    }

}
