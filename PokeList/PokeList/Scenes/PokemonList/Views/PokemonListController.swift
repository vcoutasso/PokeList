import UIKit

final class PokemonListViewController: UIViewController {
    let service = PokemonServiceFactory.create()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemPink
        service.fetchNextPage(completion: { pokemons in print(pokemons) })
    }
}

