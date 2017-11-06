//
//  PicPickerViewCell.swift
//  WeiBoStudy
//
//  Created by XYJ on 2017/9/15.
//  Copyright © 2017年 海角七梦. All rights reserved.
//

import UIKit

class PicPickerViewCell: UICollectionViewCell {
    //控件属性
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var removePhotoBtn: UIButton!
    @IBOutlet weak var photoImage: UIButton!
    //MARK:- 定义属性
    var image:UIImage?{
        didSet{
            if image != nil {
         imageView.image = image
                photoImage.isUserInteractionEnabled = false
                removePhotoBtn.isHidden = false
            }else{
                imageView.image = nil
                photoImage.isUserInteractionEnabled = true
                removePhotoBtn.isHidden = true
            }
            
        }
        
    }
    
    
    
//事件监听
    @IBAction func addPhotoClick(_ sender: Any) {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: PicPickerPhotoNote), object: nil)

        
        
    }

    @IBAction func removeBtnClick(_ sender: Any) {
         NotificationCenter.default.post(name: NSNotification.Name(rawValue: PicPickerPhotoRemoveNote), object: imageView.image)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
