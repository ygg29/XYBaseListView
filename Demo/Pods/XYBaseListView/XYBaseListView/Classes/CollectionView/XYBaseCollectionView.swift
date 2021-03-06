//
//  XYBaseCollectionView.swift
//  Hey
//
//  Created by xiaoyou on 2021/8/26.
//  Copyright © 2021 Giant Inc. All rights reserved.
//

import UIKit

//
open class XYBaseCollectionView: UICollectionView {
    public var pager = XYPager()
    public var didScrollCallBack: DidScrollCallBack?
    public var didScrollWillBeginDraggingCallBack: DidScrollCallBack?
    public var didScrollDidEndDeceleratingCallBack: DidScrollCallBack?
    public var didSelectedCallBack: DidSelectedCallBack?
    var listStyle: XYListStyle = .plain
    
    
    public var dataSourceArr: [XYBaseCollectionCellModel] = [] {
        didSet{
            reloadData()
        }
    }
    
    // 分组数据源
    public var dataSourceArrGroup: [XYBaseCollectionGroupCellModel] = [] {
        didSet{
            reloadData()
        }
    }
    
    fileprivate var baseDelegate: XYBaseCollectionViewDelegate!
    fileprivate var baseDataSource: XYBaseCollectionViewDataSource!
    
    public init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout, style: XYListStyle = .plain) {
        super.init(frame: frame, collectionViewLayout: layout)
        self.listStyle = style
        self.contentInsetAdjustmentBehavior = .never
        self.delegate = baseDelegate
        self.dataSource = baseDataSource
    }
    private override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
    }
    required public init?(coder: NSCoder) {
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
        
        baseDelegate.dataSourceHeaderModel = {[weak self](section) in

            guard let strongSelf = self else{return nil}

            if section < strongSelf.dataSourceArrGroup.count{
                return strongSelf.dataSourceArrGroup[section].headerViewModel
            }else{
                return nil
            }

        }
        
        baseDelegate.dataSourceFooterModel = {[weak self](section) in

            guard let strongSelf = self else{return nil}

            if section < strongSelf.dataSourceArrGroup.count{
                return strongSelf.dataSourceArrGroup[section].footerViewModel
            }else{
                return nil
            }
        }
        
        baseDelegate.dataSourceModel = {[weak self](indexpath) in
            
            guard let self = self else{return nil}
            if self.listStyle == .plain {
                return self.dataSourceArr[indexpath.row]
            }else {
                return self.dataSourceArrGroup[indexpath.section].dataSourceArr[indexpath.row]
            }
        }
        
        baseDelegate.didSelectedCallBack = {[weak self](idxPath, model) in
            guard let strongSelf = self,let callBack = strongSelf.didSelectedCallBack else{ return }
            callBack(idxPath, model)
        }
        
        baseDataSource = XYBaseCollectionViewDataSource()
        
        baseDataSource.dataSourceSection = { [weak self] in
            guard let self = self else{return 0}
            if self.listStyle == .plain {
                return 1
            }else {
                return self.dataSourceArrGroup.count
            }
        }
        
        baseDataSource.dataSourceModel = {[weak self](indexpath) in
            
            guard let self = self else{return nil}
            if self.listStyle == .plain {
                return self.dataSourceArr[indexpath.row]
            }else {
                return self.dataSourceArrGroup[indexpath.section].dataSourceArr[indexpath.row]
            }
        }
        
        baseDataSource.dataSourceCount = {[weak self] (section) in
            guard let self = self else{return 0}
            if self.listStyle == .plain{
                return self.dataSourceArr.count
            } else {
                return self .dataSourceArrGroup[section].dataSourceArr.count
            }
        }
        baseDataSource.dataSourceHeaderModel = {[weak self](section) in

            guard let strongSelf = self else{return nil}

            if section < strongSelf.dataSourceArrGroup.count{
                return strongSelf.dataSourceArrGroup[section].headerViewModel
            }else{
                return nil
            }

        }
        
        baseDataSource.dataSourceFooterModel = {[weak self](section) in

            guard let strongSelf = self else{return nil}

            if section < strongSelf.dataSourceArrGroup.count{
                return strongSelf.dataSourceArrGroup[section].footerViewModel
            }else{
                return nil
            }
        }
        
        self.delegate = baseDelegate
        self.dataSource = baseDataSource
        
    }
    
    
}

