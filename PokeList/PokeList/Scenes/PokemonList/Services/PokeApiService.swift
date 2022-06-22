import Foundation

protocol PokeApiServiceProtocol {
    func fetchPokemonPage(completion: @escaping ([Pokemon]) -> Void)
}

final class PokeApiService: PokeApiServiceProtocol {
    private let endpointUrl = URL(string: "https://pokeapi.co/api/v2/pokemon/")
    private var latestResponse: PokeApiResponse?

    func fetchPokemonPage(completion: @escaping ([Pokemon]) -> Void) {
        guard let latestResponse = latestResponse else {
            fetchApiResponse { [weak self] in self?.fetchPokemonPage(completion: completion) }
            return
        }

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
            completion(pokemonList)
        }
    }

    private func fetchApiResponse(completion: @escaping () -> Void) {
        guard let url = endpointUrl else { return }

        let dataTask = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
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
