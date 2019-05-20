//
//  ProductListViewModel.swift
//  Assignment
//
//  Created by Kanika on 12/05/19.
//  Copyright © 2019 Kanika. All rights reserved.
//

protocol ProductListViewModelDelegate: class {
    func refreshData()
    func errorOccured(errorMessage: String)
    func showMiddleLoader()
    func showBottomLoader()
    func hideTopLoader()
    func hideMiddleLoader()
    func hideBottomLoader()
}

import Foundation

class ProductListViewModel {
    
    enum APIKeys: String {
        case offsetKey = "offset"
        case limitKey = "limit"
    }
    
    enum ErrorMessege: String {
        case internetError = "Please check your internet connection!"
        case other = "Something went wrong."
    }
    
    var products = [Product]()
    weak var delegate: ProductListViewModelDelegate?
    var offset = 0
    var limit = 20
    var apiManager: APIManagerProtocol = APIManager()
    var coreDataManagder: CoreDataManagerProtocol = CoreDataManager()
    var isDataRefreshing = false
    
    func getProductList() {
        if isDataRefreshing == false {
            isDataRefreshing = true
            if Constant.dataSource == .dataBase {
                let productList = getProductListFromDB(offset: offset, limit: limit)
                
                if let productList = productList {
                    products += productList
                    offset = products.count
                    delegate?.refreshData()
                    isDataRefreshing = false
                } else {
                    Constant.dataSource = .server
                    getProductListFromServer(offset: offset, limit: limit)
                }
            } else {
                getProductListFromServer(offset: offset, limit: limit)
            }
        }
    }
    
    private func getProductListFromServer(offset: Int, limit: Int) {
        let parameters = [APIKeys.offsetKey.rawValue: offset, APIKeys.limitKey.rawValue: limit]
        guard ConnectivityManager.isConnectedToInternet() else {
            self.updateOnError(error: nil)
            return
        }
        if products.isEmpty {
            delegate?.showMiddleLoader()
        } else {
            if offset != 0 {
                delegate?.showBottomLoader()
            }
        }
        
        apiManager.apiGet(serviceName: Constant.baseURL + Constant.Endpoint.deliveries, parameters: parameters) { (response, error) in
            if let error = error {
                self.updateOnError(error: error)
            }
            guard let response = response else { return }
            let decoder = JSONDecoder()
            do {
                let data = try response.rawData()
                let productList = try decoder.decode(ProductList.self, from: data)
                if productList.productList.isEmpty == false {
                    self.saveDataFromServer(products: productList.productList)
                }
            } catch {
                self.delegate?.errorOccured(errorMessage: ErrorMessege.other.rawValue)
            }
        }
    }
    
    func refreshList() {
        offset = 0
        Constant.dataSource = .server
        getProductListFromServer(offset: offset, limit: limit)
    }
    
    private func saveDataFromServer(products: [Product]) {
        if offset == 0 {
            self.products.removeAll()
        }
        self.products += products
        delegate?.refreshData()
        if self.products.isEmpty == false && offset != 0 {
            delegate?.hideBottomLoader()
        } else if offset == 0 {
            delegate?.hideTopLoader()
            delegate?.hideMiddleLoader()
        }
        offset = self.products.count
        saveProductsIntoDB(products: products)
        isDataRefreshing = false
    }
    
    private func updateOnError(error: Error?) {
        self.isDataRefreshing = false
        if self.products.isEmpty == false && offset != 0 {
            self.delegate?.hideBottomLoader()
        } else if offset == 0 && self.products.isEmpty == false {
            self.delegate?.hideTopLoader()
        } else {
            self.delegate?.hideMiddleLoader()
        }
        if let error = error {
            delegate?.errorOccured(errorMessage: error.localizedDescription)
        } else {
            delegate?.errorOccured(errorMessage: ErrorMessege.internetError.rawValue)
        }
    }
    
    private func getProductListFromDB(offset: Int, limit: Int) -> [Product]? {
        let productList = coreDataManagder.fetchProducts(offset: offset, limit: limit)
        if let productList = productList {
            return productList
        }
        return nil
    }
    
    private func saveProductsIntoDB(products: [Product]) {
        coreDataManagder.insertProducts(products: products)
    }
    
}
