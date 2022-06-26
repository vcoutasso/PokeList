import Foundation
import UIKit

final class PokemonListView: CodedView {
    // MARK: - Subviews
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(PokemonTableViewCell.self)

        return tableView
    }()

    // MARK: - Initialization

    init(delegate: UITableViewDelegate, dataSource: UITableViewDataSource, prefetchDataSource: UITableViewDataSourcePrefetching) {
        super.init(frame: .zero)
        tableView.delegate = delegate
        tableView.dataSource = dataSource
        tableView.prefetchDataSource = prefetchDataSource
    }

    // MARK: - Public methods

    func reloadRows(at indexPaths: [IndexPath]) {
        tableView.reloadRows(at: indexPaths, with: .automatic)
    }

    func reloadData() {
        tableView.reloadData()
    }

    // MARK: - View lifecycle

    override func addSubviews() {
        addSubview(tableView)
    }

    override func constrainSubviews() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: topAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
    }
}
