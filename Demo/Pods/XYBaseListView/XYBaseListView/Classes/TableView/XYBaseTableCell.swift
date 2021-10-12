//
//  XYBaseTableCell.swift
//  Kingfisher
//
//  Created by xiaoyou on 2021/10/11.
//

import UIKit

open class XYSuperTableCell: UITableViewCell {
    func setCellData(_ model: XYBaseTableCellModel){}
    
    public class var cellIdentifier: String {
        return NSStringFromClass(self.classForCoder())
    }
}

open class XYBaseTableCell<T: XYBaseCellModel>: XYSuperTableCell, XYBaseCellProtocol {
    public typealias U = T
    public var cellModel: T?
    final override func setCellData(_ model: XYBaseTableCellModel) {
        if let model = model as? T {
            cellModel = model
            updateCellData(model)
        }
    }
    
    open func updateCellData(_ model: T) {
        
    }
}
