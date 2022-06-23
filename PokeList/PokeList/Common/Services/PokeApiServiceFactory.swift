import Foundation

protocol PokeApiServiceFactory {
    associatedtype RequestData: PokeApiDataProtocol

    static func createService() -> PokeApiService<RequestData>
}

