//
//  XYBaseCellModel.swift
//  Hey
//
//  Created by xiaoyou on 2021/8/27.
//  Copyright © 2021 Giant Inc. All rights reserved.
//

import UIKit

/// model 须 遵循下面的协议才能使用
public protocol XYBaseCellModel: NSObjectProtocol{
    var xy_cellIndexPath: IndexPath?{get set}
    var xy_cellIdentifier: String?{get set}
}

public protocol XYBaseCollectionCellModel: XYBaseCellModel{
    var xy_cellSize: CGSize?{get set}
}
// resuable
public protocol XYBaseReusableViewModel: XYBaseCellModel{
    var xy_viewSize: CGSize?{get set}
}

// 分组的 group model
public protocol XYBaseCollectionGroupCellModel: NSObjectProtocol {
    var headerViewModel: XYBaseReusableViewModel?{get set}
    var footerViewModel: XYBaseReusableViewModel?{get set}
    var dataSourceArr: [XYBaseCollectionCellModel]{get set}
}


public protocol XYBaseTableCellModel: XYBaseCellModel{
    var xy_cellHeight: CGFloat?{get set}
}
// headerFooter
public protocol XYBaseTableHeaderFooterViewModel: XYBaseCellModel{
    var xy_viewHeight: CGFloat?{get set}
}

public protocol XYBaseTableGroupCellModel: NSObjectProtocol {
    var headerViewModel: XYBaseTableHeaderFooterViewModel?{get set}
    var footerViewModel: XYBaseTableHeaderFooterViewModel?{get set}
    var dataSourceArr: [XYBaseTableCellModel]{get set}
}
