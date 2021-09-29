//
//  XYBaseCollectionCell.swift
//  Hey
//
//  Created by xiaoyou on 2021/8/26.
//  Copyright © 2021 Giant Inc. All rights reserved.
//

import UIKit


open class XYSuperCollectionCell: UICollectionViewCell {
    func setCellData(_ model: XYBaseCollectionCellModel){}
    
    public class var cellIdentifier: String {
        return NSStringFromClass(self.classForCoder())
    }
}

open class XYBaseCollectionCell<T: XYBaseCellModel>: XYSuperCollectionCell, XYBaseCellProtocol {
    public typealias U = T
    public var cellModel: T?
    final override func setCellData(_ model: XYBaseCollectionCellModel) {
        if let model = model as? T {
            cellModel = model
            updateCellData(model)
        }
    }
    
    open func updateCellData(_ model: T) {
        
    }
}
