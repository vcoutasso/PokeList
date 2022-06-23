import Foundation

final class PokemonServiceFactory: PokeApiServiceFactoryProtocol {
    static func createService() -> PokeApiService<Pokemon> {
        PokeApiService<Pokemon>(endpointUrlString: "https://pokeapi.co/api/v2/pokemon/", decoder: JSONDecoder())
    }
}
