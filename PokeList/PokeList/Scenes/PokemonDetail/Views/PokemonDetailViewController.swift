import Foundation
import UIKit

final class PokemonDetailViewController: UIViewController {
    // MARK: - Properties

    private let pokemon: Pokemon

    // MARK: - Initialization

    init(pokemon: Pokemon) {
        self.pokemon = pokemon
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemPink
    }
}
