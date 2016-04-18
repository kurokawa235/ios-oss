import Library
import UIKit
import Models

internal final class ProjectViewController: UITableViewController {
  private let viewModel: ProjectViewModelType = ProjectViewModel()
  private let dataSource = ProjectDataSource()

  internal func configureWith(project project: Project) {
    self.viewModel.inputs.project(project)
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    self.tableView.dataSource = dataSource
  }

  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)
    self.viewModel.inputs.viewWillAppear()
  }

  override func bindViewModel() {
    super.bindViewModel()

    self.viewModel.outputs.project
      .observeForUI()
      .observeNext { [dataSource, weak tableView] project in
        dataSource.loadProject(project)
        tableView?.reloadData()
    }
  }

  override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    return 32.0
  }

  override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    let view = UIView()
    view.backgroundColor = .clearColor()
    return view
  }

  override func tableView(tableView: UITableView,
                          estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
    return UITableViewAutomaticDimension
  }
}
