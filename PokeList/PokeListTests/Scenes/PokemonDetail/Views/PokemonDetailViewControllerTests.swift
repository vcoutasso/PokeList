import XCTest
@testable import PokeList

final class PokemonDetailViewControllerTests: XCTestCase {
    // MARK: - Subject under test

    private let presenterSpy = PokemonDetailPresenterSpy()
    private lazy var sut = PokemonDetailViewController(presenter: presenterSpy, pokemon: Fixtures.Pokemons.bulbasaur)

    // MARK: - Test setup

    func loadView() {
        let window = UIWindow()
        window.addSubview(sut.view)
    }

    // MARK: - Tests

    func testInitializationShouldRegisterPresenterDisplayLogicDelegate() {
        // Given / When
        loadView()

        // Then
        XCTAssert(presenterSpy.registerDisplayLogicDelegateCalled)
    }
}
