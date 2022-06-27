import UIKit

protocol TableViewAdapter: UITableViewDataSource, UITableViewDelegate, UITableViewDataSourcePrefetching {
    associatedtype DataType: PokeApiData

    var dataItems: [DataType] { get }
    var prefetchRequest: (() -> Void)? { get }

    func populateAndGetIndexPathsToReload(with newData: [DataType], totalItemCount: Int) -> [IndexPath]?
    func registerPrefetchCallback(_ callback: @escaping () -> Void)
    func visibleIndexPathsToReload(_ tableView: UITableView, intersecting indexPaths: [IndexPath]) -> [IndexPath]
}
