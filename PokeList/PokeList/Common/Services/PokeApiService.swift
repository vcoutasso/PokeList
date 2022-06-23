import Foundation

protocol PokeApiServiceProtocol {
    associatedtype RequestData: PokeApiData

    var endpointUrl: URL { get }
    var decoder: JSONDecoder { get }

    func fetchNextPage(completion: @escaping ([RequestData]) -> Void)
}

final class PokeApiService<T: PokeApiData>: PokeApiServiceProtocol {
    typealias RequestData = T

    // MARK: - Protocol properties

    let endpointUrl: URL
    let decoder: JSONDecoder

    // MARK: - Private properties

    private var currentResponse: PokeApiResponse?

    // MARK: - Inialization

    init(endpointUrl: URL, decoder: JSONDecoder) {
        self.endpointUrl = endpointUrl
        self.decoder = decoder
    }

    // MARK: - Protocol methods

    func fetchNextPage(completion: @escaping ([RequestData]) -> Void) {
        fetchApiResponse { self.fetchDetails(completion: completion) }
    }

    // MARK: - Helper methods

    private func fetchApiResponse(completion: @escaping () -> Void) {
        guard currentResponse == nil || currentResponse?.next != nil,
              let url = currentResponse?.next == nil ? endpointUrl : URL(string: (currentResponse?.next)!)
        else { return }

        let dataTask = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard error == nil,
                  let self = self,
                  let data = data,
                  let result = try? self.decoder.decode(PokeApiResponse.self, from: data)
            else { return }

            self.currentResponse = result
            completion()
        }

        dataTask.resume()
    }

    private func fetchDetails(completion: @escaping ([RequestData]) -> Void) {
        guard let latestResponse = currentResponse else { return }

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
