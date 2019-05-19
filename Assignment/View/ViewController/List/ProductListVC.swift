//
//  ProductListVC.swift
//  Assignment
//
//  Created by Kanika on 10/05/19.
//  Copyright © 2019 Kanika. All rights reserved.
//

import UIKit

class ProductListVC: UIViewController {
    
    enum RefreshStatusMessege: String {
        case started = "refreshing..."
        case ended = "pull to refresh..."
    }
    
    var listTableView = UITableView()
    let productListViewModel = ProductListViewModel()
    let refreshControl = UIRefreshControl()
    let activityIndicator = UIActivityIndicatorView(style: .gray)
    let errorTitle = "Error"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        addRefreshControl()
        getProductList()
    }
    
    // MARK: UI Update
    
    func setup() {
        navigationController?.setNavigationBarHidden(false, animated: false)
        title = Constant.ViewControllerTitle.listVCTitle
        view.backgroundColor = .white
        listTableView.frame = view.bounds
        view.addSubview(listTableView)
        listTableView.backgroundColor = .white
        listTableView.register(ProductListCell.self, forCellReuseIdentifier: Constant.CellIdentifier.listCell)
        listTableView.delegate = self
        listTableView.dataSource = self
        listTableView.separatorStyle = .singleLine
        listTableView.separatorInset = .zero
        listTableView.translatesAutoresizingMaskIntoConstraints = false
        listTableView.setTopConstraint(secondView: view, constant: Constant.Dimension.zeroSpacing.rawValue)
        listTableView.setLeadingConstraint(secondView: view, constant: Constant.Dimension.zeroSpacing.rawValue)
        listTableView.setTrailingConstraint(secondView: view, constant: Constant.Dimension.zeroSpacing.rawValue)
        listTableView.setBottomConstraint(secondView: view, constant: Constant.Dimension.zeroSpacing.rawValue)
        listTableView.tableFooterView = UIView()
        productListViewModel.delegate = self
    }
    
    func addRefreshControl() {
        refreshControl.attributedTitle = NSAttributedString(string: RefreshStatusMessege.started.rawValue)
        refreshControl.addTarget(self, action: #selector(refreshList), for: .valueChanged)
        listTableView.addSubview(refreshControl)
    }
    
    @objc
    func refreshList() {
        productListViewModel.refreshList()
    }
    
    func endRefreshing() {
        refreshControl.endRefreshing()
        refreshControl.attributedTitle = NSAttributedString(string: RefreshStatusMessege.ended.rawValue)
    }
    
    func showTableViewBottomLoader() {
        activityIndicator.startAnimating()
        activityIndicator.frame = CGRect(x: 0, y: 0, width: listTableView.bounds.width, height: Constant.Dimension.height.rawValue)
        listTableView.tableFooterView = activityIndicator
        listTableView.tableFooterView?.isHidden = false
    }
    
    func hideTableViewBottomLoader() {
        activityIndicator.stopAnimating()
        listTableView.tableFooterView = UIView()
    }
    
    // MARK: Get Data
    
    func getProductList() {
        productListViewModel.getProductList()
    }
    
    // MARK: Navigation
    
    func gotoDetailPage(product: Product) {
        let detailVC = ProductDetailVC()
        let detailViewModel = ProductDetailViewModel(product: product)
        detailVC.detailViewModel = detailViewModel
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
}
