//
//  XYCellProtocol.swift
//  Hey
//
//  Created by xiaoyou on 2021/8/26.
//  Copyright © 2021 Giant Inc. All rights reserved.
//

import UIKit

// 列表样式
public enum XYListStyle{
    case plain, grouped
}

public protocol XYBaseCellProtocol {
    associatedtype U
    
    func updateCellData(_ model: U)
}

public typealias DidSelectedCallBack = (_ indexPath: IndexPath,_ dataModel:XYBaseCellModel?) -> Void
public typealias DidScrollCallBack = (_ scrollView: UIScrollView) -> Void
public typealias LoadDataCompeleteCallBack = () -> Void

public typealias EnableMulScrollCallBack = (_ view: UIView?,_ otherView: UIView?) -> Bool

public typealias DataSourceSectionCallBack = () -> Int
public typealias DataSourceCountCallBack = (_ section: Int) -> Int
public typealias DataSourceModelCallBack = (_ indexPath: IndexPath) -> XYBaseCellModel?
public typealias DataSourceHeaderFooterCallBack = (_ section:Int) -> XYBaseCellModel?

// 分页器
public struct XYPager {
    public var offset: Int = 0
    public var limit: Int = 20
    
    public var total: Int {
        return offset * limit
    }
    public mutating func increase() {
        offset += 1
    }
    // 重置
    public mutating func reset() {
        offset = 0
    }
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





