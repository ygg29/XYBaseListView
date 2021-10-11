//
//  XYBaseTableViewDelegate.swift
//  Kingfisher
//
//  Created by xiaoyou on 2021/10/11.
//

import Foundation

public class XYBaseTableViewDelegate: NSObject {
    public var didScrollCallBack: DidScrollCallBack?
    public var didScrollWillBeginDraggingCallBack: DidScrollCallBack?
    public var didScrollDidEndDeceleratingCallBack: DidScrollCallBack?
    public var didSelectedCallBack: DidSelectedCallBack?
    
    public var dataSourceModel: DataSourceModelCallBack?
    public var dataSourceHeaderModel: DataSourceHeaderFooterCallBack?
    public var dataSourceFooterModel: DataSourceHeaderFooterCallBack?
}


extension XYBaseTableViewDelegate: UITableViewDelegate{
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let model = dataSourceModel?(indexPath) as? XYBaseTableCellModel else{return .zero}
        return XYBaseTableViewTool.getCurrentBaseCellHeight(tableView: tableView, model: model)
    }
    public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let model = dataSourceHeaderModel?(section) as? XYBaseTableHeaderFooterViewModel else {return nil}
        return XYBaseTableViewTool.getCurrentHeaderFooterView(tableView: tableView, section: section, model: model)
    }
    public func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        guard let model = dataSourceFooterModel?(section) as? XYBaseTableHeaderFooterViewModel else {return nil}
        return XYBaseTableViewTool.getCurrentHeaderFooterView(tableView: tableView, section: section, model: model)
    }

    public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        guard let model = dataSourceHeaderModel?(section) as? XYBaseTableHeaderFooterViewModel else {return 0}
        return XYBaseTableViewTool.getCurrentBaseHeaderHeight(tableView: tableView, model: model)
    }
    public func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        guard let model = dataSourceFooterModel?(section) as? XYBaseTableHeaderFooterViewModel else {return 0}
        return XYBaseTableViewTool.getCurrentBaseFooterHeight(tableView: tableView, model: model)
    }
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let callback = didSelectedCallBack{
            callback(indexPath, dataSourceModel?(indexPath))
        }
    }
}


extension XYBaseTableViewDelegate: UIScrollViewDelegate {
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
  
        guard let block = didScrollCallBack else{return}
        block(scrollView)
        
    }
    
    public func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        
        guard let block = didScrollWillBeginDraggingCallBack else{return}
        block(scrollView)
        
    }
    
    public func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        guard let block = didScrollDidEndDeceleratingCallBack else{return}
        block(scrollView)
       
    }
    
    
}
