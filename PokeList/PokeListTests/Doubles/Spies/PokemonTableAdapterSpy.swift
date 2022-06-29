import XCTest
@testable import PokeList

final class PokemonTableAdapterSpy: NSObject, TableViewAdapter {
    // MARK: - Properties

    var dataItems: [Pokemon] = []
    var prefetchRequest: (() -> Void)?

    // MARK: - Spy methods

    var populateAndGetIndexPathsToReloadStub: [IndexPath]? = nil
    private(set) var populateAndGetIndexPathsToReloadCalled = false
    func populateAndGetIndexPathsToReload(with newData: [Pokemon], totalItemCount: Int) -> [IndexPath]? {
        populateAndGetIndexPathsToReloadCalled = true
        return populateAndGetIndexPathsToReloadStub
    }

    private(set) var registerPrefetchCallbackCalled = false
    func registerPrefetchCallback(_ callback: @escaping () -> Void) {
        registerPrefetchCallbackCalled = true
    }

    private(set) var visibleIndexPathsToReloadCalled = false
    func visibleIndexPathsToReload(_ tableView: UITableView, intersecting indexPaths: [IndexPath]) -> [IndexPath] {
        visibleIndexPathsToReloadCalled = true
        return []
    }

    private(set) var registerDisplayLogicDelegate = false
    func registerDisplayLogicDelegate(_ delegate: PokemonListDisplayLogic) {
        registerDisplayLogicDelegate = true
    }
}

extension PokemonTableAdapterSpy {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        dataItems.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        UITableViewCell(frame: .zero)
    }

    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
    }
}
