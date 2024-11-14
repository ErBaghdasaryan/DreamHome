//
//  PasswordsViewController.swift
//  DreamHome Designer
//
//  Created by Er Baghdasaryan on 12.11.24.
//

import UIKit
import DreamHomeViewModel
import SnapKit

class PasswordsViewController: BaseViewController {

    var viewModel: ViewModel?

    private let header = UILabel(text: "Passwords list",
                                 textColor: .white,
                                 font: UIFont(name: "SFProText-Bold", size: 28))
    private let searchBar = UISearchBar()
    private let tableView = UITableView(frame: .zero, style: .grouped)
    private let addNew = UIButton(type: .system)

    override func viewDidLoad() {
        super.viewDidLoad()
        makeButtonsAction()
        setupTableView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.viewModel?.loadData()
        self.tableView.reloadData()
    }

    override func setupUI() {
        super.setupUI()

        self.view.backgroundColor = UIColor(hex: "#00242C")

        searchBar.placeholder = "search_placeholder" .localized
        if let textField = searchBar.value(forKey: "searchField") as? UITextField {
            textField.attributedPlaceholder = NSAttributedString(string: "Search",
                                                                 attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        }
        searchBar.searchTextField.textColor = .white
        searchBar.searchTextField.backgroundColor = .lightGray
        searchBar.barTintColor = UIColor(hex: "#00242C")
        searchBar.layer.masksToBounds = true
        searchBar.isTranslucent = true
        searchBar.delegate = self
        if let textField = searchBar.value(forKey: "searchField") as? UITextField,
           let leftView = textField.leftView as? UIImageView {
            leftView.image = leftView.image?.withRenderingMode(.alwaysTemplate)
            leftView.tintColor = .white
        }

        self.addNew.setTitle("Add new collection", for: .normal)
        self.addNew.setTitleColor(.white, for: .normal)
        self.addNew.backgroundColor = UIColor(hex: "#FF2300")
        self.addNew.layer.masksToBounds = true
        self.addNew.layer.cornerRadius = 19

        self.tableView.backgroundColor = .clear
        self.tableView.separatorStyle = .none
        self.tableView.allowsSelection = true

        self.view.addSubview(header)
        self.view.addSubview(searchBar)
        self.view.addSubview(tableView)
        self.view.addSubview(addNew)
        self.setupConstraints()
    }

    override func setupViewModel() {
        super.setupViewModel()
        self.viewModel?.loadData()
        self.tableView.reloadData()
    }

    private func setupConstraints() {
        header.snp.makeConstraints { view in
            view.top.equalToSuperview().offset(64)
            view.leading.equalToSuperview().offset(16)
            view.trailing.equalToSuperview().inset(16)
            view.height.equalTo(34)
        }

        searchBar.snp.makeConstraints { view in
            view.top.equalTo(header.snp.bottom).offset(32)
            view.leading.equalToSuperview().offset(16)
            view.trailing.equalToSuperview().inset(16)
            view.height.equalTo(36)
        }

        tableView.snp.makeConstraints { view in
            view.top.equalTo(searchBar.snp.bottom).offset(32)
            view.leading.equalToSuperview().offset(16)
            view.trailing.equalToSuperview().inset(16)
            view.bottom.equalToSuperview()
        }

        tableView.contentInset = UIEdgeInsets(top: -25, left: 0, bottom: 0, right: 0    )

        addNew.snp.makeConstraints { view in
            view.bottom.equalToSuperview().inset(140)
            view.leading.equalToSuperview().offset(16)
            view.trailing.equalToSuperview().inset(16)
            view.height.equalTo(38)
        }
    }

    private func setupTableView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.showsVerticalScrollIndicator = false

        self.tableView.register(PasswordTableViewCell.self)
        self.tableView.register(EmptyTableViewCell.self)
    }

}

//MARK: Make buttons actions
extension PasswordsViewController {
    
    private func makeButtonsAction() {
        
    }
}

extension PasswordsViewController: IViewModelableController {
    typealias ViewModel = IPasswordsViewModel
}

//MARK: UISearchBarDelegate
extension PasswordsViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel?.filterCollection(with: searchText)
        tableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        viewModel?.filterCollection(with: "")
        tableView.reloadData()
    }
}

//MARK: TableView Delegate & Data source
extension PasswordsViewController:  UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = viewModel?.filteredCollections.count ?? 0
        return count == 0 ? 1 : count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if viewModel?.filteredCollections.isEmpty ?? true {
            let cell: EmptyTableViewCell = tableView.dequeueReusableCell(for: indexPath)
            return cell
        } else {
            let cell: PasswordTableViewCell = tableView.dequeueReusableCell(for: indexPath)
            if let model = viewModel?.filteredCollections[indexPath.row] {
                cell.setup(with: model)
            }
            return cell
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if viewModel?.filteredCollections.isEmpty ?? true {
            return 88
        } else {
            return 58
        }
    }
}

//MARK: Preview
import SwiftUI

struct PasswordsViewControllerProvider: PreviewProvider {

    static var previews: some View {
        ContainerView().edgesIgnoringSafeArea(.all)
    }

    struct ContainerView: UIViewControllerRepresentable {
        let passwordsViewController = PasswordsViewController()

        func makeUIViewController(context: UIViewControllerRepresentableContext<PasswordsViewControllerProvider.ContainerView>) -> PasswordsViewController {
            return passwordsViewController
        }

        func updateUIViewController(_ uiViewController: PasswordsViewControllerProvider.ContainerView.UIViewControllerType, context: UIViewControllerRepresentableContext<PasswordsViewControllerProvider.ContainerView>) {
        }
    }
}
