import XCTest
@testable import PokeList

final class PokemonTableAdapterSpy: NSObject, TableViewAdapter {
    var dataItems: [Pokemon] = []

    var prefetchRequest: (() -> Void)?

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
