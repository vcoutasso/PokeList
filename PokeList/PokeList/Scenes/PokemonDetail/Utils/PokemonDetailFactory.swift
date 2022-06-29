import Foundation
import UIKit

protocol PokemonDetailFactoryProtocol {
    static func makeViewController(for pokemon: Pokemon) -> UIViewController
}

final class PokemonDetailFactory: PokemonDetailFactoryProtocol {
    static func makeViewController(for pokemon: Pokemon) -> UIViewController {
        let presenter = PokemonDetailPresenter()

        return PokemonDetailViewController(presenter: presenter, pokemon: pokemon)
    }
}
