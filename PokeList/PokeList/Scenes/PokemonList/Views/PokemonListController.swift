import UIKit

class PokemonListViewController: UIViewController {
    let service = PokeApiService()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemPink
        service.fetchPokemonPage(completion: { pokemons in print(pokemons) })
    }
}

