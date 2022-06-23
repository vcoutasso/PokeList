import Foundation
import UIKit

protocol TableViewAdapter: UITableViewDataSource, UITableViewDelegate {
    associatedtype DataType: PokeApiData

    var items: [DataType] { get }
    var prefetchRequest: (() -> Void)? { get }

    func populate(items: [DataType], total: Int)
    func registerPrefetchCallback(_ callback: @escaping () -> Void)
}

final class PokemonTableAdapter: NSObject, TableViewAdapter {
    // MARK: - Protocol properties

    private(set) var items: [Pokemon] = []
    private(set) var totalItemCount: Int = 0
    private(set) var prefetchRequest: (() -> Void)?

    // MARK: - Protocol methods

    func populate(items: [Pokemon], total: Int) {
        self.items = items
        self.totalItemCount = total
    }

    func registerPrefetchCallback(_ callback: @escaping () -> Void) {
        self.prefetchRequest = callback
    }

    // MARK: - Table view adapter methods

    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        totalItemCount
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PokemonTableViewCell.defaultReuseIdentifier, for: indexPath) as? PokemonTableViewCell else { return PokemonTableViewCell() }

        if isLoadingCell(for: indexPath) {
            cell.setup(pokemon: nil)
        } else {
            let pokemon = items[indexPath.row]
            cell.setup(pokemon: pokemon)
        }

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension PokemonTableAdapter: UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        if indexPaths.contains(where: isLoadingCell) {
            prefetchRequest?()
        }
    }

    private func isLoadingCell(for indexPath: IndexPath) -> Bool {
        indexPath.row >= items.count
    }
}
