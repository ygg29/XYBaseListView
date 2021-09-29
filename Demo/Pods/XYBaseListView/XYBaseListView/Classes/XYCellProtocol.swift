//
//  XYCellProtocol.swift
//  Hey
//
//  Created by xiaoyou on 2021/8/26.
//  Copyright © 2021 Giant Inc. All rights reserved.
//

import UIKit



protocol XYBaseCellProtocol {
    associatedtype U
    
    func updateCellData(_ model: U)
}

protocol XYBaseCellModelProtocol: NSObjectProtocol {
    var cellIdentifierOP: String? {get set}
    var cellSizeOP: CGSize? {get set}
    var cellIndexPathOP: IndexPath? {get set}
}

extension XYBaseCellProtocol where Self: UICollectionViewCell {
    static var cellSize: CGSize {get{return CGSize.zero}}
}

extension XYBaseCellProtocol where Self: UITableViewCell {
    static var cellHeight: CGSize {get{return CGSize.zero}}
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

fileprivate var CellIdentifierOPStr = "cellIdentifierOPStr"
fileprivate var CellSizeOPStr = "cellSizeOPStr"
fileprivate var CellIndexPathOPStr = "cellIndexPathOPStr"





