import UIKit

protocol PokemonListDisplayLogic: AnyObject {
    func displayPokemons(_ pokemons: [Pokemon])
}

final class PokemonListViewController: UIViewController {

    // MARK: - Dependencies

    private let presenter: PokemonListPresentationLogic
    private let adapter: PokemonTableAdapter

    // MARK: - Initialization

    init(presenter: PokemonListPresentationLogic, adapter: PokemonTableAdapter) {
        self.presenter = presenter
        self.adapter = adapter
        super.init(nibName: nil, bundle: nil)

        self.presenter.registerDisplayLogic(viewController: self)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        presenter.fetchDataRequested()
    }
}

extension PokemonListViewController: PokemonListDisplayLogic {
    func displayPokemons(_ pokemons: [Pokemon]) {
        // TODO: Implement
    }
}
