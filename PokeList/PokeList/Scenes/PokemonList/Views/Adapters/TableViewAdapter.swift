import UIKit

protocol TableViewAdapter: UITableViewDataSource, UITableViewDelegate, UITableViewDataSourcePrefetching {
    associatedtype DataWrapper: PokeApiData
    associatedtype DisplayLogicWrapper

    var dataItems: [DataWrapper] { get }
    var prefetchRequest: (() -> Void)? { get }

    func populateAndGetIndexPathsToReload(with newData: [DataWrapper], totalItemCount: Int) -> [IndexPath]?
    func registerPrefetchCallback(_ callback: @escaping () -> Void)
    func visibleIndexPathsToReload(_ tableView: UITableView, intersecting indexPaths: [IndexPath]) -> [IndexPath]

    func registerDisplayLogicDelegate(_ delegate: DisplayLogicWrapper)
}
