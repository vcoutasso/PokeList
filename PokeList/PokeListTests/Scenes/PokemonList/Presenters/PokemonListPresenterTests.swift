import XCTest
@testable import PokeList

final class PokemonListPresenterTests: XCTestCase {
    // MARK: - Test Doubles

    private let remoteServiceSpy = PokemonApiServiceSpy()

    // MARK: = Subject under test

    private lazy var sut = PokemonListPresenter(remoteService: remoteServiceSpy)

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
        // TODO: This could be more elegant
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            XCTAssert(spy.displayPokemonsCalled)
        }
    }
}
