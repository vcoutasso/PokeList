import XCTest
@testable import PokeList

final class PokemonListPresenterTests: XCTestCase {
    // MARK: - Test Doubles

    private let remoteServiceSpy = PokemonApiServiceSpy()
    private let coordinatorSpy = PokemonListCoordinatorSpy()
    private let dispatchQueueFake = DispatchQueueFake()

    // MARK: - Subject under test

    private lazy var sut = PokemonListPresenter(remoteService: remoteServiceSpy, coordinator: coordinatorSpy, dispatchQueue: dispatchQueueFake)

    // MARK: - Tests

    func testShouldCallServiceFetchNextPageCalledWhenFetchDataRequested() {
        // Given / When
        sut.fetchDataRequested()

        // Then
        XCTAssert(remoteServiceSpy.fetchNextPageCalled)
    }

    func testShouldCallDisplayLogicDisplayPokemonsWhenFetchDataCompletes() {
        // Given
        let spy = PokemonListDisplayLogicSpy()
        sut.registerDisplayLogicDelegate(spy)

        // When
        sut.fetchDataRequested()

        // Then
        XCTAssert(spy.displayPokemonsCalled)
    }

    func testShowPokemonDetailRequestedShouldCallCoordinatorShowPokemonDetail() {
        // Given
        let pokemon = Fixtures.Pokemons.bulbasaur

        // When
        sut.showPokemonDetailRequested(for: pokemon)

        // Then
        XCTAssert(coordinatorSpy.showPokemonDetailCalled)
    }

    func testRegisterDisplayLogicDelegateShouldSetDelegate() {
        // Given
        let delegate = PokemonListDisplayLogicSpy()

        // When
        sut.registerDisplayLogicDelegate(delegate)

        // Then
        XCTAssertIdentical(sut.displayLogicDelegate, delegate)
    }
}
