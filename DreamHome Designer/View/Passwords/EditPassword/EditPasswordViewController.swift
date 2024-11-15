//
//  EditPasswordViewController.swift
//  DreamHome Designer
//
//  Created by Er Baghdasaryan on 15.11.24.
//

import UIKit
import DreamHomeViewModel
import SnapKit

class EditPasswordViewController: BaseViewController {

    var viewModel: ViewModel?

    private let backButton = UIButton(type: .system)
    private let header = UILabel(text: "",
                                 textColor: .white,
                                 font: UIFont(name: "SFProText-Bold", size: 28))
    private let editButton = UIButton(type: .system)

    private var passwords: [String] = []
    private let tableView = UITableView(frame: .zero, style: .grouped)

    private let addNew = UIButton(type: .system)

    var visualEffectView: UIVisualEffectView?

    override func viewDidLoad() {
        super.viewDidLoad()
        makeButtonActions()
        setupTableView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard let model = self.viewModel?.collection else { return }

        self.header.text = model.name
    }

    override func setupUI() {
        super.setupUI()

        self.view.backgroundColor = UIColor(hex: "#00242C")

        self.backButton.setImage(UIImage(named: "backButton"), for: .normal)
        self.editButton.setImage(UIImage(named: "editButton"), for: .normal)
        self.header.textAlignment = .left

        self.addNew.setTitle("Add new password", for: .normal)
        self.addNew.setTitleColor(.white, for: .normal)
        self.addNew.backgroundColor = UIColor(hex: "#FF2300")
        self.addNew.layer.masksToBounds = true
        self.addNew.layer.cornerRadius = 19

        self.tableView.backgroundColor = .clear
        self.tableView.separatorStyle = .none
        self.tableView.allowsSelection = true

        self.view.addSubview(backButton)
        self.view.addSubview(header)
        self.view.addSubview(editButton)
        self.view.addSubview(tableView)
        self.view.addSubview(addNew)
        setupConstraints()
    }

    override func setupViewModel() {
        super.setupViewModel()
        guard let model = self.viewModel?.collection else { return }
        self.passwords = model.passwords
        self.tableView.reloadData()
    }

    func setupConstraints() {
        backButton.snp.makeConstraints { view in
            view.top.equalToSuperview().offset(65)
            view.leading.equalToSuperview().offset(16)
            view.height.equalTo(32)
            view.width.equalTo(32)
        }

        header.snp.makeConstraints { view in
            view.top.equalToSuperview().offset(65)
            view.leading.equalTo(backButton.snp.trailing).offset(8)
            view.trailing.equalToSuperview().inset(56)
            view.height.equalTo(34)
        }

        editButton.snp.makeConstraints { view in
            view.top.equalToSuperview().offset(65)
            view.trailing.equalToSuperview().inset(16)
            view.height.equalTo(32)
            view.width.equalTo(32)
        }

        tableView.snp.makeConstraints { view in
            view.top.equalTo(header.snp.bottom).offset(32)
            view.leading.equalToSuperview().offset(16)
            view.trailing.equalToSuperview().inset(16)
            view.bottom.equalToSuperview()
        }

        tableView.contentInset = UIEdgeInsets(top: -25, left: 0, bottom: 0, right: 0    )

        addNew.snp.makeConstraints { view in
            view.bottom.equalToSuperview().inset(125)
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


extension EditPasswordViewController: IViewModelableController {
    typealias ViewModel = IEditPasswordViewModel
}

//MARK: Progress View
extension EditPasswordViewController {
    private func makeButtonActions() {
        backButton.addTarget(self, action: #selector(backTapped), for: .touchUpInside)
        addNew.addTarget(self, action: #selector(addPassword), for: .touchUpInside)
        editButton.addTarget(self, action: #selector(editCollection), for: .touchUpInside)
    }

    @objc func editCollection() {
        guard let navigationController = self.navigationController else { return }
        guard let id = self.viewModel?.collection.id else { return }
        guard let name = self.viewModel?.collection.name else { return }

        self.viewModel?.editCollection(model: .init(id: id,
                                                    name: name,
                                                    passwords: self.passwords))
        PasswordsRouter.popViewController(in: navigationController)
    }

    @objc func backTapped() {
        guard let navigationController = self.navigationController else { return }
        PasswordsRouter.popViewController(in: navigationController)
    }

    @objc func addPassword() {
        let blurEffect = UIBlurEffect(style: .light)
        visualEffectView = UIVisualEffectView(effect: blurEffect)
        visualEffectView?.frame = self.view.bounds

        guard let visualEffectView = visualEffectView else { return }
        self.view.addSubview(visualEffectView)

        let dimmingView = UIView(frame: self.view.bounds)
        dimmingView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        self.view.addSubview(dimmingView)

        visualEffectView.alpha = 0
        dimmingView.alpha = 0

        UIView.animate(withDuration: 0.1) {
            visualEffectView.alpha = 1
            dimmingView.alpha = 1
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.tabBarController?.tabBar.isHidden = true
            _ = AddPasswordView.createAndShow(in: self,
                                                delegate: { [weak self] name in
                guard let self = self else { return }
                self.passwords.append(name)
                UIView.animate(withDuration: 0, animations: {
                    visualEffectView.alpha = 0
                    dimmingView.alpha = 0
                }) { _ in
                    visualEffectView.removeFromSuperview()
                    dimmingView.removeFromSuperview()
                    self.tabBarController?.tabBar.isHidden = false
                    self.tableView.reloadData()
                }
            }, cancelDelegate: {
                UIView.animate(withDuration: 0, animations: {
                    visualEffectView.alpha = 0
                    dimmingView.alpha = 0
                }) { _ in
                    visualEffectView.removeFromSuperview()
                    dimmingView.removeFromSuperview()
                    self.tabBarController?.tabBar.isHidden = false
                }
            })
        }
    }

    @objc func deletePassword(from index: Int) {

        self.passwords.remove(at: index)
        self.tableView.reloadData()
    }

    @objc func editPassword(from index: Int) {
        let password = self.passwords[index]
        let blurEffect = UIBlurEffect(style: .light)
        visualEffectView = UIVisualEffectView(effect: blurEffect)
        visualEffectView?.frame = self.view.bounds

        guard let visualEffectView = visualEffectView else { return }
        self.view.addSubview(visualEffectView)

        let dimmingView = UIView(frame: self.view.bounds)
        dimmingView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        self.view.addSubview(dimmingView)

        visualEffectView.alpha = 0
        dimmingView.alpha = 0

        UIView.animate(withDuration: 0.1) {
            visualEffectView.alpha = 1
            dimmingView.alpha = 1
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.tabBarController?.tabBar.isHidden = true
            _ = EditPasswordView.createAndShow(in: self,
                                               password: password,
                                                delegate: { [weak self] name in
                guard let self = self else { return }
                UIView.animate(withDuration: 0, animations: {
                    visualEffectView.alpha = 0
                    dimmingView.alpha = 0
                }) { _ in
                    visualEffectView.removeFromSuperview()
                    dimmingView.removeFromSuperview()
                    self.tabBarController?.tabBar.isHidden = false
                    self.passwords[index] = name
                    self.tableView.reloadData()
                }
            }, cancelDelegate: {
                UIView.animate(withDuration: 0, animations: {
                    visualEffectView.alpha = 0
                    dimmingView.alpha = 0
                }) { _ in
                    visualEffectView.removeFromSuperview()
                    dimmingView.removeFromSuperview()
                    self.tabBarController?.tabBar.isHidden = false
                }
            })
        }
    }
}

//MARK: TableView Delegate & Data source
extension EditPasswordViewController:  UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.passwords.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if self.passwords.isEmpty {
            let cell: EmptyTableViewCell = tableView.dequeueReusableCell(for: indexPath)
            return cell
        } else {
            let cell: PasswordTableViewCell = tableView.dequeueReusableCell(for: indexPath)
            let password = self.passwords[indexPath.row]
            cell.setup(with: password)

            cell.editSubject.sink { [weak self] _ in
                self?.editPassword(from: indexPath.row)
            }.store(in: &cell.cancellables)

            cell.deleteSubject.sink { [weak self] _ in
                self?.deletePassword(from: indexPath.row)
            }.store(in: &cell.cancellables)

            return cell
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if self.passwords.isEmpty {
            return 88
        } else {
            return 58
        }
    }
}

//MARK: Preview
import SwiftUI

struct EditPasswordViewControllerProvider: PreviewProvider {

    static var previews: some View {
        ContainerView().edgesIgnoringSafeArea(.all)
    }

    struct ContainerView: UIViewControllerRepresentable {
        let editPasswordViewController = EditPasswordViewController()
        
        func makeUIViewController(context: UIViewControllerRepresentableContext<EditPasswordViewControllerProvider.ContainerView>) -> EditPasswordViewController {
            return editPasswordViewController
        }

        func updateUIViewController(_ uiViewController: EditPasswordViewControllerProvider.ContainerView.UIViewControllerType, context: UIViewControllerRepresentableContext<EditPasswordViewControllerProvider.ContainerView>) {
        }
    }
}
