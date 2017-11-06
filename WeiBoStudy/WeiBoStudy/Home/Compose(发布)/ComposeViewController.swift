//
//  ComposeViewController.swift
//  WeiBoStudy
//
//  Created by XYJ on 2017/9/15.
//  Copyright © 2017年 海角七梦. All rights reserved.
//

import UIKit

class ComposeViewController: UIViewController {
    //控件属性
  
 
    @IBOutlet weak var picPickerView: PicPickerCollectionView!
    

    @IBOutlet weak var picPickViewBotomH: NSLayoutConstraint!
    @IBOutlet weak var bomH: NSLayoutConstraint!
    
    @IBOutlet weak var textView: ComposeTextView!
    
    lazy var titleView : ComposeView = ComposeView()
    lazy var images:[UIImage] = [UIImage]()
    override func viewDidLoad() {
        super.viewDidLoad()
        //设置导航栏
        setupNavigationBar()
        //监听通知
        setupNotifacations()
textView.inputView = nil
        // Do any additional setup after loading the view.
    }
 
    override func viewDidAppear(_ animated: Bool) {

//      textView.becomeFirstResponder()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }

}

//MARK:- 设置UI界面
extension ComposeViewController{
    func setupNavigationBar(){
    //设置左右item
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "关闭", style: .plain, target: self, action: #selector(ComposeViewController.closeItemClick))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "发布", style: UIBarButtonItemStyle.plain, target: self, action: #selector(ComposeViewController.sendItemClick))
        navigationItem.rightBarButtonItem?.isEnabled = false
        //设置标题
   titleView.frame = CGRect.init(x: 0, y: 0, width: 100, height: 40)
        navigationItem.titleView = titleView
    
    
    }
    func setupNotifacations(){
        //监听键盘的弹出
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChangeFrame(note:)), name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)
        //监听添加照片按钮的点击
        NotificationCenter.default.addObserver(self, selector: #selector(ComposeViewController.addPhotoClick), name: NSNotification.Name(rawValue: PicPickerPhotoNote), object: nil)
        //监听添加删除照片按钮的点击
        NotificationCenter.default.addObserver(self, selector: #selector(ComposeViewController.removePhotoClick), name: NSNotification.Name(rawValue: PicPickerPhotoRemoveNote), object: nil)
        
    }


}
//MARK:- 事件监听
extension ComposeViewController{
    @objc  func closeItemClick(){
    
    dismiss(animated: true, completion: nil)
    
    }
    @objc func sendItemClick(){
    
    LMLog(message: "发布")
    }
    @objc func keyboardWillChangeFrame(note:NSNotification){
    LMLog(message: note.userInfo)
        //获取动画执行时间
        let duration = note.userInfo![UIKeyboardAnimationDurationUserInfoKey]as! TimeInterval
        //获取键盘最终Y值
        let endFarme = (note.userInfo![UIKeyboardFrameEndUserInfoKey]as! NSValue).cgRectValue
        //计算工具栏距离底部的间距
        let margin = UIScreen.main.bounds.height - endFarme.origin.y
        //执行动画
    bomH.constant = margin
        UIView.animate(withDuration: duration) { 
            self.view.layoutIfNeeded()
        }
        
        
        
        
    }
    //添加照片
    @IBAction func picPickerBtnClick(_ sender: UIButton) {
        //退出键盘
        textView.resignFirstResponder()
        
        //执行动画
        picPickViewBotomH.constant = UIScreen.main.bounds.height * 0.65
        UIView.animate(withDuration: 0.5) {
            self.view.layoutIfNeeded()
        }
        LMLog(message: "laile")
    }
    //添加表情
    @IBAction func emoticonBtnClick(_ sender: Any) {
        LMLog(message: "表情")
        //退出键盘
        textView.resignFirstResponder()
        //切换键盘
    textView.inputView  =  textView.inputView != nil ? nil :UISwitch()
        //弹出键盘
textView.becomeFirstResponder()
    }
    
    
}

//MARK:- 添加照片和删除照片的事件
extension ComposeViewController{
    //删除照片
    @objc func removePhotoClick(note:NSNotification){
      LMLog(message: note.object)
        //获取image对象
    guard   let image = note.object as? UIImage else{
            return
        }
        //获取image对象所在下标值
        guard let index = images.index(of: image)  else {
            return
        }
        //将图片从数组删除
        images.remove(at: index)
        //重写collectionView新的数组
picPickerView.images = images
        
    }
    //添加照片
    @objc  func addPhotoClick(){
        LMLog(message: "addPhotoClick")
      //判断数据源是否可用
        if !UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            return
        }
        //创建照片选择器
        let pic = UIImagePickerController()
        //设置照片源
        pic.delegate = self
        pic.sourceType = .photoLibrary
        //弹出选择照片的控制器
      present(pic, animated: true, completion: nil)
        
    }
    
    
}

//MARK:-UIImagePickerController的代理方法
extension ComposeViewController:UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        //选中照片
        let iamge = info[UIImagePickerControllerOriginalImage] as! UIImage
        //将选中的照片添加到数组中
        images.append(iamge)
        //将数组赋值给collectionView,让其自己去展示数据
     picPickerView.images = images
        picker.dismiss(animated: true, completion: nil)
        
    }
    
    
}


//MARK:- textView代理

extension ComposeViewController:UITextViewDelegate{
    func textViewDidChange(_ textView: UITextView) {
       self.textView.placeHolderLabel.isHidden = textView.hasText
        navigationItem.rightBarButtonItem?.isEnabled = textView.hasText
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        textView.resignFirstResponder()
    }


}


















