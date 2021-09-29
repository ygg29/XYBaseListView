//
//  ViewController.swift
//  Demo
//
//  Created by xiaoyou on 2021/9/2.
//

import UIKit
import XYBaseListView

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        view.addSubview(collectionViewBtn)
    }
    
    lazy var collectionViewBtn: UIButton = {
        let o = UIButton(type: .system)
        o.frame = CGRect(x: 50, y: 100, width: 120, height: 60)
        o.setTitle("collectionView", for: .normal)
        o.addTarget(self, action: #selector(pushCollectionView), for: .touchUpInside)
        return o }()
    
    @objc func pushCollectionView() {
        let o = CollectionViewVC()
        self.navigationController?.pushViewController(o, animated: true)
    }
}


