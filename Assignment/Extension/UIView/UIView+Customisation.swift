//
//  UIView+Customisation.swift
//  Assignment
//
//  Created by Kanika on 10/05/19.
//  Copyright © 2019 Kanika. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    
    func setBorder(color: UIColor, borderWidth: CGFloat = 1) {
        layer.borderColor = color.cgColor
        layer.borderWidth = borderWidth
    }
    
    func setTopConstraint(secondView: UIView, constant: CGFloat) {
        Constraints.topConstraint(view: self, secondView: secondView, constant: constant)
    }
    
    func setTopWithBottomConstraint(secondView: UIView, constant: CGFloat) {
        Constraints.topWithBottomConstraint(view: self, secondView: secondView, constant: constant)
    }
    
    func setBottomConstraint(secondView: UIView, constant: CGFloat) {
        Constraints.bottomConstraint(view: self, secondView: secondView, constant: constant)
    }
    
    func setLeadingConstraint(secondView: UIView, constant: CGFloat) {
        Constraints.leadingConstraint(view: self, secondView: secondView, constant: constant)
    }
    
    func setTrailingConstraint(secondView: UIView, constant: CGFloat) {
        Constraints.trailingConstraint(view: self, secondView: secondView, constant: constant)
    }
    
    func setLeadingWithTrailingConstraint(secondView: UIView, constant: CGFloat) {
        Constraints.leadingWithTrailingConstraint(view: self, secondView: secondView, constant: constant)
    }
    
    func setCenterXConstraint(secondView: UIView) {
        Constraints.centerXConstraint(view: self, secondView: secondView)
    }
    
    func setCenterYConstraint(secondView: UIView) {
        Constraints.centerYConstraint(view: self, secondView: secondView)
    }
    
    func setWidthConstraint(constant: CGFloat) {
        Constraints.widthConstraint(view: self, constant: constant)
    }
    
    func setHeight(constant: CGFloat) {
        Constraints.heightConstraint(view: self, constant: constant)
    }
    
    func setMinimunHeight(constant: CGFloat) {
        Constraints.minimumHeightConstraint(view: self, constant: constant)
    }
    
}
