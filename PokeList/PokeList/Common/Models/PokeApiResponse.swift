import Foundation

struct PokeApiResponse: Codable {
    let count: Int
    let next: String?
    let previous: String?
    let results: [PokeApiResultInfo]
}

