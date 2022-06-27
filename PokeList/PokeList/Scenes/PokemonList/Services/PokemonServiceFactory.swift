import Foundation

final class PokemonServiceFactory: PokeApiServiceFactory {
    private init() {
        // This class should not be instantiated and is only used to access its static methods
    }
    
    static func create() -> PokeApiService<Pokemon> {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "pokeapi.co"
        components.path = "/api/v2/pokemon"

        guard let endpointUrl = components.url else { fatalError("Malformed \(String(describing: self)) URL") }

        let decoder = JSONDecoder()

        return PokeApiService<Pokemon>(endpointUrl: endpointUrl, decoder: decoder)
    }
}
