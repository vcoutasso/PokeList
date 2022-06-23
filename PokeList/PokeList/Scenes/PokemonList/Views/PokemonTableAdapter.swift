import Foundation
import UIKit

protocol TableViewAdapter: UITableViewDataSource, UITableViewDelegate {
    associatedtype DataType: PokeApiData

    var items: [DataType] { get }
    var sections: [String] { get }

    func populateTable(items: [DataType], sections: [String])
}

final class PokemonTableAdapter: NSObject, TableViewAdapter {
    private(set) var items: [Pokemon] = []
    private(set) var sections: [String] = []

    func populateTable(items: [DataType], sections: [String]) {
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
        items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        UITableViewCell(frame: .zero)
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // TODO: Push detail view
    }
}
