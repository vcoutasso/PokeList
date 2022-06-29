@testable import PokeList
import XCTest

final class PokemonListViewControllerTests: XCTestCase {
    // MARK: - Properties

    private let window = UIWindow()

    // MARK: - Test doubles

    private lazy var coordinator = AppCoordinator(window: window)
    private let tableViewSpy = PokemonListViewSpy()
    private let remoteServiceDummy = PokemonApiServiceDummy()
    private lazy var presentationLogicSpy = PokemonListPresentationLogicSpy(remoteService: remoteServiceDummy)
    private let pokemonTableAdapterSpy = PokemonTableAdapterSpy()

    // MARK: - Subject under test

    private lazy var sut = PokemonListViewController(presenter: presentationLogicSpy, adapter: pokemonTableAdapterSpy, coordinator: coordinator)

    // MARK: - Test setup

    func loadView() {
        window.addSubview(sut.view)
    }

    // MARK: - Tests

    func testSutShouldRegisterDisplayLogicDelegate() {
        // Given / When
        loadView()

        // Then
        XCTAssert(presentationLogicSpy.registerDisplayLogicDelegateCalled)
    }

    func testSutShouldRegisterPrefetchCallback() {
        // Given / When
        loadView()

        // Then
        XCTAssert(pokemonTableAdapterSpy.registerPrefetchCallbackCalled)
    }

    func testViewDidLoadShouldRequestDataFromPresenter() {
        // Given
        loadView()

        // When
        sut.viewDidLoad()

        // Then
        XCTAssert(presentationLogicSpy.fetchDataRequestedCalled)
    }

    func testDisplayPokemonsShouldPopulateTableAdapter() {
        // Given / When
        sut.displayPokemons([], pokemonCount: 0)

        // Then
        XCTAssert(pokemonTableAdapterSpy.populateAndGetIndexPathsToReloadCalled)
    }

    func testDisplayPokemonsShouldReloadDataWhenIndexPathsToReloadIsNil() {
        // Given
        sut.view = tableViewSpy
        pokemonTableAdapterSpy.populateAndGetIndexPathsToReloadStub = nil

        // When
        sut.displayPokemons([], pokemonCount: 0)

        // Then
        XCTAssert(tableViewSpy.reloadDataCalled)
    }

    func testDisplayPokemonsShouldCalculateVisibleIndexPathsToReloadWhenIndexPathToReloadIsNotNil() {
        // Given
        pokemonTableAdapterSpy.populateAndGetIndexPathsToReloadStub = []

        // When
        sut.displayPokemons([], pokemonCount: 0)

        // Then
        XCTAssert(pokemonTableAdapterSpy.visibleIndexPathsToReloadCalled)
    }

    func testDisplayPokemonsShouldReloadRowsWhenIndexPathToReloadIsNotNil() {
        // Given
        sut.view = tableViewSpy
        pokemonTableAdapterSpy.populateAndGetIndexPathsToReloadStub = []

        // When
        sut.displayPokemons([], pokemonCount: 0)

        // Then
        XCTAssert(tableViewSpy.reloadRowsCalled)
    }
}
