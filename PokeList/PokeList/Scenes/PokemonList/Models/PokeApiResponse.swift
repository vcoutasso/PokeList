import Foundation

struct PokeApiResponse: Decodable {
    let count: Int
    let next: String?
    let previous: String?
    let results: [PokemonInfoDTO]
}

struct PokemonInfoDTO: Decodable {
    let name: String
    let url: String
}
