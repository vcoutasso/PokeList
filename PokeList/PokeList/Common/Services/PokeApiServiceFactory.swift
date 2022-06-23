import Foundation

protocol PokeApiServiceFactory {
    associatedtype RequestData: PokeApiDataProtocol

    static func create() -> PokeApiService<RequestData>
}

