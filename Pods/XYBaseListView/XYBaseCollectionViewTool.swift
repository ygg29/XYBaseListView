//
//  XYBaseCollectionViewTool.swift
//  Hey
//
//  Created by xiaoyou on 2021/8/26.
//  Copyright © 2021 Giant Inc. All rights reserved.
//

import UIKit


class XYBaseCollectionViewTool: NSObject {
    
    public static func getCurrentBaseCell(collectionView: UICollectionView, indexPath: IndexPath,model: XYBaseCellModelProtocol) -> XYSuperCollectionCell {
        
        guard let cellIdentifierOption = model.cellIdentifierOP else{
            
            return collectionView.dequeueReusableCell(withReuseIdentifier: XYSuperCollectionCell.cellIdentifier, for: indexPath) as! XYSuperCollectionCell
        }
        
        let baseCell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifierOption, for: indexPath) as! XYSuperCollectionCell
        baseCell.setCellData(model)
        return baseCell
    }
    
//    public static func getCurrentReusableBaseCell(collectionView:UICollectionView,kind:String,indexPath:IndexPath,model: XYBaseCellModelProtocol) -> HYBaseCollectionReusableView {
//
//        guard let cellIdentifierOption = model.cellIdentifierOP else{
//
//            return collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: HYBaseCollectionReusableView.cellIdentifier, for: indexPath) as! HYBaseCollectionReusableView
//        }
//
//        let baseCell = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: cellIdentifierOption, for: indexPath) as! HYBaseCollectionReusableView
//
//        baseCell.setCellData(model,indexPath)
//
//        return baseCell
//
//    }
    
    public static func getCurrentBaseCellSize(collectionView: UICollectionView, model: XYBaseCellModelProtocol) -> CGSize {
        
        guard let baseCellSize = model.cellSizeOP else{
            return CGSize.zero
        }
        return baseCellSize
    
    }
    
//    public static func getCurrentBaseCellEdgeInsets(collectionView:UICollectionView,model:XYBaseCellModelProtocol) -> UIEdgeInsets {
//
//        guard let baseCellHeight = model.cellEdgeInsetsOption else{
//            return UIEdgeInsets.zero
//        }
//        return baseCellHeight
//
//    }
    
//    public static func getCurrentBaseHeaderSize(collectionView:UICollectionView,model:NSObject) -> CGSize {
//
//        guard let baseCellHeight = model.cellHeaderSizeOption else{
//            return CGSize.zero
//        }
//        return baseCellHeight
//
//    }
    
//    public static func getCurrentBaseFooterSize(collectionView:UICollectionView,model:NSObject) -> CGSize {
//
//        guard let baseCellHeight = model.cellFooterSizeOption else{
//            return CGSize.zero
//        }
//        return baseCellHeight
//
//    }
    
}
