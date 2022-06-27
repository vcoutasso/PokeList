import UIKit

final class TableViewSpy: UITableView {
    private(set) var reloadDataCalled = false
    override func reloadData() {
        reloadDataCalled = true
    }

    private(set) var reloadRowsCalled = false
    override func reloadRows(at indexPaths: [IndexPath], with animation: UITableView.RowAnimation) {
        reloadRowsCalled = true
    }
}
