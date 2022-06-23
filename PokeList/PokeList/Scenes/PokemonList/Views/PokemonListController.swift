import UIKit

final class PokemonListViewController: UIViewController {
    let service = PokemonServiceFactory.createService()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemPink
        service.fetchNextPage(completion: { pokemons in print(pokemons) })
    }
}

