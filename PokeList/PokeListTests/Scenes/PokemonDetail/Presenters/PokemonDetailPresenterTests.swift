import XCTest
@testable import PokeList

final class PokemonDetailPresenterTests: XCTestCase {
    // MARK: - Subject under test

    private let sut = PokemonDetailPresenter()

    // MARK: - Tests

    func testRegisterDisplayLogicDelegateShouldSetDelegate() {
        // Given
        let delegate = PokemonDetailDisplayLogicSpy()

        // When
        sut.registerDisplayLogicDelegate(delegate)

        // Then
        XCTAssertIdentical(sut.displayLogicDelegate, delegate)
    }
}
