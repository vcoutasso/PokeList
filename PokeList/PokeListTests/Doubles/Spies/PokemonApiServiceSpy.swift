import XCTest
@testable import PokeList

final class PokemonApiServiceSpy: PokeApiServiceProtocol {
    var endpointUrl: URL = URL(string: "localhost")!
    var decoder: JSONDecoder = JSONDecoder()

    private(set) var fetchNextPageCalled = false
    func fetchNextPage(completion: @escaping ([Pokemon], Int) -> Void) {
        fetchNextPageCalled = true
        completion([], 0)
    }
}
