//
//  XYBaseCollectionViewDelegate.swift
//  Hey
//
//  Created by xiaoyou on 2021/8/26.
//  Copyright © 2021 Giant Inc. All rights reserved.
//

import UIKit

class XYBaseCollectionViewDelegate: NSObject {
    public var didScrollCallBack: DidScrollCallBack?
    public var didScrollWillBeginDraggingCallBack: DidScrollCallBack?
    public var didScrollDidEndDeceleratingCallBack: DidScrollCallBack?
    public var didSelectedCallBack: DidSelectedCallBack?
    
    public var dataSourceModel: DataSourceModelCallBack?
    public var dataSourceHeaderModel: DataSourceHeaderFooterCallBack?
    public var dataSourceFooterModel: DataSourceHeaderFooterCallBack?
}


extension XYBaseCollectionViewDelegate: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if let model = dataSourceModel?(indexPath){
            return XYBaseCollectionViewTool.getCurrentBaseCellSize(collectionView: collectionView, model: model)
        }
        return CGSize.zero
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let callback = didSelectedCallBack{
            callback(indexPath, dataSourceModel?(indexPath))
        }
    }
}


extension XYBaseCollectionViewDelegate: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
  
        guard let block = didScrollCallBack else{return}
        block(scrollView)
        
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        
        guard let block = didScrollWillBeginDraggingCallBack else{return}
        block(scrollView)
        
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        guard let block = didScrollDidEndDeceleratingCallBack else{return}
        block(scrollView)
       
    }
    
    
}
