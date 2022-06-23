import Foundation

struct PokeApiResponse: Decodable {
    let count: Int
    let next: String?
    let previous: String?
    let results: [PokeApiResultInfo]
}

struct PokeApiResultInfo: Decodable {
    let name: String
    let url: String
}

protocol PokeApiDataProtocol: Decodable {
    var id: Int { get }
}
