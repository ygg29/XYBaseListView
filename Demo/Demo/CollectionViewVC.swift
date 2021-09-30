//
//  CollectionView.swift
//  Demo
//
//  Created by xiaoyou on 2021/9/2.
//

import UIKit
import XYBaseListView
import Kingfisher

class CollectionViewVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        creatData()
        
    }
    func setupUI(){
        view.addSubview(collectionView)
    }
    lazy var collectionView: XYBaseCollectionView = {
        let flow = UICollectionViewFlowLayout()
        let o = XYBaseCollectionView(frame: CGRect(x: 0, y: 100, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height - 100), collectionViewLayout: flow)
        o.alwaysBounceVertical = true
        o.register(CollectionImgCell.classForCoder(), forCellWithReuseIdentifier: CollectionImgCell.cellIdentifier)
        o.register(CollectionTxtCell.classForCoder(), forCellWithReuseIdentifier: CollectionTxtCell.cellIdentifier)
        o.register(CollectionHeaderView.classForCoder(), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: CollectionHeaderView.cellIdentifier)
        o.register(CollectionFooterView.classForCoder(), forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: CollectionFooterView.cellIdentifier)
        o.didSelectedCallBack = {idx, m in
            print("点击 cell\(idx)\(m)")
        }
        o.configDataSource()
        return o }()
    
}
extension CollectionViewVC {
    func creatData() {
        
        let group1 = BaseCollectionGroupModel()
        let group2 = BaseCollectionGroupModel()
        
        let header1 = ReuseableModel()
        header1.xy_cellIdentifier = CollectionHeaderView.cellIdentifier
        header1.xy_viewSize = CGSize(width: 300, height: 40)
        header1.color = .red
        
        let footer1 = ReuseableModel()
        footer1.xy_cellIdentifier = CollectionFooterView.cellIdentifier
        footer1.xy_viewSize = CGSize(width: 300, height: 200)
        footer1.color = .yellow
        
        let header2 = ReuseableModel()
        header2.xy_cellIdentifier = CollectionHeaderView.cellIdentifier
        header2.xy_viewSize = CGSize(width: 200, height: 10)
        header2.color = .cyan
  
        let footer2 = ReuseableModel()
        footer2.xy_cellIdentifier = CollectionFooterView.cellIdentifier
        footer2.xy_viewSize = CGSize(width: 200, height: 200)
        footer2.color = .green
        
        group1.headerViewModel = header1
        group1.footerViewModel = footer1
        group1.dataSourceArr = getList()
        
        group2.headerViewModel = header2
        group2.footerViewModel = footer2
        group2.dataSourceArr = getList2()
        
        collectionView.dataSourceArrGroup = [group1, group2]
        
    }
    func getList() -> [BaseCollectionCellModel]{
        let img = CollectionImgModel("https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fbpic.588ku.com%2Felement_origin_min_pic%2F18%2F08%2F24%2F05dbcc82c8d3bd356e57436be0922357.jpg&refer=http%3A%2F%2Fbpic.588ku.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1635496137&t=42285c4b702af3c2117af00c56aa290a")
        img.xy_cellSize = CGSize(width: 100, height: 200)
        img.xy_cellIdentifier = CollectionImgCell.cellIdentifier
        
        let txt = CollectionTextModel("测试测试")
        txt.xy_cellSize = CGSize(width: 100, height: 100)
        txt.xy_cellIdentifier = CollectionTxtCell.cellIdentifier
        
        let arr = [
            img,
            txt
        ]
        return arr
    }
    func getList2() -> [BaseCollectionCellModel]{
        let img = CollectionImgModel("https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fbpic.588ku.com%2Felement_origin_min_pic%2F16%2F08%2F19%2F1457b6a76c7756c.jpg&refer=http%3A%2F%2Fbpic.588ku.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1635512491&t=7fcc6170b06acd18f7ccbcea14b50890")
        img.xy_cellSize = CGSize(width: 100, height: 200)
        img.xy_cellIdentifier = CollectionImgCell.cellIdentifier
        
        let txt = CollectionTextModel("哈哈哈嘻嘻嘻")
        txt.xy_cellSize = CGSize(width: 100, height: 100)
        txt.xy_cellIdentifier = CollectionTxtCell.cellIdentifier
        
        let arr = [
            img,
            txt
        ]
        return arr
    }
    
}

class CollectionImgModel: BaseCollectionCellModel {
    init(_ imgStr: String){
        super.init()
        self.imgStr = imgStr
    }
    var imgStr: String?
}

class CollectionTextModel: BaseCollectionCellModel {
    init(_ text: String){
        super.init()
        self.text = text
    }
    var text: String?
}

class CollectionImgCell: XYBaseCollectionCell<CollectionImgModel> {
    override func updateCellData(_ model: CollectionImgModel) {
        imgView.kf.setImage(with: URL(string: model.imgStr!))
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.contentView.addSubview(imgView)
        imgView.frame = CGRect(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var imgView: UIImageView = {
        let o = UIImageView(frame: CGRect(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height))
        return o
    }()
}
//class

class CollectionTxtCell: XYBaseCollectionCell<CollectionTextModel> {
    override func updateCellData(_ model: CollectionTextModel) {
        label.text = model.text
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.contentView.addSubview(label)
        label.frame = CGRect(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var label: UILabel = {
        let o = UILabel(frame: CGRect(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height))
        return o
    }()
}



class CollectionHeaderView: XYBaseCollectionReusableView<ReuseableModel> {
    override func updateCellData(_ model: ReuseableModel) {
        self.backgroundColor = model.color
    }
}
class CollectionFooterView: XYBaseCollectionReusableView<ReuseableModel> {
    override func updateCellData(_ model: ReuseableModel) {
        self.backgroundColor = model.color
    }

}

class ReuseableModel: BaseReuseableModel{
    var color: UIColor?
}

class BaseReuseableModel: NSObject, XYBaseReusableViewModel {
    var xy_viewSize: CGSize?

    var xy_cellIndexPath: IndexPath?
    
    var xy_cellIdentifier: String?
}
class BaseCollectionCellModel:NSObject, XYBaseCollectionCellModel {
    var xy_cellSize: CGSize?
    
    var xy_cellIndexPath: IndexPath?
    
    var xy_cellIdentifier: String?
}

class BaseCollectionGroupModel:NSObject, XYBaseCollectionGroupCellModel{
    var headerViewModel: XYBaseReusableViewModel?
    
    var footerViewModel: XYBaseReusableViewModel?
    
    var dataSourceArr: [XYBaseCollectionCellModel] = []
}
