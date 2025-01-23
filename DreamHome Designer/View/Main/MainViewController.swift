//
//  MainViewController.swift
//  DreamHomeDesigner
//
//  Created by Er Baghdasaryan on 23.01.25.
//

import UIKit
import DreamHomeViewModel
import SnapKit
import StoreKit

class MainViewController: BaseViewController, UICollectionViewDelegate {

    var viewModel: ViewModel?

    var collectionView: UICollectionView!
    private let bottomView = UIView()
    private let header = UILabel(text: "",
                                 textColor: .black,
                                 font: UIFont(name: "SFProText-Bold", size: 28))
    private let descriptionLabel = UILabel(text: "",
                                           textColor: .black.withAlphaComponent(0.6),
                                           font: UIFont(name: "SFProText-Semibold", size: 17))
    private let continueButton = UIButton(type: .system)
    private var currentIndex: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        makeButtonsAction()
    }

    override func setupUI() {
        super.setupUI()

        self.view.backgroundColor = UIColor(hex: "#00242C")

        self.bottomView.backgroundColor = UIColor(hex: "#00CFA5")

        header.textAlignment = .center
        header.numberOfLines = 2

        descriptionLabel.textAlignment = .center
        descriptionLabel.numberOfLines = 1

        self.continueButton.setTitle("OK", for: .normal)
        self.continueButton.setTitleColor(.white, for: .normal)
        self.continueButton.backgroundColor = UIColor(hex: "#00242C")
        self.continueButton.layer.masksToBounds = true
        self.continueButton.layer.cornerRadius = 10

        let mylayout = UICollectionViewFlowLayout()
        mylayout.itemSize = sizeForItem()
        mylayout.scrollDirection = .horizontal
        mylayout.minimumLineSpacing = 0
        mylayout.minimumInteritemSpacing = 0

        collectionView = UICollectionView(frame: .zero, collectionViewLayout: mylayout)
        setupConstraints()
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .clear

        collectionView.register(MainCell.self)
        collectionView.backgroundColor = UIColor(hex: "#00242C")
        collectionView.isScrollEnabled = false
    }

    override func setupViewModel() {
        super.setupViewModel()
        collectionView.delegate = self
        collectionView.dataSource = self
        viewModel?.loadData()
    }

    func sizeForItem() -> CGSize {
        let deviceType = UIDevice.currentDeviceType

        switch deviceType {
        case .iPhone:
            let width = self.view.frame.size.width
            let heightt = self.view.frame.size.height - 300
            return CGSize(width: width, height: heightt)
        case .iPad:
            let scaleFactor: CGFloat = 1.5
            let width = 550 * scaleFactor
            let height = 1100 * scaleFactor
            return CGSize(width: width, height: height)
        }
    }

    func setupConstraints() {
        self.view.addSubview(bottomView)
        self.view.addSubview(collectionView)
        self.view.addSubview(header)
        self.view.addSubview(descriptionLabel)
        self.view.addSubview(continueButton)

        bottomView.snp.makeConstraints { view in
            view.bottom.equalToSuperview()
            view.leading.equalToSuperview()
            view.trailing.equalToSuperview()
            view.height.equalTo(238)
        }

        collectionView.snp.makeConstraints { view in
            view.top.equalToSuperview()
            view.leading.equalToSuperview()
            view.trailing.equalToSuperview()
            view.bottom.equalTo(bottomView.snp.top)
        }

        header.snp.makeConstraints { view in
            view.top.equalTo(bottomView.snp.top).offset(32)
            view.leading.equalToSuperview().offset(16)
            view.trailing.equalToSuperview().inset(16)
            view.height.equalTo(68)
        }

        descriptionLabel.snp.makeConstraints { view in
            view.top.equalTo(header.snp.bottom).offset(8)
            view.leading.equalToSuperview().offset(16)
            view.trailing.equalToSuperview().inset(16)
            view.height.equalTo(22)
        }

        continueButton.snp.makeConstraints { view in
            view.bottom.equalToSuperview().inset(48)
            view.leading.equalToSuperview().offset(16)
            view.trailing.equalToSuperview().inset(16)
            view.height.equalTo(38)
        }
    }

}

//MARK: Make buttons actions
extension MainViewController {
    
    private func makeButtonsAction() {
        continueButton.addTarget(self, action: #selector(continueButtonTaped), for: .touchUpInside)
    }

    private func rateUs() {
        if #available(iOS 14.0, *) {
            SKStoreReviewController.requestReview()
        } else {
            let alertController = UIAlertController(
                title: "Enjoying the app?",
                message: "Please consider leaving us a review in the App Store!",
                preferredStyle: .alert
            )
            alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            alertController.addAction(UIAlertAction(title: "Go to App Store", style: .default) { _ in
                if let appStoreURL = URL(string: "https://apps.apple.com/us/app/dreamhome-designer/id6738329120") {
                    UIApplication.shared.open(appStoreURL, options: [:], completionHandler: nil)
                }
            })
            present(alertController, animated: true, completion: nil)
        }
    }

    @objc func continueButtonTaped() {
        guard let navigationController = self.navigationController else { return }

        let numberOfItems = self.collectionView.numberOfItems(inSection: 0)
        let nextRow = self.currentIndex + 1

        if nextRow < numberOfItems {
            let nextIndexPath = IndexPath(item: nextRow, section: 0)
            self.collectionView.scrollToItem(at: nextIndexPath, at: .centeredHorizontally, animated: true)
            self.currentIndex = nextRow
            rateUs()
        } else {
            MainRouter.showFeatureViewController(in: navigationController)
        }
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let visibleItems = collectionView.indexPathsForVisibleItems.sorted()
        if let visibleItem = visibleItems.first {
            currentIndex = visibleItem.item
        }
    }
}

extension MainViewController: IViewModelableController {
    typealias ViewModel = IMainViewModel
}

extension MainViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.viewModel?.mainItems.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: MainCell = collectionView.dequeueReusableCell(for: indexPath)
        descriptionLabel.text = viewModel?.mainItems[indexPath.row].description
        header.text = viewModel?.mainItems[indexPath.row].header
        cell.setup(image: viewModel?.mainItems[indexPath.row].image ?? "")
        return cell
    }
}

//MARK: Preview
import SwiftUI

struct MainViewControllerProvider: PreviewProvider {

    static var previews: some View {
        ContainerView().edgesIgnoringSafeArea(.all)
    }

    struct ContainerView: UIViewControllerRepresentable {
        let mainViewController = MainViewController()

        func makeUIViewController(context: UIViewControllerRepresentableContext<MainViewControllerProvider.ContainerView>) -> MainViewController {
            return mainViewController
        }

        func updateUIViewController(_ uiViewController: MainViewControllerProvider.ContainerView.UIViewControllerType, context: UIViewControllerRepresentableContext<MainViewControllerProvider.ContainerView>) {
        }
    }
}
