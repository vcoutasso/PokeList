import XCTest
@testable import PokeList

final class PokemonListViewTests: XCTestCase {
    // MARK: - Test doubles

    private let tableViewSpy = TableViewSpy()
    private let adapter = PokemonTableAdapterSpy()

    // MARK: - Subject under test

    private lazy var sut = PokemonListView(delegate: adapter, dataSource: adapter, prefetchDataSource: adapter, tableView: tableViewSpy)

    // MARK: - Tests

    func testSutShouldSetTableViewDelegates() {
        // Given / When

        // Then
        XCTAssertIdentical(sut.tableView.delegate, adapter)
    }

    func testSutShouldSetTableViewDataSource() {
        // Given / When

        // Then
        XCTAssertIdentical(sut.tableView.dataSource, adapter)
    }

    func testSutShouldSetPrefetchDataSource() {
        // Given / When

        // Then
        XCTAssertIdentical(sut.tableView.prefetchDataSource, adapter)
    }

    func testSutShouldRegisterPokemonTableViewCellOnTableView() {
        // Given / When

        // Then
        XCTAssertNotNil( sut.tableView.dequeueReusableCell(withIdentifier: PokemonTableViewCell.defaultReuseIdentifier))
    }

    func testShouldCallTableViewReloadDataWhenSutReloadDataIsCalled() {
        // Given

        // When
        sut.reloadData()

        // Then
        XCTAssert(tableViewSpy.reloadDataCalled)
    }

    func testShouldCallTableViewReloadRowsWhenSutReloadRowsIsCalled() {
        // Given

        // When
        sut.reloadRows(at: [])

        // Then
        XCTAssert(tableViewSpy.reloadRowsCalled)
    }
}
