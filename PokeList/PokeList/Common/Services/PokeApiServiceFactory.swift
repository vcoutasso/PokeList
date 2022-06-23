import Foundation

protocol PokeApiServiceFactory {
    associatedtype RequestData: PokeApiData

    static func create() -> PokeApiService<RequestData>
}

