//
//  XYBaseCollectionCell.swift
//  Hey
//
//  Created by xiaoyou on 2021/8/26.
//  Copyright © 2021 Giant Inc. All rights reserved.
//

import UIKit


class XYSuperCollectionCell: UICollectionViewCell {
    public func setCellData(_ model: XYBaseCellModelProtocol){}
    
    class var cellIdentifier: String {
        return NSStringFromClass(self.classForCoder())
    }
}

class XYBaseCollectionCell<T: XYBaseCellModelProtocol>: XYSuperCollectionCell, XYBaseCellProtocol {
    typealias U = T
    
    final override func setCellData(_ model: XYBaseCellModelProtocol) {
        if let model = model as? T {
            updateCellData(model)
        }
    }
    
    public func updateCellData(_ model: T) {
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
//        loadPrivateSubviews()
//        layoutPrivateSubviews()
//        loadPrivateData()
    }
    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
//        loadPrivateSubviews()
//        layoutPrivateSubviews()
    }
    
//    override func loadPrivateSubviews() {
//        
//        self.backgroundColor = HY_Color_TableViewCell
//        
//    }
//    
//    override func layoutPrivateSubviews() {
//        
//    }

}
