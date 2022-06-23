import Foundation
import UIKit

protocol TableViewAdapter: UITableViewDataSource, UITableViewDelegate {
    associatedtype DataType: PokeApiData

    var items: [[DataType]] { get }
    var sections: [String] { get }

    func populate(items: [[DataType]], sections: [String])
}

final class PokemonTableAdapter: NSObject, TableViewAdapter {
    private(set) var items: [[Pokemon]] = [[]]
    private(set) var sections: [String] = []

    func populate(items: [[Pokemon]], sections: [String]) {
        self.items = items
        self.sections = sections
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        sections.count
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        sections[section]
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        items[section].count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PokemonTableViewCell.defaultReuseIdentifier, for: indexPath) as? PokemonTableViewCell else { return PokemonTableViewCell() }

        let pokemon = items[indexPath.section][indexPath.row]
        cell.setup(pokemon: pokemon)

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // TODO: Push detail view
    }
}
