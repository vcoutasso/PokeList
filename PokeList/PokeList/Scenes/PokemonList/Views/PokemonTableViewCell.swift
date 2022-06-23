import Foundation
import UIKit

final class PokemonTableViewCell: CodedTableViewCell, ReusableView {
    // MARK: - Subviews

    private lazy var idLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()

    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()

    private lazy var heightLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false


        return label
    }()

    private lazy var weightLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false


        return label
    }()

    private lazy var stackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [
            idLabel,
            nameLabel,
            heightLabel,
            weightLabel,
        ])
        stack.translatesAutoresizingMaskIntoConstraints = false

        stack.axis = .vertical
        stack.alignment = .leading
        stack.spacing = LayoutMetrics.stackSpacing

        return stack
    }()

    private lazy var loadingIndicatorView: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(style: .medium)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.hidesWhenStopped = true

        return view
    }()

    // MARK: - View lifecycle

    override func addSubviews() {
        addSubview(stackView)
        addSubview(loadingIndicatorView)
    }

    override func constrainSubviews() {
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: LayoutMetrics.cellMargin),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -LayoutMetrics.cellMargin),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: LayoutMetrics.cellMargin),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: LayoutMetrics.cellMargin),

            loadingIndicatorView.centerXAnchor.constraint(equalTo: centerXAnchor),
            loadingIndicatorView.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
    }

    // MARK: - Cell Setup

    func setup(pokemon: Pokemon?) {
        if let pokemon = pokemon {
            loadingIndicatorView.stopAnimating()
            stackView.isHidden = false

            idLabel.text = String(pokemon.id)
            nameLabel.text = pokemon.name
            heightLabel.text = String(pokemon.height)
            weightLabel.text = String(pokemon.weight)
        } else {
            stackView.isHidden = true
            loadingIndicatorView.startAnimating()
        }
    }
}

extension PokemonTableViewCell {
    private enum LayoutMetrics {
        static let stackSpacing: CGFloat = 2
        static let cellMargin: CGFloat = 8
    }
}
