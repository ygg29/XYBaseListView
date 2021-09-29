//
//  XYBaseCollectionReusableView.swift
//  XYBaseListView
//
//  Created by xiaoyou on 2021/9/29.
//

import UIKit

open class XYSuperCollectionReusableView: UICollectionReusableView {
    func setCellData(_ model: XYBaseReusableViewModel){}
    
    public class var cellIdentifier: String {
        return NSStringFromClass(self.classForCoder())
    }
}

open class XYBaseCollectionReusableView<T: XYBaseReusableViewModel>: XYSuperCollectionReusableView, XYBaseCellProtocol {
    public typealias U = T
    public var cellModel: T?
    
    final override func setCellData(_ model: XYBaseReusableViewModel) {
        if let model = model as? T {
            cellModel = model
            updateCellData(model)
        }
    }
    
    open func updateCellData(_ model: T) {
        
    }
}
