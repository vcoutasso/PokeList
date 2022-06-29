import Foundation

protocol PokeApiServiceProtocol {
    associatedtype RequestData: PokeApiData

    var endpointUrl: URL { get }
    var decoder: JSONDecoder { get }

    func fetchNextPage(completion: @escaping ([RequestData], Int) -> Void)
}

final class PokeApiService<T: PokeApiData>: PokeApiServiceProtocol {
    typealias RequestData = T

    // MARK: - Protocol properties

    let endpointUrl: URL
    let decoder: JSONDecoder

    // MARK: - Private properties

    private var currentResponse: PokeApiResponse?
    private var lastRequestURL: URL?

    private let queue: DispatchQueue
    private let semaphore: DispatchSemaphore

    // MARK: - Inialization

    init(endpointUrl: URL, decoder: JSONDecoder) {
        self.endpointUrl = endpointUrl
        self.decoder = decoder
        self.queue = DispatchQueue(label: "com.vcoutasso.PokeList.PokeApiQueue")
        self.semaphore = DispatchSemaphore(value: 0)
    }

    // MARK: - Protocol methods

    func fetchNextPage(completion: @escaping ([RequestData], Int) -> Void) {
        queue.async {
            self.fetchApiResponse { self.fetchDetails(response: $0, completion: completion) }
            self.semaphore.wait()
        }
    }

    // MARK: - Helper methods

    private func fetchApiResponse(completion: @escaping (PokeApiResponse) -> Void) {
        guard currentResponse == nil || currentResponse?.next != nil,
              let url = currentResponse?.next == nil ? endpointUrl : URL(string: (currentResponse?.next)!),
              lastRequestURL == nil || lastRequestURL != url
        else { return }

        lastRequestURL = url

        let dataTask = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard error == nil,
                  let self = self,
                  let data = data,
                  let result = try? self.decoder.decode(PokeApiResponse.self, from: data)
            else { return }

            self.currentResponse = result
            completion(result)
            self.semaphore.signal()
        }

        dataTask.resume()
    }

    private func fetchDetails(response: PokeApiResponse, completion: @escaping ([RequestData], Int) -> Void) {
        guard let latestResponse = currentResponse else { return }

        var pokemonList = [RequestData]()
        let dispatchGroup = DispatchGroup()

        for pokemonInfo in response.results {
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
            completion(pokemonList, latestResponse.count)
        }
    }
}
