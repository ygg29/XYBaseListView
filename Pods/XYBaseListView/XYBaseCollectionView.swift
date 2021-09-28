//
//  XYBaseCollectionView.swift
//  Hey
//
//  Created by xiaoyou on 2021/8/26.
//  Copyright © 2021 Giant Inc. All rights reserved.
//

import UIKit

typealias DidSelectedCallBack = (_ indexPath: IndexPath,_ dataModel:XYBaseCellModelProtocol?) -> Void
typealias DidScrollCallBack = (_ scrollView: UIScrollView) -> Void
typealias LoadDataCompeleteCallBack = () -> Void

typealias EnableMulScrollCallBack = (_ view: UIView?,_ otherView: UIView?) -> Bool

typealias DataSourceSectionCallBack = () -> Int
typealias DataSourceCountCallBack = (_ section: Int) -> Int
typealias DataSourceModelCallBack = (_ indexPath: IndexPath) -> XYBaseCellModelProtocol?
typealias DataSourceHeaderFooterCallBack = (_ section:Int) -> XYBaseCellModelProtocol?

//
class XYBaseCollectionView: UICollectionView {
    public var pager = Pager()
    public var didScrollCallBack: DidScrollCallBack?
    public var didScrollWillBeginDraggingCallBack: DidScrollCallBack?
    public var didScrollDidEndDeceleratingCallBack: DidScrollCallBack?
    public var didSelectedCallBack: DidSelectedCallBack?
    
    
    
    public var dataSourceArr: [XYBaseCellModelProtocol] = [] {
        didSet{
            reloadData()
        }
    }
    // 分组数据源 二维数组
    public var dataSourceArrGroup: [[XYBaseCellModelProtocol]] = [[]] {
        didSet{
            reloadData()
        }
    }
    
    fileprivate var baseDelegate: XYBaseCollectionViewDelegate!
    fileprivate var baseDataSource: XYBaseCollectionViewDataSource!
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        
        self.contentInsetAdjustmentBehavior = .never
//        self.backgroundColor = HY_Color_TableViewCell
        self.delegate = baseDelegate
        self.dataSource = baseDataSource
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configDataSource() {
        
        baseDelegate = XYBaseCollectionViewDelegate()
        
        if let _ = didScrollCallBack {
            
            baseDelegate.didScrollCallBack = { [weak self] scrollView in
                
                guard let strongSelf = self,let callBack = strongSelf.didScrollCallBack else{ return }
                
                callBack(scrollView)
                
            }
        }
        
        
        if let _ = didScrollWillBeginDraggingCallBack {
            
            baseDelegate.didScrollWillBeginDraggingCallBack = { [weak self] scrollView in
                
                guard let strongSelf = self,let callBack = strongSelf.didScrollWillBeginDraggingCallBack else{
                    return
                }
                
                callBack(scrollView)
            }
        }
        
        
        if let _ = didScrollDidEndDeceleratingCallBack {
            
            baseDelegate.didScrollDidEndDeceleratingCallBack = { [weak self] scrollView in
                
                guard let strongSelf = self,let callBack = strongSelf.didScrollDidEndDeceleratingCallBack else{
                    return
                }
                
                callBack(scrollView)
                
            }
        }
        
        
        
        baseDelegate.dataSourceModel = {[weak self](indexpath) in
            
            guard let self = self else{return nil}
            if self.dataSourceArr.count > 0 {
                return self.dataSourceArr[indexpath.row]
            }else if self.dataSourceArrGroup.count > 0 {
                return self .dataSourceArrGroup[indexpath.section][indexpath.item]
            }
            return nil
        }
        
//        baseDelegate.dataSourceHeaderModel = {[weak self](section) in
//
//            guard let strongSelf = self else{return nil}
//
//            if section < strongSelf.headerSourceArr.count{
//                return strongSelf.headerSourceArr[section]
//            }else{
//                return nil
//            }
//
//        }
        
//        baseDelegate.dataSourceFooterModel = {[weak self](section) in
//
//            guard let strongSelf = self else{return nil}
//
//            if section < strongSelf.footerSourceArr.count{
//                return strongSelf.footerSourceArr[section]
//            }else{
//                return nil
//            }
//
//        }
        
        baseDelegate.didSelectedCallBack = {[weak self](idxPath, model) in
            guard let strongSelf = self,let callBack = strongSelf.didSelectedCallBack else{ return }
            callBack(idxPath, model)
        }
        
        baseDataSource = XYBaseCollectionViewDataSource()
        
        baseDataSource.dataSourceSection = { [weak self] in
            guard let self = self else{return 0}
            if self.dataSourceArr.count > 0 {
                return 1
            }else if self.dataSourceArrGroup.count > 0 {
                return self.dataSourceArrGroup.count
            }
            return 0
        }
        
        baseDataSource.dataSourceModel = {[weak self](indexpath) in
            
            guard let self = self else{return nil}
            if self.dataSourceArr.count > 0 {
                return self.dataSourceArr[indexpath.row]
            }else if self.dataSourceArrGroup.count > 0 {
                return self .dataSourceArrGroup[indexpath.section][indexpath.item]
            }
            return nil
        }
        
        baseDataSource.dataSourceCount = {[weak self] section in
            guard let self = self else{return 0}
            if self.dataSourceArr.count > 0 {
                return self.dataSourceArr.count
            }else if self.dataSourceArrGroup.count > 0 {
                return self .dataSourceArrGroup[section].count
            }
            return 0
        }
        
        self.delegate = baseDelegate
        self.dataSource = baseDataSource
        
    }
    
    
}









// 分页器
public struct Pager {
    public var offset: Int = 0
    public var limit: Int = 20
    
    public var total: Int {
        return offset * limit
    }
    
    public mutating func reset() {
        offset = 0
    }
}
