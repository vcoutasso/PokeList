import Foundation
import UIKit

protocol TableViewAdapter: UITableViewDataSource, UITableViewDelegate {
    associatedtype DataType: PokeApiData

    var pokemons: [DataType] { get }
    var prefetchRequest: (() -> Void)? { get }

    func populateAndGetIndexPathsToReload(with newData: [DataType], totalItemCount: Int) -> [IndexPath]?
    func registerPrefetchCallback(_ callback: @escaping () -> Void)
}

final class PokemonTableAdapter: NSObject, TableViewAdapter {
    // MARK: - Protocol properties

    private(set) var pokemons: [Pokemon]
    private(set) var totalItemCount: Int
    private(set) var prefetchRequest: (() -> Void)?

    // MARK: - Initialization

    init(pokemons: [Pokemon] = [], totalItemCount: Int = 0) {
        self.pokemons = pokemons
        self.totalItemCount = totalItemCount
    }

    // MARK: - Protocol methods

    func populateAndGetIndexPathsToReload(with newData: [Pokemon], totalItemCount: Int) -> [IndexPath]? {
        let indexPathsToReload = pokemons.isEmpty ? nil : calculateIndexPathsToReload(from: newData)

        pokemons.append(contentsOf: newData)
        self.totalItemCount = totalItemCount

        return indexPathsToReload
    }

    func registerPrefetchCallback(_ callback: @escaping () -> Void) {
        self.prefetchRequest = callback
    }

    func visibleIndexPathsToReload(_ tableView: UITableView, intersecting indexPaths: [IndexPath]) -> [IndexPath] {
        guard let indexPathsForVisibleRows = tableView.indexPathsForVisibleRows else { return [] }

        let indexPathsIntersection = Set(indexPathsForVisibleRows).intersection(indexPaths)

        return Array(indexPathsIntersection)
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
            let pokemon = pokemons[indexPath.row]
            cell.setup(pokemon: pokemon)
        }

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

    // MARK: - Private methods

    private func calculateIndexPathsToReload(from newPokemons: [Pokemon]) -> [IndexPath] {
        let startIndex = pokemons.count
        let endIndex = startIndex + newPokemons.count

        return (startIndex..<endIndex).map { IndexPath(row: $0, section: 0) }
    }
}

extension PokemonTableAdapter: UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        if indexPaths.contains(where: isLoadingCell) {
            prefetchRequest?()
        }
    }

    private func isLoadingCell(for indexPath: IndexPath) -> Bool {
        indexPath.row >= pokemons.count
    }
}
