import UIKit

protocol PokemonListDisplayLogic: AnyObject {
    func displayPokemons(_ pokemons: [Pokemon], pokemonCount: Int)
}

final class PokemonListViewController<PresenterType: PokemonListPresentationLogic, AdapterType: TableViewAdapter>: UIViewController where AdapterType.DataType == Pokemon {

    // MARK: - Dependencies

    private let presenter: PresenterType
    private let adapter: AdapterType

    // MARK: - Private properties

    private var pokemonListView: PokemonListViewProtocol? {
        view as? PokemonListViewProtocol
    }

    private lazy var loadingIndicatorView: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.hidesWhenStopped = true
        view.startAnimating()

        return view
    }()

    // MARK: - Initialization

    init(presenter: PresenterType, adapter: AdapterType) {
        self.presenter = presenter
        self.adapter = adapter
        super.init(nibName: nil, bundle: nil)

        presenter.registerDisplayLogicDelegate(self)

        adapter.registerPrefetchCallback { [weak self] in
            self?.requestData()
        }

        title = "Pokémons"
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - View controller lifecycle

    override func loadView() {
        super.loadView()

        view = PokemonListView(delegate: adapter, dataSource: adapter, prefetchDataSource: adapter)

        view.addSubview(loadingIndicatorView)

        NSLayoutConstraint.activate([
            loadingIndicatorView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loadingIndicatorView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        requestData()
    }

    // MARK: - Private methods

    private func requestData() {
        presenter.fetchDataRequested()
    }
}

extension PokemonListViewController: PokemonListDisplayLogic {
    func displayPokemons(_ pokemons: [Pokemon], pokemonCount: Int) {
        guard let pokemonListView = pokemonListView,
              let newIndexPaths = adapter.populateAndGetIndexPathsToReload(with: pokemons, totalItemCount: pokemonCount) else {
            loadingIndicatorView.stopAnimating()
            pokemonListView?.reloadData()
            return
        }

        let indexPathsToReload = adapter.visibleIndexPathsToReload(pokemonListView.tableView, intersecting: newIndexPaths)
        pokemonListView.reloadRows(at: indexPathsToReload)
    }
}
