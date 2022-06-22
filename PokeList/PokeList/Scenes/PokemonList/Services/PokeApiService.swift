import Foundation

protocol PokeApiServiceProtocol {
    func fetchPokemonPage(completion: @escaping ([Pokemon]) -> Void)
}

final class PokeApiService: PokeApiServiceProtocol {
    private let endpointUrlString = "https://pokeapi.co/api/v2/pokemon/"
    private var latestResponse: PokeApiResponse?

    func fetchPokemonPage(completion: @escaping ([Pokemon]) -> Void) {
        fetchApiResponse { self.fetchPokemonDetails(completion: completion) }
    }

    private func fetchPokemonDetails(completion: @escaping ([Pokemon]) -> Void) {
        guard let latestResponse = latestResponse else { return }

        var pokemonList = [Pokemon]()
        let dispatchGroup = DispatchGroup()

        for pokemonInfo in latestResponse.results {
            guard let url = URL(string: pokemonInfo.url) else { continue }

            dispatchGroup.enter()

            let dataTask = URLSession.shared.dataTask(with: url) { data, response, error in
                guard let data = data,
                      let pokemon = try? JSONDecoder().decode(Pokemon.self, from: data) else { return }

                pokemonList.append(pokemon)

                dispatchGroup.leave()
            }

            dataTask.resume()
        }

        dispatchGroup.notify(queue: .global()) {
            completion(pokemonList.sorted { $0.id < $1.id })
        }
    }

    private func fetchApiResponse(completion: @escaping () -> Void) {
        guard latestResponse == nil || latestResponse?.next != nil,
              let nextRequestString = latestResponse?.next ?? Optional(endpointUrlString),
              let requestUrl = URL(string: nextRequestString)
        else { return }

        let dataTask = URLSession.shared.dataTask(with: requestUrl) { [weak self] data, response, error in
            guard let self = self,
                  let data = data,
                  let response = try? JSONDecoder().decode(PokeApiResponse.self, from: data)
            else { return }

            self.latestResponse = response
            completion()
        }

        dataTask.resume()
    }
}
