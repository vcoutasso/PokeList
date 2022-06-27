import Foundation

protocol CodedViewLifecycle {
    func addSubviews()
    func constrainSubviews()
}

extension CodedViewLifecycle {
    func setupView() {
        addSubviews()
        constrainSubviews()
    }
}
