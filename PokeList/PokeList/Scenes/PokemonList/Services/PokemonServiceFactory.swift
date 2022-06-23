import Foundation

final class PokemonServiceFactory: PokeApiServiceFactory {
    static func createService() -> PokeApiService<Pokemon> {
        let endpointUrlString = "https://pokeapi.co/api/v2/pokemon/"
        let decoder = JSONDecoder()
        
        return PokeApiService<Pokemon>(endpointUrlString: endpointUrlString, decoder: decoder)
    }
}
