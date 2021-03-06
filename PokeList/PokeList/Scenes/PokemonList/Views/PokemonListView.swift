import Foundation
import UIKit

protocol PokemonListViewProtocol {
    var tableView: UITableView { get }

    func reloadRows(at indexPaths: [IndexPath])
    func reloadData()
}

final class PokemonListView: CodedView, PokemonListViewProtocol {
    // MARK: - Subviews

    private(set) lazy var tableView: UITableView = {
        UITableView()
    }()

    // MARK: - Initialization

    init(delegate: UITableViewDelegate, dataSource: UITableViewDataSource, prefetchDataSource: UITableViewDataSourcePrefetching, tableView: UITableView? = nil) {
        super.init(frame: .zero)
        
        if let tableView = tableView {
            self.tableView = tableView
        }

        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        self.tableView.register(PokemonTableViewCell.self)

        self.tableView.delegate = delegate
        self.tableView.dataSource = dataSource
        self.tableView.prefetchDataSource = prefetchDataSource

        // This view will be the roow view of a view controller, so we must keep this set to true
        self.translatesAutoresizingMaskIntoConstraints = true
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
