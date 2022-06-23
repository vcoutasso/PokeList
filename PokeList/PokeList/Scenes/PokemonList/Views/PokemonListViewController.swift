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

    private var refreshControl: UIRefreshControl?

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
        adapter.populate(items: pokemons, total: pokemonCount)
        pokemonListView?.reloadData()
    }
}
