import Foundation
import UIKit

class CodedTableViewCell: UITableViewCell, CodedViewLifecycle {
    // MARK: - Initialization

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Coded view lifecycle

    func addSubviews() {
        fatalError("Default implementation not provided")
    }

    func constrainSubviews() {
        fatalError("Default implementation not provided")
    }

    // MARK: - Helper methods

    private func setupView() {
        addSubviews()
        constrainSubviews()
    }
}
