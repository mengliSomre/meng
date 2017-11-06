//
//  HomeViewCell.swift
//  WeiBoStudy
//
//  Created by XYJ on 2017/9/4.
//  Copyright © 2017年 海角七梦. All rights reserved.
//

import UIKit
import SDWebImage
private let edgeMargin:CGFloat = 15
private let itemMargin:CGFloat = 10

class HomeViewCell: UITableViewCell {
    //MARK:- 控件
    
    @IBOutlet weak var picView: PicCollectionView!
    @IBOutlet weak var icoImageView: UIImageView!
    
    @IBOutlet weak var rzView: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var creatLabel: UILabel!
    
    @IBOutlet weak var vipImageView: UIImageView!
    
    @IBOutlet weak var whereLabel: UILabel!
    
    @IBOutlet weak var contentLabel: UILabel!
    
    @IBOutlet weak var revContectLabel: UILabel!
    
    @IBOutlet weak var bagView: UIView!//转发背景view
    
    @IBOutlet weak var toolView: UIView!
    //MARK:- 约束属性
    
    @IBOutlet weak var zhuafaTopH: NSLayoutConstraint!
    @IBOutlet weak var conctactH: NSLayoutConstraint!
    @IBOutlet weak var picBomH: NSLayoutConstraint!
    @IBOutlet weak var picViewWCons: NSLayoutConstraint!
    @IBOutlet weak var picViewHCons: NSLayoutConstraint!
    @IBOutlet weak var contentLabelW: NSLayoutConstraint!
    //MARK:- 自定义属性
    var viewModel:StatusViewModel?{
        didSet{
        //nil校验
            guard let viewModel = viewModel else {
                return
            }
            //头像
         icoImageView.sd_setImage(with: viewModel.icoUrl! as URL, placeholderImage: UIImage.init(named: "avatar_default_small"))
            //认证
            rzView.image = viewModel.verifiedImage
            //昵称
            nameLabel.text = viewModel.status?.user?.screen_name
            //会员图标
            vipImageView.image = viewModel.vipImage
            //时间
            creatLabel.text = viewModel.creatText
            //来源
            if let sourceText = viewModel.sourceText {
                 whereLabel.text = "来自 "+sourceText
            }else{
            whereLabel.text = nil
            }
            
//            
//            whereLabel.text = viewModel.sourceText
            //内容
            contentLabel.text = viewModel.status?.text
            //设置昵称颜色
            nameLabel.textColor = viewModel.vipImage == nil ? UIColor.black :UIColor.orange
            //计算配图View宽度高度的约束
            let picViewSize = calculatePicViewSize(count: viewModel.picUrls.count)
            picViewHCons.constant = picViewSize.height
            picViewWCons.constant = picViewSize.width
            //将picUrls数据传递给picView
            picView.picURLS = viewModel.picUrls
            //设置转发微博的正文
            if viewModel.status?.retweeted_status != nil {
                if let screenName =  viewModel.status?.retweeted_status?.user?.screen_name,let retweetText = viewModel.status?.retweeted_status?.text {
                    revContectLabel.text = "@"+"\(screenName):"+retweetText
                   bagView.isHidden = false
                    //有转发正文 设置约束
                    conctactH.constant = 10
                }
            }else{
            revContectLabel.text = nil
                bagView.isHidden = true
                  //没有 设置0
                conctactH.constant = 0
            }
            
//            //计算cell高度
        
//            if viewModel.cellHeight == 0 {
//                    layoutIfNeeded()
//                //获取底部工具栏的最大Y值
//                viewModel.cellHeight = toolView.frame.maxY
//            }
//
            
            
        }
    
    }
    
    
//MARK:- 系统回调函数
    override func awakeFromNib() {
        super.awakeFromNib()
        //设置微博正文宽度约束
        contentLabelW.constant = UIScreen.main.bounds.width - edgeMargin*2
  
        
        

        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
//MARK:- 计算方法
extension HomeViewCell{
    func calculatePicViewSize(count:Int)->CGSize{
        if count == 0 {
            return CGSize.zero
        }
        
        //取出picView对应的layout
        let layout = picView.collectionViewLayout as! UICollectionViewFlowLayout
//        let iamgeViewWH = (UIScreen.main.bounds.width - 2*edgeMargin - 2*itemMargin)/3
//        layout.itemSize = CGSize(width: iamgeViewWH, height: iamgeViewWH)
        
        //单张配图
        if count == 1 {
         //1.取出图片
            let urlString = viewModel?.picUrls.last?.absoluteString
            let image = SDWebImageManager.shared().imageCache.imageFromDiskCache(forKey: urlString)
            //设置一张图片是layout的itemsize
            layout.itemSize = CGSize.init(width: (image?.size.width)! * 2, height: (image?.size.height)! * 2)
            return CGSize.init(width: (image?.size.width)! * 2, height: (image?.size.height)! * 2)
            
        }
    //计算itemViewWH
        
        let imageViewWH = (UIScreen.main.bounds.width - 2*edgeMargin - 2*itemMargin) / 3
        
        //设置其他图片的layout
        layout.itemSize = CGSize.init(width: imageViewWH, height: imageViewWH)
        //四张配图
        if count == 4{
            let picViewWH  = imageViewWH*2 + itemMargin + 1
            return CGSize.init(width: picViewWH, height: picViewWH)
            
        }
        //其他帐配图
        let rows = CGFloat((count - 1)/3 + 1)
        let picViewH = rows*imageViewWH + (rows - 1)*itemMargin
        
          //计算picView的宽度
         let picViewW = UIScreen.main.bounds.width - 2*edgeMargin
     
        return CGSize.init(width: picViewW, height: picViewH)
    
    }



}










