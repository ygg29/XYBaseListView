//
//  XYCellProtocol.swift
//  Hey
//
//  Created by xiaoyou on 2021/8/26.
//  Copyright © 2021 Giant Inc. All rights reserved.
//

import UIKit

enum XYListStyle{
    case plain, group
}

public protocol XYBaseCellProtocol {
    associatedtype U
    
    func updateCellData(_ model: U)
}

//extension GPBMessage: XYBaseCellModelProtocol{
//    var cellIndexPathOP: IndexPath? {
//        set {
//            objc_setAssociatedObject(self, &CellIndexPathOPStr, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
//        }
//        
//        get {
//            return objc_getAssociatedObject(self, &CellIndexPathOPStr) as? IndexPath
//        }
//    }
//    
//    var cellIdentifierOP: String? {
//        set {
//            objc_setAssociatedObject(self, &CellIdentifierOPStr, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
//        }
//        
//        get {
//            return objc_getAssociatedObject(self, &CellIdentifierOPStr) as? String
//        }
//    }
//    
//    var cellSizeOP: CGSize? {
//        set {
//            objc_setAssociatedObject(self, &CellSizeOPStr, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
//        }
//        
//        get {
//            return objc_getAssociatedObject(self, &CellSizeOPStr) as? CGSize
//        }
//    }
//}

//fileprivate var CellIdentifierOPStr = "cellIdentifierOPStr"
//fileprivate var CellSizeOPStr = "cellSizeOPStr"
//fileprivate var CellIndexPathOPStr = "cellIndexPathOPStr"





