import Foundation

protocol PokeApiServiceFactoryProtocol {
    associatedtype RequestData: PokeApiDataProtocol

    static func createService() -> PokeApiService<RequestData>
}

