//
//  XYBaseCollectionViewDataSource.swift
//  Hey
//
//  Created by xiaoyou on 2021/8/26.
//  Copyright © 2021 Giant Inc. All rights reserved.
//

import UIKit

open class XYBaseCollectionViewDataSource: NSObject {
    public var dataSourceCount: DataSourceCountCallBack?
    public var dataSourceSection: DataSourceSectionCallBack?
    
    public var dataSourceModel: DataSourceModelCallBack?
    public var dataSourceHeaderModel: DataSourceHeaderFooterCallBack?
    public var dataSourceFooterModel: DataSourceHeaderFooterCallBack?
}

extension XYBaseCollectionViewDataSource: UICollectionViewDataSource {
    
    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        return dataSourceSection?() ?? 0
    }
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        dataSourceCount?(section) ?? 0
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let model = dataSourceModel?(indexPath) as? XYBaseCollectionCellModel{
            model.xy_cellIndexPath = indexPath
            return XYBaseCollectionViewTool.getCurrentBaseCell(collectionView: collectionView, indexPath: indexPath, model: model)
        }
        return XYSuperCollectionCell()
    }
    
    public func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        var model: XYBaseReusableViewModel?
        if kind == UICollectionView.elementKindSectionHeader {
            model = dataSourceHeaderModel?(indexPath.section) as? XYBaseReusableViewModel
        }else if kind == UICollectionView.elementKindSectionFooter{
            model = dataSourceFooterModel?(indexPath.section) as? XYBaseReusableViewModel
        }
        guard let model = model else{ return UICollectionReusableView() }
        model.xy_cellIndexPath = indexPath
        return XYBaseCollectionViewTool.getCurrentReusableBaseCell(collectionView: collectionView, kind: kind, indexPath: indexPath, model: model)
    }
    
}
