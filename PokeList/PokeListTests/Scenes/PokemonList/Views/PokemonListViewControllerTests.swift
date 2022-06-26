@testable import PokeList
import XCTest

class PokemonListViewControllerTests: XCTestCase {
    // MARK: - Properties

    private let window = UIWindow()

    // MARK: - Test doubles

    private let tableViewSpy = PokemonListViewSpy()
    private let remoteServiceDummy = PokemonApiServiceDummy()
    private lazy var presentationLogicSpy = PokemonListPresentationLogicSpy(remoteService: remoteServiceDummy)
    private let pokemonTableAdapterSpy = PokemonTableAdapterSpy()

    // MARK: - Subject under test

    private lazy var sut = PokemonListViewController(presenter: presentationLogicSpy, adapter: pokemonTableAdapterSpy)

    // MARK: - Test setup

    func loadView() {
        window.addSubview(sut.view)
    }

    // MARK: - Tests

    func test_sutShouldRegisterDisplayLogicDelegate() {
        // Given
        loadView()

        // When / Then
        XCTAssert(presentationLogicSpy.registerDisplayLogicDelegateCalled)
    }

    func test_sutShouldRegisterPrefetchCallback() {
        // Given
        loadView()

        // When / Then
        XCTAssert(pokemonTableAdapterSpy.registerPrefetchCallbackCalled)
    }

    func test_viewDidLoadShouldRequestDataFromPresenter() {
        // Given
        loadView()

        // When
        sut.viewDidLoad()

        // Then
        XCTAssert(presentationLogicSpy.fetchDataRequestedCalled)
    }

    func test_displayPokemonsShouldPopulateTableAdapter() {
        // Given / When
        sut.displayPokemons([], pokemonCount: 0)

        // Then
        XCTAssert(pokemonTableAdapterSpy.populateAndGetIndexPathsToReloadCalled)
    }

    func test_displayPokemonsShouldReloadDataWhenIndexPathsToReloadIsNil() {
        // Given
        sut.view = tableViewSpy
        pokemonTableAdapterSpy.populateAndGetIndexPathsToReloadStub = nil

        // When
        sut.displayPokemons([], pokemonCount: 0)

        // Then
        XCTAssert(tableViewSpy.reloadDataCalled)
    }

    func test_displayPokemonsShouldCalculateVisibleIndexPathsToReloadWhenIndexPathToReloadIsNotNil() {
        // Given
        pokemonTableAdapterSpy.populateAndGetIndexPathsToReloadStub = []

        // When
        sut.displayPokemons([], pokemonCount: 0)

        // Then
        XCTAssert(pokemonTableAdapterSpy.visibleIndexPathsToReloadCalled)
    }

    func test_displayPokemonsShouldReloadRowsWhenIndexPathToReloadIsNotNil() {
        // Given
        sut.view = tableViewSpy
        pokemonTableAdapterSpy.populateAndGetIndexPathsToReloadStub = []

        // When
        sut.displayPokemons([], pokemonCount: 0)

        // Then
        XCTAssert(tableViewSpy.reloadRowsCalled)
    }
}
