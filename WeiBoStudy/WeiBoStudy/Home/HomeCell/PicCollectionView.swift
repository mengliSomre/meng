//
//  PicCollectionView.swift
//  WeiBoStudy
//
//  Created by XYJ on 2017/9/7.
//  Copyright © 2017年 海角七梦. All rights reserved.
//

import UIKit

class PicCollectionView: UICollectionView {
    //MRRK:- 定义属性
    var picURLS : [NSURL] = [NSURL](){
        didSet{
        self.reloadData()
        }    
    }
    
    //MRRK:- 系统回调函数
    override func awakeFromNib() {
super.awakeFromNib()
        dataSource = self
        
    }

}

//MARK:- collectionView数据源方法
extension PicCollectionView:UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return picURLS.count;
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //获取cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "picCell", for: indexPath) as! PicCollectionViewCell
//        cell.backgroundColor = UIColor.red
        cell.picUrl = picURLS[indexPath.item]
        //给cell设置数据
        return cell
    }


}

class PicCollectionViewCell: UICollectionViewCell {
     //MARK:- 定义模型属性
    var picUrl : NSURL?{
        didSet{
            guard let picUrl = picUrl else {
                return
            }
            icoView.sd_setImage(with: picUrl as URL , placeholderImage: UIImage.init(named: "empty_picture"))
        }
    
    }
    
    //MARK:- 控件
    @IBOutlet weak var icoView: UIImageView!
   
    
    
    
    
    
    
}

























