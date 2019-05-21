//
//  ProductDetailVC.swift
//  Assignment
//
//  Created by Kanika on 11/05/19.
//  Copyright © 2019 Kanika. All rights reserved.
//

import UIKit
import GooglePlaces
import GoogleMaps

class ProductDetailVC: UIViewController {
    
    let mapView = GMSMapView()
    let deliveryView = UIView()
    let deliveryImageView = UIImageView()
    let deliveryDescription = UITextView()
    let zoomLevel: Float = 15.0
    var detailViewModel: ProductDetailViewModel?
        
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    func setup() {
        navigationController?.setNavigationBarHidden(false, animated: false)
        title = Constant.ViewControllerTitle.detailVCTitle
        view.backgroundColor = .white
        mapViewSetup()
        deliveryViewSetup()
        showProductdetail()
    }
    
    func mapViewSetup() {
        view.addSubview(mapView)
        mapView.frame = view.bounds
        view = mapView
    }
    
    func deliveryViewSetup() {
        view.addSubview(deliveryView)
        deliveryView.backgroundColor = .white
        deliveryView.translatesAutoresizingMaskIntoConstraints = false
        deliveryDescription.translatesAutoresizingMaskIntoConstraints = false
        deliveryImageView.translatesAutoresizingMaskIntoConstraints = false
        deliveryImageView.contentMode = .scaleAspectFill
        deliveryImageView.clipsToBounds = true
        deliveryDescription.isEditable = false
        deliveryView.setLeadingConstraint(secondView: view, constant: Constant.Dimension.spacing.rawValue )
        deliveryView.setTrailingConstraint(secondView: view, constant: -Constant.Dimension.spacing.rawValue)
        deliveryView.setBottomConstraint(secondView: view, constant: -Constant.Dimension.spacing.rawValue)
        deliveryView.setBorder(color: .black)
        deliveryView.addSubview(deliveryImageView)
        deliveryView.addSubview(deliveryDescription)
        deliveryImageView.setTopConstraint(secondView: deliveryView, constant: Constant.Dimension.spacing.rawValue)
        deliveryImageView.setLeadingConstraint(secondView: deliveryView, constant: Constant.Dimension.spacing.rawValue)
        deliveryImageView.setWidthConstraint(constant: Constant.Dimension.imageHieghtWidth.rawValue)
        deliveryImageView.setHeight(constant: Constant.Dimension.imageHieghtWidth.rawValue)
        deliveryDescription.setTopConstraint(secondView: deliveryView, constant: Constant.Dimension.spacing.rawValue)
        deliveryDescription.setLeadingWithTrailingConstraint(secondView: deliveryImageView, constant: Constant.Dimension.spacing.rawValue)
        deliveryDescription.setTrailingConstraint(secondView: deliveryView, constant: -Constant.Dimension.spacing.rawValue)
        deliveryDescription.setBottomConstraint(secondView: deliveryView, constant: -Constant.Dimension.spacing.rawValue)
        deliveryDescription.font = UIFont.systemFont(ofSize: Constant.fontSize)
    }
    
    func showProductdetail() {
        if let detailViewModel = detailViewModel {
            mapView.clear()
            let camera = GMSCameraPosition.camera(withLatitude: detailViewModel.product.location?.lattitude ?? 0, longitude: detailViewModel.product.location?.longitude ?? 0, zoom: zoomLevel)
            mapView.camera = camera
            let marker = GMSMarker()
            marker.position = CLLocationCoordinate2D(latitude: detailViewModel.product.location?.lattitude ?? 0, longitude: detailViewModel.product.location?.longitude ?? 0)
            marker.title = detailViewModel.product.location?.address ?? ""
            marker.snippet = ""
            marker.map = mapView
            let imgURL = URL(string: detailViewModel.product.imageURL ?? "")
            deliveryImageView.sd_setImage(with: imgURL, placeholderImage: Constant.errorIcon, options: [], progress: nil, completed: nil)

            if let address = detailViewModel.product.location?.address {
                deliveryDescription.text = "\(detailViewModel.product.description ?? "") at \(address)"
                
            } else {
                deliveryDescription.text = detailViewModel.product.description
            }
            let textViewHeight = deliveryDescription.contentSize.height
            if textViewHeight > view.bounds.height / 2 {
                deliveryView.setHeight(constant: view.bounds.height / 2)
            } else if textViewHeight < Constant.Dimension.deliveryDetailViewHeight.rawValue {
                deliveryView.setHeight(constant: Constant.Dimension.deliveryDetailViewHeight.rawValue)
            } else {
                deliveryView.setHeight(constant: textViewHeight)
            }
            
        }
    }
    
}
