import UIKit

final class TransactionViewController: UIViewController {

    private lazy var viewModel: TransactionViewModelType = TransactionViewModel()
    private lazy var activityView = UIActivityIndicatorView(style: .large)

    @IBOutlet private weak var navBarButtonItem: UIBarButtonItem! {
        didSet {
            navBarButtonItem.title = "editButtonTitle".localized
        }
    }
    @IBOutlet private weak var deleteButton: UIButton! {
        didSet {
            deleteButton.setTitle("deleteButtonTitle".localized, for: .normal)
        }
    }
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var deleteButtonHeightConstraint: NSLayoutConstraint!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupTableView()
        updateDeleteButtonView()
        getTransactions()
    }

    @IBAction private func navBarButtonTapped(_ sender: Any) {
        navigationBarButtonTapped()
    }

    @IBAction private func deleteButtonTapped(_ sender: Any) {
        deleteButtonTapped()
    }
}

//MARK: TableView Delegate
extension TransactionViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfRowsInSection
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.reuseIdentifier, for: indexPath) as? TransactionTableViewCell else {
            fatalError("Cell not setup correctly")
        }
        let transaction = viewModel.transactions[indexPath.row]
        cell.configure(transaction)
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.selectItemToDelete(indexPath)
    }

    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        viewModel.deSelectItem(indexPath)
    }
}

//MARK: private extension
private extension TransactionViewController {
    enum Constants {
        static let nibName = "TransactionTableViewCell"
        static let reuseIdentifier = "transactions"
        static let showDeleteButtonHeight: CGFloat = 44
        static let hideDeleteButtonHeight: CGFloat = 0
    }

    func getTransactions() {
        showActivityIndicator()
        viewModel.getTransactions { [weak self] result in
            switch result {
            case.success():
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            case .failure(let error):
                print(error)
                DispatchQueue.main.async {
                    self?.showError(for: error.localizedDescription)
                }
            }

            DispatchQueue.main.async {
                self?.hideActivityIndicator()
            }
        }
    }

    func setupNavigationBar() {
        title = "transactionViewControllerTitle".localized
    }

    func setupTableView() {
        let nib = UINib(nibName: Constants.nibName, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: Constants.reuseIdentifier)
    }

    func showDeleteView() {
        deleteButtonHeightConstraint.constant = Constants.showDeleteButtonHeight
    }

    func hideDeleteView() {
        deleteButtonHeightConstraint.constant = Constants.hideDeleteButtonHeight
    }

    func updateDeleteButtonView() {
        tableView.isEditing ? showDeleteView() : hideDeleteView()
    }

    func updateNavBarButton() {
        navigationItem.rightBarButtonItem?.title = tableView.isEditing ? "doneButtonTitle".localized : "editButtonTitle".localized
    }

    func deleteButtonTapped() {
        viewModel.deleteTranscations { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }

    func navigationBarButtonTapped() {
        tableView.setEditing(!tableView.isEditing, animated: true)
        updateDeleteButtonView()
        updateNavBarButton()
        viewModel.resetTempArray()
    }

    func showActivityIndicator() {
        activityView.center = self.view.center
        self.view.addSubview(activityView)
        activityView.startAnimating()
    }

    func hideActivityIndicator() {
        activityView.stopAnimating()
        activityView.removeFromSuperview()
    }

    func showError(for error: String) {
        let alert = UIAlertController(title: "alertTitle".localized,
                                      message: error,
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "alertButtonTitle".localized,
                                      style: .default,
                                      handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
