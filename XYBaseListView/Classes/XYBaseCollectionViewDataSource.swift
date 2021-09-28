//
//  XYBaseCollectionViewDataSource.swift
//  Hey
//
//  Created by xiaoyou on 2021/8/26.
//  Copyright © 2021 Giant Inc. All rights reserved.
//

import UIKit

class XYBaseCollectionViewDataSource: NSObject {
    public var dataSourceModel: DataSourceModelCallBack?
    public var dataSourceCount: DataSourceCountCallBack?
    public var dataSourceSection: DataSourceSectionCallBack?
}

extension XYBaseCollectionViewDataSource: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return dataSourceSection?() ?? 0
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        dataSourceCount?(section) ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let model = dataSourceModel?(indexPath){
            model.cellIndexPathOP = indexPath
            return XYBaseCollectionViewTool.getCurrentBaseCell(collectionView: collectionView, indexPath: indexPath, model: model)
        }
        return XYSuperCollectionCell()
    }
    
    
}
