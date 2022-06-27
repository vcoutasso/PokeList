import XCTest
@testable import PokeList

final class PokemonApiServiceDummy: PokeApiServiceProtocol {
    var endpointUrl: URL = URL(string: "localhost")!
    var decoder: JSONDecoder = JSONDecoder()

    func fetchNextPage(completion: @escaping ([Pokemon], Int) -> Void) {
    }
}

