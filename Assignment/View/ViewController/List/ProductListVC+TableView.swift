//
//  ProductListVC+TableView.swift
//  Assignment
//
//  Created by Kanika on 11/05/19.
//  Copyright © 2019 Kanika. All rights reserved.
//

import Foundation
import UIKit
import SDWebImage

extension ProductListVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return productListViewModel.products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constant.CellIdentifier.listCell) as! ProductListCell
        cell.backgroundColor = .clear
        let product = productListViewModel.products[indexPath.row]
        let imgURL = URL(string: product.imageURL ?? "")
        cell.productImageView.sd_setImage(with: imgURL, placeholderImage: Constant.errorIcon, options: [], progress: nil, completed: nil)
        if let address = product.location?.address {
            cell.descLabel.text = product.description ?? "" + address

        } else {
            cell.descLabel.text = product.description
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let product = productListViewModel.products[indexPath.row]
        gotoDetailPage(product: product)
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let height = scrollView.frame.size.height
        let contentYoffset = scrollView.contentOffset.y
        let distanceFromBottom = scrollView.contentSize.height - contentYoffset
        if distanceFromBottom < height {
            getProductList()
        }
    }
    
}

