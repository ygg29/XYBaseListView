//
//  XYBaseTableHeaderFooterView.swift
//  XYBaseListView
//
//  Created by xiaoyou on 2021/10/11.
//

import UIKit

open class XYSuperTableHeaderFooterView: UITableViewHeaderFooterView {
    func setCellData(_ model: XYBaseTableHeaderFooterViewModel){}
    
    public class var cellIdentifier: String {
        return NSStringFromClass(self.classForCoder())
    }
}

open class XYBaseTableHeaderFooterView<T: XYBaseTableHeaderFooterViewModel>: XYSuperTableHeaderFooterView, XYBaseCellProtocol {
    public typealias U = T
    public var cellModel: T?
    
    final override func setCellData(_ model: XYBaseTableHeaderFooterViewModel) {
        if let model = model as? T {
            cellModel = model
            updateCellData(model)
        }
    }
    
    open func updateCellData(_ model: T) {
        
    }
}
