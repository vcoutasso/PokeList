import Foundation
import UIKit

protocol PokemonDetailDisplayLogic: AnyObject {}

final class PokemonDetailViewController: UIViewController {
    // MARK: - Dependencies

    private let presenter: PokemonDetailPresentationLogic

    // MARK: - Properties

    private let pokemon: Pokemon

    // MARK: - Subviews

    private lazy var nameStack: UIStackView = {
        makeHorizontalStack("Name:", pokemon.name)
    }()

    private lazy var idStack: UIStackView = {
        makeHorizontalStack("ID:", String(pokemon.id))
    }()

    private lazy var heightStack: UIStackView = {
        makeHorizontalStack("Height:", String(pokemon.height))
    }()

    private lazy var weightStack: UIStackView = {
        makeHorizontalStack("Weight:", String(pokemon.weight))
    }()

    private lazy var infoStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [nameStack, idStack, heightStack, weightStack])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 8
        stack.alignment = .top

        return stack
    }()

    // MARK: - Initialization

    init(presenter: PokemonDetailPresentationLogic, pokemon: Pokemon) {
        self.presenter = presenter
        self.pokemon = pokemon
        super.init(nibName: nil, bundle: nil)

        presenter.registerDisplayLogicDelegate(self)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        view.addSubview(infoStack)

        NSLayoutConstraint.activate([
            infoStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            infoStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            infoStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
        ])
    }

    // MARK: Helper

    private let makeHorizontalStack: (String, String) -> UIStackView = { labelText, contentText in
        let label = UILabel()
        label.text = labelText
        label.font = .systemFont(ofSize: 18, weight: .bold)

        let content = UILabel()
        content.text = contentText
        content.font = .systemFont(ofSize: 16, weight: .regular)

        let stack = UIStackView(arrangedSubviews: [label, content])
        stack.axis = .horizontal
        stack.spacing = 2
        stack.alignment = .center
        stack.distribution = .equalCentering

        return stack
    }
}

extension PokemonDetailViewController: PokemonDetailDisplayLogic {}
