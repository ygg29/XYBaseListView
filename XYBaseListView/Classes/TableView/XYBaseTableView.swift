//
//  XYBaseTableView.swift
//  Kingfisher
//
//  Created by xiaoyou on 2021/10/11.
//

import UIKit


//
open class XYBaseTableView: UITableView {
    public var pager = XYPager()
    public var didScrollCallBack: DidScrollCallBack?
    public var didScrollWillBeginDraggingCallBack: DidScrollCallBack?
    public var didScrollDidEndDeceleratingCallBack: DidScrollCallBack?
    public var didSelectedCallBack: DidSelectedCallBack?
    
    
    public var dataSourceArr: [XYBaseTableCellModel] = [] {
        didSet{
            reloadData()
        }
    }
    // 分组数据源
    public var dataSourceArrGroup: [XYBaseTableGroupCellModel] = [] {
        didSet{
            reloadData()
        }
    }
    
    fileprivate var baseDelegate = XYBaseTableViewDelegate()
    fileprivate var baseDataSource = XYBaseTableViewDataSource()
    
    public override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        self.contentInsetAdjustmentBehavior = .never
        self.delegate = baseDelegate
        self.dataSource = baseDataSource
    }
    
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configDataSource() {

        //MARK: - delegate
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
            if self.style == .plain {
                return self.dataSourceArr[indexpath.row]
            }else {
                return self.dataSourceArrGroup[indexpath.section].dataSourceArr[indexpath.row]
            }
        }
        
        baseDelegate.didSelectedCallBack = {[weak self](idxPath, model) in
            guard let strongSelf = self,let callBack = strongSelf.didSelectedCallBack else{ return }
            callBack(idxPath, model)
        }
        
//MARK: - dataSource
        
        baseDataSource.dataSourceSection = { [weak self] in
            guard let self = self else{return 0}
            if self.style == .plain {
                return 1
            }else {
                return self.dataSourceArrGroup.count
            }
        }
        
        baseDataSource.dataSourceModel = {[weak self](indexpath) in
            
            guard let self = self else{return nil}
            if self.style == .plain {
                return self.dataSourceArr[indexpath.row]
            }else {
                return self.dataSourceArrGroup[indexpath.section].dataSourceArr[indexpath.row]
            }
        }
        
        baseDataSource.dataSourceCount = {[weak self] (section) in
            guard let self = self else{return 0}
            if self.style == .plain{
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
