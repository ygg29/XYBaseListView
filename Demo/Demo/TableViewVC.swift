//
//  TableViewVC.swift
//  Demo
//
//  Created by xiaoyou on 2021/10/11.
//

import UIKit
import XYBaseListView

class TableViewVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        setupUI()
        creatData()
        
    }
    func setupUI(){
        view.addSubview(tableView)
    }
    lazy var tableView: XYBaseTableView = {
        let o = XYBaseTableView(frame: CGRect(x: 0, y: 100, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height - 100), style: .grouped)
        o.alwaysBounceVertical = true
        o.register(TableViewImgCell.classForCoder(), forCellReuseIdentifier: TableViewImgCell.cellIdentifier)
        o.register(TableViewTxtCell.classForCoder(), forCellReuseIdentifier: TableViewTxtCell.cellIdentifier)
        o.register(TableViewHeaderView.classForCoder(), forHeaderFooterViewReuseIdentifier: TableViewHeaderView.cellIdentifier)
        o.register(TableViewFooterView.classForCoder(), forHeaderFooterViewReuseIdentifier: TableViewFooterView.cellIdentifier)
        o.didSelectedCallBack = {idx, m in
            print("点击 cell\(idx)\(m)")
        }
        o.configDataSource()
        return o }()
    
}

extension TableViewVC{
    func creatData() {
        
        let group1 = BaseTableViewGroupModel()
        let group2 = BaseTableViewGroupModel()
        
        let header1 = HeaderFooterModel()
        header1.xy_cellIdentifier = TableViewHeaderView.cellIdentifier
        header1.xy_viewHeight = 40
        header1.color = .red
        
        let footer1 = HeaderFooterModel()
        footer1.xy_cellIdentifier = TableViewFooterView.cellIdentifier
        footer1.xy_viewHeight = 200
        footer1.color = .yellow
        
        let header2 = HeaderFooterModel()
        header2.xy_cellIdentifier = TableViewHeaderView.cellIdentifier
        header2.xy_viewHeight = 10
        header2.color = .cyan
  
        let footer2 = HeaderFooterModel()
        footer2.xy_cellIdentifier = TableViewFooterView.cellIdentifier
        footer2.xy_viewHeight = 200
        footer2.color = .green
        
        group1.headerViewModel = header1
        group1.footerViewModel = footer1
        group1.dataSourceArr = getList()
        
        group2.headerViewModel = header2
        group2.footerViewModel = footer2
        group2.dataSourceArr = getList2()
        
        tableView.dataSourceArrGroup = [group1, group2]
        
    }
    func getList() -> [BaseTableViewCellModel]{
        let img = TableViewImgModel("https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fbpic.588ku.com%2Felement_origin_min_pic%2F18%2F08%2F24%2F05dbcc82c8d3bd356e57436be0922357.jpg&refer=http%3A%2F%2Fbpic.588ku.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1635496137&t=42285c4b702af3c2117af00c56aa290a")
        img.xy_cellHeight = 200
        img.xy_cellIdentifier = TableViewImgCell.cellIdentifier
        
        let txt = TableViewTextModel("测试测试")
        txt.xy_cellHeight = 200
        txt.xy_cellIdentifier = TableViewTxtCell.cellIdentifier
        
        let arr = [
            img,
            txt
        ]
        return arr
    }
    func getList2() -> [BaseTableViewCellModel]{
        let img = TableViewImgModel("https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fbpic.588ku.com%2Felement_origin_min_pic%2F16%2F08%2F19%2F1457b6a76c7756c.jpg&refer=http%3A%2F%2Fbpic.588ku.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1635512491&t=7fcc6170b06acd18f7ccbcea14b50890")
        img.xy_cellHeight = 200
        img.xy_cellIdentifier = TableViewImgCell.cellIdentifier
        
        let txt = TableViewTextModel("哈哈哈嘻嘻嘻")
        txt.xy_cellHeight = 100
        txt.xy_cellIdentifier = TableViewTxtCell.cellIdentifier
        
        let arr = [
            img,
            txt
        ]
        return arr
    }
    
}



class TableViewImgModel: BaseTableViewCellModel {
    init(_ imgStr: String){
        super.init()
        self.imgStr = imgStr
    }
    var imgStr: String?
}

class TableViewTextModel: BaseTableViewCellModel {
    init(_ text: String){
        super.init()
        self.text = text
    }
    var text: String?
}

class TableViewImgCell: XYBaseTableCell<TableViewImgModel> {
    override func updateCellData(_ model: TableViewImgModel) {
        contentView.backgroundColor = .brown
        imgView.kf.setImage(with: URL(string: model.imgStr!))
    }
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
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

class TableViewTxtCell: XYBaseTableCell<TableViewTextModel> {
    override func updateCellData(_ model: TableViewTextModel) {
        label.text = model.text
        contentView.backgroundColor = .orange
    }
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
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


class TableViewHeaderView: XYBaseTableHeaderFooterView<HeaderFooterModel> {
    override func updateCellData(_ model: HeaderFooterModel) {
        self.contentView.backgroundColor = model.color
    }
}
class TableViewFooterView: XYBaseTableHeaderFooterView<HeaderFooterModel> {
    override func updateCellData(_ model: HeaderFooterModel) {
        self.contentView.backgroundColor = model.color
    }

}

class HeaderFooterModel: BaseHeaderFooterModel{
    var color: UIColor?
}

class BaseHeaderFooterModel: NSObject, XYBaseTableHeaderFooterViewModel{
    var xy_viewHeight: CGFloat?
    
    var xy_cellIndexPath: IndexPath?
    
    var xy_cellIdentifier: String?
    
}
class BaseTableViewCellModel:NSObject, XYBaseTableCellModel {
    var xy_cellHeight: CGFloat?
    
    var xy_cellIndexPath: IndexPath?
    
    var xy_cellIdentifier: String?
    

}

class BaseTableViewGroupModel:NSObject, XYBaseTableGroupCellModel{
    var headerViewModel: XYBaseTableHeaderFooterViewModel?
    
    var footerViewModel: XYBaseTableHeaderFooterViewModel?
    
    var dataSourceArr: [XYBaseTableCellModel] = []

}
