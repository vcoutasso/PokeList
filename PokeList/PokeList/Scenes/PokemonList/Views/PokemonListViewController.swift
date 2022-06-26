import UIKit

protocol PokemonListDisplayLogic: AnyObject {
    func displayPokemons(_ pokemons: [Pokemon], pokemonCount: Int)
}

final class PokemonListViewController: UIViewController {

    // MARK: - Dependencies

    private let presenter: PokemonListPresentationLogic
    private let adapter: PokemonTableAdapter

    // MARK: - Private properties

    private var pokemonListView: PokemonListView? {
        view as? PokemonListView
    }

    private lazy var loadingIndicatorView: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.hidesWhenStopped = true
        view.startAnimating()

        return view
    }()

    // MARK: - Initialization

    init(presenter: PokemonListPresentationLogic, adapter: PokemonTableAdapter) {
        self.presenter = presenter
        self.adapter = adapter
        super.init(nibName: nil, bundle: nil)

        adapter.registerPrefetchCallback { [weak self] in
            self?.requestData()
        }
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

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        requestData()
    }

    // MARK: - Private methods

    @objc private func requestData() {
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
