import UIKit

protocol PokemonListDisplayLogic: AnyObject {
    func displayPokemons(_ pokemons: [[Pokemon]], sections: [String])
}

final class PokemonListViewController: UIViewController {

    // MARK: - Dependencies

    private let presenter: PokemonListPresentationLogic
    private let adapter: PokemonTableAdapter

    // MARK: - Private properties

    private var pokemonListView: PokemonListView? {
        view as? PokemonListView
    }

    // MARK: - Initialization

    init(presenter: PokemonListPresentationLogic, adapter: PokemonTableAdapter) {
        self.presenter = presenter
        self.adapter = adapter
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - View controller lifecycle

    override func loadView() {
        super.loadView()

        view = PokemonListView(delegate: adapter, dataSource: adapter)
        view.backgroundColor = .cyan
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        presenter.fetchDataRequested()
    }
}

extension PokemonListViewController: PokemonListDisplayLogic {
    func displayPokemons(_ pokemons: [[Pokemon]], sections: [String]) {
        adapter.populate(items: pokemons, sections: sections)
        pokemonListView?.reloadData()
    }
}
