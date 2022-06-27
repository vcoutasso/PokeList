import XCTest
@testable import PokeList

final class PokemonTableAdapterTests: XCTestCase {
    // MARK: - Subject under test

    private let sut = PokemonTableAdapter()

    // MARK: - Tests

    func testPopulateAndGetIndexPathsToReloadShouldAppendNewData() {
        // Given
        let expectedResult = Fixtures.Pokemons.threeStarters

        // When
        _ = sut.populateAndGetIndexPathsToReload(with: expectedResult, totalItemCount: expectedResult.count)

        // Then
        XCTAssertEqual(sut.dataItems, expectedResult)
    }

    func testPopulateAndGetIndexPathsToReloadShouldNotReplaceData() {
        // Given
        let firstItem = [Fixtures.Pokemons.bulbasaur]
        let newData = [Fixtures.Pokemons.charmander, Fixtures.Pokemons.squirtle]
        let expectedResult = Fixtures.Pokemons.threeStarters

        // When
        _ = sut.populateAndGetIndexPathsToReload(with: firstItem, totalItemCount: expectedResult.count)
        _ = sut.populateAndGetIndexPathsToReload(with: newData, totalItemCount: expectedResult.count)

        // Then
        XCTAssertEqual(sut.dataItems, expectedResult)
    }

    func testPopulateAndGetIndexPathsToReloadShouldUpdateTotalItemCount() {
        // Given
        let expectedResult = Int.random(in: 1...100)
        XCTAssertEqual(sut.totalItemCount, 0)

        // When
        _ = sut.populateAndGetIndexPathsToReload(with: [], totalItemCount: expectedResult)

        // Then
        XCTAssertEqual(sut.totalItemCount, expectedResult)
    }

    func testPopulateAndGetIndexPathsToReloadShouldReturnNilWhenDataItemsIsEmpty() {
        // Given
        let newPokemons = [Fixtures.Pokemons.charmander]
        XCTAssertEqual(sut.dataItems, [])

        // When
        let result = sut.populateAndGetIndexPathsToReload(with: newPokemons, totalItemCount: newPokemons.count)

        // Then
        XCTAssertNil(result)
    }

    func testPopulateAndGetIndexPathsToReloadShouldCalculateIndexPathsToReload() {
        // Given
        let initialPokemons = [Fixtures.Pokemons.bulbasaur]
        let newPokemons = [Fixtures.Pokemons.charmander, Fixtures.Pokemons.squirtle]
        let totalCount = Fixtures.Pokemons.threeStarters.count
        _ = sut.populateAndGetIndexPathsToReload(with: initialPokemons, totalItemCount: totalCount)

        let expectedResult: [IndexPath] = [IndexPath(row: 1, section: 0), IndexPath(row: 2, section: 0)]

        // When
        let result = sut.populateAndGetIndexPathsToReload(with: newPokemons, totalItemCount: totalCount)

        // Then
        XCTAssertEqual(result, expectedResult)
    }
}
