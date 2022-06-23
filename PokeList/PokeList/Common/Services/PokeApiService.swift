import Foundation

protocol PokeApiServiceProtocol {
    associatedtype RequestData: PokeApiDataProtocol

    var endpointUrlString: String { get }
    var decoder: JSONDecoder { get }

    func fetchNextPage(completion: @escaping ([RequestData]) -> Void)
}

final class PokeApiService<T: PokeApiDataProtocol>: PokeApiServiceProtocol {
    typealias RequestData = T
    
    private var latestResponse: PokeApiResponse?

    let endpointUrlString: String
    let decoder: JSONDecoder

    init(endpointUrlString: String, decoder: JSONDecoder) {
        self.endpointUrlString = endpointUrlString
        self.decoder = decoder
    }

    func fetchNextPage(completion: @escaping ([RequestData]) -> Void) {
        fetchApiResponse { self.fetchDetails(completion: completion) }
    }

    private func fetchApiResponse(completion: @escaping () -> Void) {
        guard latestResponse == nil || latestResponse?.next != nil,
              let nextRequestString = latestResponse?.next ?? Optional(endpointUrlString),
              let requestUrl = URL(string: nextRequestString)
        else { return }

        let dataTask = URLSession.shared.dataTask(with: requestUrl) { [weak self] data, response, error in
            guard error == nil,
                  let self = self,
                  let data = data,
                  let result = try? self.decoder.decode(PokeApiResponse.self, from: data)
            else { return }

            self.latestResponse = result
            completion()
        }

        dataTask.resume()
    }

    private func fetchDetails(completion: @escaping ([RequestData]) -> Void) {
        guard let latestResponse = latestResponse else { return }

        var pokemonList = [RequestData]()
        let dispatchGroup = DispatchGroup()

        for pokemonInfo in latestResponse.results {
            guard let url = URL(string: pokemonInfo.url) else { continue }

            dispatchGroup.enter()

            let dataTask = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
                guard error == nil,
                      let self = self,
                      let data = data,
                      let result = try? self.decoder.decode(RequestData.self, from: data)
                else { return }

                pokemonList.append(result)

                dispatchGroup.leave()
            }

            dataTask.resume()
        }

        dispatchGroup.notify(queue: .global()) {
            completion(pokemonList.sorted { $0.id < $1.id })
        }
    }
}
