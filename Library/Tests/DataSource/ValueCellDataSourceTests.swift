import XCTest
import Library
import UIKit

internal final class IntTableCell: UITableViewCell, ValueCell {
  internal var value: Int = 0
  internal func configureWith(value value: Int) {
    self.value = value
  }
}

internal final class IntCollectionCell: UICollectionViewCell, ValueCell {
  internal var value: Int = 0
  internal func configureWith(value value: Int) {
    self.value = value
  }
}

internal final class IntDataSource: ValueCellDataSource {
  internal override func registerClasses(tableView tableView: UITableView?) {
    tableView?.registerCellClass(IntTableCell.self)
  }

  internal override func registerClasses(collectionView collectionView: UICollectionView?) {
    collectionView?.registerCellClass(IntCollectionCell.self)
  }
}

internal final class ValueCellDataSourceTests: XCTestCase {
  private let dataSource = IntDataSource()
  private let tableView = UITableView()
  private let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())

  override func setUp() {
    super.setUp()

    dataSource.registerClasses(tableView: tableView)
    dataSource.registerClasses(collectionView: collectionView)

    dataSource.appendRow(value: 1, cellClass: IntTableCell.self, toSection: 0)
    dataSource.appendRow(value: 2, cellClass: IntTableCell.self, toSection: 0)
    dataSource.appendSection(values: [1, 2, 3], cellClass: IntTableCell.self)
    dataSource.set(values: [1, 2, 3], cellClass: IntTableCell.self, inSection: 5)
  }

  func testTableViewDataSourceMethods() {
    XCTAssertEqual(6, dataSource.numberOfSectionsInTableView(tableView))
    XCTAssertEqual(2, dataSource.tableView(tableView, numberOfRowsInSection: 0))
    XCTAssertEqual(3, dataSource.tableView(tableView, numberOfRowsInSection: 1))
    XCTAssertEqual(0, dataSource.tableView(tableView, numberOfRowsInSection: 2))
    XCTAssertEqual(0, dataSource.tableView(tableView, numberOfRowsInSection: 3))
    XCTAssertEqual(0, dataSource.tableView(tableView, numberOfRowsInSection: 4))
    XCTAssertEqual(3, dataSource.tableView(tableView, numberOfRowsInSection: 5))
  }

  func testCollectionViewDataSourceMethods() {
    XCTAssertEqual(6, dataSource.numberOfSectionsInCollectionView(collectionView))
    XCTAssertEqual(2, dataSource.collectionView(collectionView, numberOfItemsInSection: 0))
    XCTAssertEqual(3, dataSource.collectionView(collectionView, numberOfItemsInSection: 1))
    XCTAssertEqual(0, dataSource.collectionView(collectionView, numberOfItemsInSection: 2))
    XCTAssertEqual(0, dataSource.collectionView(collectionView, numberOfItemsInSection: 3))
    XCTAssertEqual(0, dataSource.collectionView(collectionView, numberOfItemsInSection: 4))
    XCTAssertEqual(3, dataSource.collectionView(collectionView, numberOfItemsInSection: 5))
  }

  func testSubscript_IndexPath() {
    XCTAssertEqual(1, dataSource[NSIndexPath(forItem: 0, inSection: 0)] as? Int)
    XCTAssertEqual(2, dataSource[NSIndexPath(forItem: 1, inSection: 0)] as? Int)
    XCTAssertEqual(1, dataSource[NSIndexPath(forItem: 0, inSection: 1)] as? Int)
    XCTAssertEqual(2, dataSource[NSIndexPath(forItem: 1, inSection: 1)] as? Int)
    XCTAssertEqual(3, dataSource[NSIndexPath(forItem: 2, inSection: 1)] as? Int)
    XCTAssertEqual(1, dataSource[NSIndexPath(forItem: 0, inSection: 5)] as? Int)
    XCTAssertEqual(2, dataSource[NSIndexPath(forItem: 1, inSection: 5)] as? Int)
    XCTAssertEqual(3, dataSource[NSIndexPath(forItem: 2, inSection: 5)] as? Int)
  }

  func testSubscript_ItemSection() {
    XCTAssertEqual(1, dataSource[itemSection: (0, 0)] as? Int)
    XCTAssertEqual(2, dataSource[itemSection: (1, 0)] as? Int)
    XCTAssertEqual(1, dataSource[itemSection: (0, 1)] as? Int)
    XCTAssertEqual(2, dataSource[itemSection: (1, 1)] as? Int)
    XCTAssertEqual(3, dataSource[itemSection: (2, 1)] as? Int)
    XCTAssertEqual(1, dataSource[itemSection: (0, 5)] as? Int)
    XCTAssertEqual(2, dataSource[itemSection: (1, 5)] as? Int)
    XCTAssertEqual(3, dataSource[itemSection: (2, 5)] as? Int)
  }

  func testNumberOfItems() {
    XCTAssertEqual(8, dataSource.numberOfItems())
  }

  func testItemAtIndex() {
    XCTAssertEqual(0, dataSource.itemIndexAt(NSIndexPath(forItem: 0, inSection: 0)))
    XCTAssertEqual(1, dataSource.itemIndexAt(NSIndexPath(forItem: 1, inSection: 0)))
    XCTAssertEqual(2, dataSource.itemIndexAt(NSIndexPath(forItem: 0, inSection: 1)))
    XCTAssertEqual(3, dataSource.itemIndexAt(NSIndexPath(forItem: 1, inSection: 1)))
    XCTAssertEqual(4, dataSource.itemIndexAt(NSIndexPath(forItem: 2, inSection: 1)))
    XCTAssertEqual(5, dataSource.itemIndexAt(NSIndexPath(forItem: 0, inSection: 5)))
    XCTAssertEqual(6, dataSource.itemIndexAt(NSIndexPath(forItem: 1, inSection: 5)))
    XCTAssertEqual(7, dataSource.itemIndexAt(NSIndexPath(forItem: 2, inSection: 5)))
  }

  func testClearValues() {
    dataSource.clearValues()
    XCTAssertEqual(0, dataSource.numberOfItems())
  }
}
