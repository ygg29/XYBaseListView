//
//  XYBaseCollectionViewDelegate.swift
//  Hey
//
//  Created by xiaoyou on 2021/8/26.
//  Copyright © 2021 Giant Inc. All rights reserved.
//

import UIKit

public class XYBaseCollectionViewDelegate: NSObject {
    public var didScrollCallBack: DidScrollCallBack?
    public var didScrollWillBeginDraggingCallBack: DidScrollCallBack?
    public var didScrollDidEndDeceleratingCallBack: DidScrollCallBack?
    public var didSelectedCallBack: DidSelectedCallBack?
    
    public var dataSourceModel: DataSourceModelCallBack?
    public var dataSourceHeaderModel: DataSourceHeaderFooterCallBack?
    public var dataSourceFooterModel: DataSourceHeaderFooterCallBack?
}


extension XYBaseCollectionViewDelegate: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let model = dataSourceModel?(indexPath) as? XYBaseCollectionCellModel else{return .zero}
        return XYBaseCollectionViewTool.getCurrentBaseCellSize(collectionView: collectionView, model: model)
    }
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        guard let model = dataSourceFooterModel?(section) as? XYBaseReusableViewModel else{return .zero}
        return XYBaseCollectionViewTool.getCurrentBaseFooterSize(collectionView: collectionView, model: model)
    }
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        guard let model = dataSourceHeaderModel?(section) as? XYBaseReusableViewModel else{return .zero}
        return XYBaseCollectionViewTool.getCurrentBaseHeaderSize(collectionView: collectionView, model: model)
    }

    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let callback = didSelectedCallBack{
            callback(indexPath, dataSourceModel?(indexPath))
        }
    }

}


extension XYBaseCollectionViewDelegate: UIScrollViewDelegate {
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
