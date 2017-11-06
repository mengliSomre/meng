//
//  PicPickerCollectionView.swift
//  WeiBoStudy
//
//  Created by XYJ on 2017/9/15.
//  Copyright © 2017年 海角七梦. All rights reserved.
//

import UIKit
private let edgMargin : CGFloat = 15
class PicPickerCollectionView: UICollectionView {
    //MARK:-定义属性
    var images :[UIImage] = [UIImage](){
        didSet{
            reloadData()
        }
        
        
    }
    
    //MARK:- 系统回调函数
    override func awakeFromNib() {
        super.awakeFromNib()
        //设置layout
        let layout = collectionViewLayout as! UICollectionViewFlowLayout
        let itemWH = (UIScreen.main.bounds.size.width - 4*edgMargin)/3
        layout.itemSize = CGSize.init(width: itemWH, height: itemWH)
        layout.minimumLineSpacing = edgMargin
        layout.minimumInteritemSpacing = edgMargin
    
    
        
        //设置collectionView属性
     register(UINib.init(nibName: "PicPickerViewCell", bundle: nil), forCellWithReuseIdentifier: "PicPickerViewCell")
            //设置内边距
        contentInset = UIEdgeInsetsMake(edgMargin, edgMargin, 0, edgMargin)
        
        
        dataSource = self as UICollectionViewDataSource
    }

}
extension PicPickerCollectionView:UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return  images.count == 9 ? images.count : images.count + 1
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PicPickerViewCell", for: indexPath) as! PicPickerViewCell
        cell.backgroundColor = UIColor.white
        cell.image = indexPath.item <= images.count - 1 ? images[indexPath.item]:nil
        return cell
        
    }
}



























