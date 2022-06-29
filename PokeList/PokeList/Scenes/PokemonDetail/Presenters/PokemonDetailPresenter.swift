import Foundation

protocol PokemonDetailPresentationLogic {
    var displayLogicDelegate: PokemonDetailDisplayLogic? { get }

    func registerDisplayLogicDelegate(_ delegate: PokemonDetailDisplayLogic)
}

final class PokemonDetailPresenter: PokemonDetailPresentationLogic {
    var displayLogicDelegate: PokemonDetailDisplayLogic?

    func registerDisplayLogicDelegate(_ delegate: PokemonDetailDisplayLogic) {
        self.displayLogicDelegate = delegate
    }
}
