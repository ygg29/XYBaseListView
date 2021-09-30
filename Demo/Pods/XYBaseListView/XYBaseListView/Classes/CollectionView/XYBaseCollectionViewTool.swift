//
//  XYBaseCollectionViewTool.swift
//  Hey
//
//  Created by xiaoyou on 2021/8/26.
//  Copyright © 2021 Giant Inc. All rights reserved.
//

import UIKit


open class XYBaseCollectionViewTool: NSObject {
    
    public static func getCurrentBaseCell(collectionView: UICollectionView, indexPath: IndexPath,model: XYBaseCollectionCellModel) -> XYSuperCollectionCell {
        
        guard let cellIdentifierOption = model.xy_cellIdentifier else{
            
            return collectionView.dequeueReusableCell(withReuseIdentifier: XYSuperCollectionCell.cellIdentifier, for: indexPath) as! XYSuperCollectionCell
        }
        
        let baseCell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifierOption, for: indexPath) as! XYSuperCollectionCell
        baseCell.setCellData(model)
        return baseCell
    }
    
    public static func getCurrentReusableBaseCell(collectionView:UICollectionView,kind:String,indexPath:IndexPath,model: XYBaseReusableViewModel) -> XYSuperCollectionReusableView {

        guard let cellIdentifierOption = model.xy_cellIdentifier else{

            return collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: XYSuperCollectionReusableView.cellIdentifier, for: indexPath) as! XYSuperCollectionReusableView
        }

        let baseCell = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: cellIdentifierOption, for: indexPath) as! XYSuperCollectionReusableView

        baseCell.setCellData(model)

        return baseCell

    }
    
    public static func getCurrentBaseCellSize(collectionView: UICollectionView, model: XYBaseCollectionCellModel) -> CGSize {
        
        guard let baseCellSize = model.xy_cellSize else{
            return CGSize.zero
        }
        return baseCellSize
    
    }
    
//    public static func getCurrentBaseCellEdgeInsets(collectionView:UICollectionView,model: XYBaseCollectionCellModel) -> UIEdgeInsets {
//
//        return model.xy_cellEdgeInsets ?? .zero
//
//    }
    
    public static func getCurrentBaseHeaderSize(collectionView:UICollectionView,model: XYBaseReusableViewModel) -> CGSize {

        return model.xy_viewSize ?? .zero

    }
    
    public static func getCurrentBaseFooterSize(collectionView:UICollectionView,model: XYBaseReusableViewModel) -> CGSize {

        return model.xy_viewSize ?? .zero

    }
    
}
