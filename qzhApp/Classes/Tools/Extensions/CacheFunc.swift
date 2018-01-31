//
//  CacheFunc.swift
//  qzhApp
//
//  Created by sbxmac on 2017/12/27.
//  Copyright © 2017年 SpecialTech. All rights reserved.
//

import Foundation
import UIKit

class CacheFunc: NSObject{
    //获取沙盒路径
    func cachePath(_ proName:String)->String{
        let cachePath=NSHomeDirectory()+"/Library/Caches/proData/"+proName+"/"
        let FM:FileManager=FileManager.default
        if !FM.fileExists(atPath: cachePath, isDirectory: nil){
            do{
                try FM.createDirectory(atPath: cachePath, withIntermediateDirectories: true, attributes: nil)
            }catch let error as NSError{
                print("存储路径错误--》\(error)")
            }
        }
        return cachePath
    }
    
    //存储缓存
    func saveDataToCache(proName:String,Data:NSData)->(){
        let pathStr=self.cachePath(proName)+"\(proName).png"
        print("存路径-->\(pathStr)")
        Data.write(toFile: pathStr, atomically: true)
    }
    
    
    //获取缓存
    func getDataFromCache(proName:String)->NSData{
        let pathStr=self.cachePath(proName)+"\(proName).png"
        print("存路径-->\(pathStr)")
        let data:NSData = NSData(contentsOfFile:pathStr)!
        return data
        
    }
    
    //获取缓存文件数据
    func getCahceData(fileName:String,folderName:String)->NSDictionary{
        var userInfo:NSDictionary!=NSDictionary()
        let fileManager=FileManager.default
        
        //缓存路径
        let cachePath=userExclusiveFolder(folderName:folderName)+fileName
        let exist=fileManager.fileExists(atPath:cachePath)
        
        if !exist{
            userInfo=nil
        }else{
            userInfo=NSDictionary(contentsOfFile:cachePath)
        }
        return userInfo
    }
    
    //将数据缓存到本地cache文件夹中
    func setCahceData(fileName:String,folderName:String,cacheDatas:NSDictionary){
        let folder:String=userExclusiveFolder(folderName:folderName)
        let cacheFilePath:String = folder+fileName
        let fileManager=FileManager.default
        //判断文件是否存在
        let exist=fileManager.fileExists(atPath:cacheFilePath)
        if !exist{
            fileManager.createFile(atPath: cacheFilePath, contents: nil, attributes: nil)
        }
        
        cacheDatas.write(toFile: cacheFilePath, atomically: true)
    }
    
    //直接缓存文件至cache文件夹中
    func setFileInCache(fileName:String){
        let folder:String!=NSHomeDirectory()+"/Library/Caches/qzh_ios／"
        //文件夹如果不存在则新建
        let fileManager=FileManager.default
        try! fileManager.createDirectory(atPath: folder, withIntermediateDirectories: true, attributes: nil)
        
        let filePath=folder+fileName
        //判断文件是否存在
        let exist=fileManager.fileExists(atPath:filePath)
        if !exist{
            fileManager.createFile(atPath: filePath, contents: nil, attributes: nil)
        }
    }
    //创建缓存目录
    func createCacheFolder(name:String,baseUrl:NSURL){
        let fileManager=FileManager.default
        let folder=baseUrl.appendingPathComponent(name, isDirectory: true)
        let exist=fileManager.fileExists(atPath: folder!.path)
        if !exist{
            try! fileManager.createDirectory(at: folder!, withIntermediateDirectories: true, attributes: nil)
        }
    }
    //创建(用户)缓存文件夹
    func userExclusiveFolder(folderName:String)->String{
        let folder:String!=NSHomeDirectory()+"/Library/Caches/qzh_ios／"+folderName
        //文件夹如果不存在则新建
        let fileManager=FileManager.default
        try! fileManager.createDirectory(atPath: folder, withIntermediateDirectories: true, attributes: nil)
        return folder
    }
    
    //判断是否登陆
    func determineWhetherLanding()->Bool{
        var loginInfo:NSDictionary!=NSDictionary()
        let fileManager=FileManager.default
        
        var LoginFlag:Bool!=false
        
        //缓存路径
        let cachePath=userExclusiveFolder(folderName:"Login")+"LoginInfo.plist"
        let exist=fileManager.fileExists(atPath:cachePath)
        
        if !exist{
            LoginFlag=false
        }else{
            loginInfo=NSDictionary(contentsOfFile:cachePath)
            let Info:String=loginInfo.object(forKey: "userFlag") as! String
            if (Info != "false"){
                LoginFlag=true
            }else{
                LoginFlag=false
            }
        }
        return LoginFlag
    }
    
    //获取已登录用户的信息/Users/sbxmac/Documents/My Workspace/qzh_ios/qzh_ios/members.swift
    func getUserInfo()->NSDictionary{
        var userInfo:NSDictionary!=NSDictionary()
        let fileManager=FileManager.default
        
        if determineWhetherLanding(){
            //缓存路径
            let cachePath=userExclusiveFolder(folderName:"Login")+"LoginInfo.plist"
            let folderName:String=NSDictionary(contentsOfFile:cachePath)?.object(forKey: "userAccount")as! String
            
            //登录用户基本信息缓存路径
            let userInfoPath=userExclusiveFolder(folderName:folderName)+"userInfo.plist"
            userInfo=NSDictionary(contentsOfFile:userInfoPath)
        }
        return userInfo
    }
    
    //删除指定路径指定缓存文件
    func deleteFile(fileNamePath:String){
        let manager=FileManager.default
        try! manager.removeItem(atPath: fileNamePath)
    }
    
    //删除指定目录下所有文件
    func deleteFolderAllFiles(folderPath:String){
        let fileManager=FileManager.default
        let fileArray=fileManager.subpaths(atPath: folderPath)
        
        for fn in fileArray!{
            try! fileManager.removeItem(atPath: folderPath+"/\(fn)")
        }
    }
    
    //获取文件属性
    func getFileAttribute(filePath:String)->NSDictionary{
        let manager=FileManager.default
        
        let urlForDocument=manager.urls(for: .documentDirectory, in: .userDomainMask)
        let docPath=urlForDocument[0]
        let file=docPath.appendingPathComponent(filePath)
        
        let attribute=try? manager.attributesOfItem(atPath: file.path)
        return attribute as! NSDictionary
    }
    //清除本地缓存
    func cleanCahche()->Bool{
        var result=true
        let basePath=NSHomeDirectory()+"/Library/Caches/qzh_ios／"
        let fileManager=FileManager.default
        if fileManager.fileExists(atPath: basePath){
            let fileArr=fileManager.subpaths(atPath: basePath)
            for file in fileArr!{
                let path=(basePath as NSString).appending("/\(file)")
                if fileManager.fileExists(atPath: path){
                    do{
                        try fileManager.removeItem(atPath: path)
                    }catch{
                        result=false
                    }
                }
            }
        }
        return result
    }
    
    //计算缓存大小
    func caculateCache()->String{
        let basePath=NSHomeDirectory()+"/Library/Caches/qzh_ios／"
        let fileManager=FileManager.default
        var total=0
        if fileManager.fileExists(atPath: basePath){
            let fileArr=fileManager.subpaths(atPath: basePath)
            for file in fileArr!{
                let path=(basePath as NSString).appending("/\(file)")
                let floder=try! fileManager.attributesOfItem(atPath: path)
                for(abc,bcd)in floder{
                    if abc==FileAttributeKey.size{
                        total+=(bcd as AnyObject).integerValue
                    }
                }
            }
        }
        
        let cacheSize = "查找出\(total/1024/1024)MB缓存"
        //NSString(format: "%.1f MB缓存", total, /1024.0 / 1024.0 )as String
        return cacheSize
    }
    
    
    //将图片缓存到指定目录下
    func setImgToCahce(){
        
    }
}
