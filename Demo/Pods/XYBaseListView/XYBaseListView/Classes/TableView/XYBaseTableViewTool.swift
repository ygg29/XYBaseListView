//
//  XYBaseTableViewTool.swift
//  Kingfisher
//
//  Created by xiaoyou on 2021/10/11.
//

import UIKit

open class XYBaseTableViewTool: NSObject {
    
    public static func getCurrentBaseCell(tableView: UITableView, indexPath: IndexPath,model: XYBaseTableCellModel) -> XYSuperTableCell {
        
        guard let cellIdentifierOption = model.xy_cellIdentifier else{
            
            return tableView.dequeueReusableCell(withIdentifier: XYSuperTableCell.cellIdentifier, for: indexPath) as! XYSuperTableCell
        }
        
        let baseCell = tableView.dequeueReusableCell(withIdentifier: cellIdentifierOption, for: indexPath) as! XYSuperTableCell
        baseCell.setCellData(model)
        return baseCell
    }
    
    public static func getCurrentHeaderFooterView(tableView:UITableView, section:Int, model:XYBaseTableHeaderFooterViewModel) -> XYSuperTableHeaderFooterView {

        guard let cellIdentifierOption = model.xy_cellIdentifier else{
            return tableView.dequeueReusableHeaderFooterView(withIdentifier: XYSuperTableCell.cellIdentifier) as! XYSuperTableHeaderFooterView
        }

        let baseCell = tableView.dequeueReusableHeaderFooterView(withIdentifier: cellIdentifierOption) as! XYSuperTableHeaderFooterView

        baseCell.setCellData(model)

        return baseCell

    }
    
    public static func getCurrentBaseCellHeight(tableView: UITableView, model: XYBaseTableCellModel) -> CGFloat {
        
        guard let baseCellH = model.xy_cellHeight else{
            return CGFloat.zero
        }
        return baseCellH
    
    }
    
    public static func getCurrentBaseHeaderHeight(tableView:UITableView,model: XYBaseTableHeaderFooterViewModel) -> CGFloat {

        return model.xy_viewHeight ?? .zero

    }
    
    public static func getCurrentBaseFooterHeight(tableView:UITableView,model: XYBaseTableHeaderFooterViewModel) -> CGFloat {

        return model.xy_viewHeight ?? .zero

    }
    
}
