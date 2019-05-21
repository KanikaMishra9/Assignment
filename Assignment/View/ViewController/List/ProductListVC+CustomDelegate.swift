//
//  ProductListVC+CustomDelegate.swift
//  Assignment
//
//  Created by Kanika on 12/05/19.
//  Copyright © 2019 Kanika. All rights reserved.
//

import Foundation
import UIKit

extension ProductListVC: ProductListViewModelDelegate {
    
    func showMiddleLoader() {
        showLoader()
    }
    
    func showBottomLoader() {
        showTableViewBottomLoader()
    }
    
    func errorOccured(errorMessage: String) {
        showAlert(title: Constant.errorTitle, message: errorMessage)
    }
    
    func refreshData() {
        listTableView.reloadData()
    }
    
    func hideTopLoader() {
        endRefreshing()
    }
    
    func hideMiddleLoader() {
        hideLoader()
    }
    
    func hideBottomLoader() {
        hideTableViewBottomLoader()
    }
    
}
