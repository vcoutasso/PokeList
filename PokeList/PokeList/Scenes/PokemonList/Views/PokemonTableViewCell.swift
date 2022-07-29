import Foundation
import UIKit

final class PokemonTableViewCell: CodedTableViewCell, ReusableView {
    // MARK: - Subviews

    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()

    private lazy var loadingIndicatorView: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(style: .medium)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.hidesWhenStopped = true

        return view
    }()

    // MARK: - Properties

    private(set) var isLoading: Bool = true {
        didSet {
            isLoading ? loadingIndicatorView.startAnimating() : loadingIndicatorView.stopAnimating()
            nameLabel.isHidden = isLoading
        }
    }

    // MARK: - View lifecycle

    override func addSubviews() {
        contentView.addSubview(nameLabel)
        contentView.addSubview(loadingIndicatorView)
    }

    override func constrainSubviews() {
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: topAnchor, constant: LayoutMetrics.cellMargin),
            nameLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -LayoutMetrics.cellMargin),
            nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: LayoutMetrics.cellMargin),
            nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: LayoutMetrics.cellMargin),

            loadingIndicatorView.centerXAnchor.constraint(equalTo: centerXAnchor),
            loadingIndicatorView.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
    }

    // MARK: - Cell Setup

    func setup(pokemon: Pokemon?) {
        if let pokemon = pokemon {
            nameLabel.text = pokemon.name

            isLoading = false
        } else {
            isLoading = true
        }
    }
}

extension PokemonTableViewCell {
    private enum LayoutMetrics {
        static let cellMargin: CGFloat = 8
    }
}
