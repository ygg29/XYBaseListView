//
//  XYBaseTableViewDataSource.swift
//  Kingfisher
//
//  Created by xiaoyou on 2021/10/11.
//

import Foundation

open class XYBaseTableViewDataSource: NSObject {
    public var dataSourceCount: DataSourceCountCallBack?
    public var dataSourceSection: DataSourceSectionCallBack?
    
    public var dataSourceModel: DataSourceModelCallBack?
    public var dataSourceHeaderModel: DataSourceHeaderFooterCallBack?
    public var dataSourceFooterModel: DataSourceHeaderFooterCallBack?
}

extension XYBaseTableViewDataSource: UITableViewDataSource {
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        return dataSourceSection?() ?? 0
    }
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        dataSourceCount?(section) ?? 0
    }
    

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let model = dataSourceModel?(indexPath) as? XYBaseTableCellModel{
            model.xy_cellIndexPath = indexPath
            return XYBaseTableViewTool.getCurrentBaseCell(tableView: tableView, indexPath: indexPath, model: model)
        }
        return XYSuperTableCell()
    }

    
}
