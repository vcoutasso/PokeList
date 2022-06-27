import XCTest
@testable import PokeList

final class PokemonListViewSpy: CodedView, PokemonListViewProtocol {
    var tableView: UITableView

    init(tableView: UITableView = UITableView()) {
        self.tableView = tableView
        super.init(frame: .zero)
    }

    private(set) var reloadDataCalled = false
    func reloadData() {
        reloadDataCalled = true
    }

    private(set) var reloadRowsCalled = false
    func reloadRows(at indexPaths: [IndexPath]) {
        reloadRowsCalled = true
    }

    override func addSubviews() { }

    override func constrainSubviews() { }
}
