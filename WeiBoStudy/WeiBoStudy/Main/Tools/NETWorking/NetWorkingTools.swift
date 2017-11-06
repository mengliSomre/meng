//
//  NetWorkingTools.swift
//  封装一个AFN
//
//  Created by XYJ on 2017/8/28.
//  Copyright © 2017年 海角七梦. All rights reserved.
//

import AFNetworking

//定义枚举
enum HTTPRequestType:Int{
case GET = 0
case POST
}

class NetWorkingTools: AFHTTPSessionManager {
//let 线程安全的
    static let shareInstace : NetWorkingTools = {
    let tools = NetWorkingTools()
    tools.responseSerializer.acceptableContentTypes?.insert("text/html")
        return tools
    }()
    
}
//MARK:- 封装请求方法
extension NetWorkingTools{
    func request(methodType:HTTPRequestType,urlString:String,parameters:[String :AnyObject],finished:@escaping (_ result : AnyObject?, _ error : Error?)-> ()){
        //成功回调
        let successCallBack = {
            (task:URLSessionDataTask,result:Any) in finished(result as AnyObject?,nil)
        }
        // 2 失败回调
        let failureCallBack = {(task : URLSessionDataTask?, error :Error) in
            finished(nil, error)
        }
        
        if methodType == .GET {
            //get请求
            get(urlString, parameters: parameters, progress: nil, success: successCallBack, failure: failureCallBack)
        }else{
        //post请求
            post(urlString, parameters: parameters, progress: nil, success: successCallBack, failure: failureCallBack)
        }


}
}
//extension NetWorkingTools{
//    func loadAccexxToken(code:String,finished:(_ result:[String:AnyObject]?,_ error:NSError?)->()){
//        let urlString = "https://api.weibo.com/oauth2/access_token"
//        //获取请求的参数
//        let parameters = ["client_id":app_key,"client_secret":app_secre,"grant_type":"authorization_code","code":code,"redirect_uri":redirext_url]
//        //发送网络请求
////        request(methodType: HTTPRequestType.POST, urlString: urlString, parameters: parameters as [String : AnyObject]) { (<#AnyObject?#>, <#Error?#>) in
////            <#code#>
////        }
////        
////    
////    }
//    
//}
//}

//MARK:- 请求用户信息
extension NetWorkingTools{
    
    func loadUserInfo(access_token:String,uid:String, fisnished:@escaping (_ result:[String : AnyObject]?,_ error:NSError?)->()){
//获取请求url
    let urlString = "https://api.weibo.com/2/users/show.json"
    //获取请求的参数
        let parameters = ["access_token":access_token,"uid" :uid]
        //发送网络请求
        request(methodType: .GET, urlString: urlString, parameters: parameters as [String : AnyObject]) { (result, error) in
            fisnished(result as? [String : AnyObject],error! as NSError)
        }

}
}





































