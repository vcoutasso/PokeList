import UIKit

class CodedView: UIView, CodedViewLifecycle {
    // MARK: - Initialization

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.translatesAutoresizingMaskIntoConstraints = false
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
