//
//  LanguageManager.swift
//  Localizable
//
//  Created by 彭祖鑫 on 2023/12/8.
//

import Foundation
import UIKit



enum LanguageType {
    case chinese,english,auto
}

class LocalizableManager: NSObject {
    
    static let languageChangedNotification = NSNotification.Name(rawValue: "LanguageChangedNotification")

    static func localValue(_ str:String) -> String {
        LocalizableManager.shared.localValue(str: str)
    }
    static func setLanguage(_ type:LanguageType){
        LocalizableManager.shared.setLanguage(type)
    }
    
    
    /// 单例
    static let shared: LocalizableManager = {
        let instance = LocalizableManager()
        do {
            try instance._initLanguage()
        } catch {
            print("Error initializing LocalizableManager: \(error)")
        }      
        return instance
    }()
    
    private override init() {
      
    }
    var bundle:Bundle = Bundle.main
    
    private func localValue(str:String) -> String{
        //table参数值传nil也是可以的，传nil系统就会默认为Localizable
        bundle.localizedString(forKey: str, value: nil, table: "Localizable")
    }
    
    /// 获取系统语言方法-->可以根据自身业务场景进行处理
    func getSystemLanguage() -> LanguageType {
        let preferredLang = Locale.current.language.languageCode?.identifier ?? "en"
        print("preferredLang = \(preferredLang)")
        
        switch preferredLang {
        case "en":
            return .english
        case "zh":
            return .chinese
        default:
            return .english
        }
    }
    ///获取当前应用的语言
    func getCurrentLanguage() -> LanguageType {
        if let languageType = UserDefaults.standard.value(forKey: "language") as? String {
            print("currentLanguage = \(languageType)")
            switch languageType {
            case "en":
                return .english
            case "zh-Hans":
                return .chinese
            default:
                return .english
            }
        } else {
            return .english
        }
    }
    
    private func setLanguage(_ type:LanguageType){
        var typeStr = ""
        switch type {
        case .chinese:
            typeStr = "zh-Hans"
            UserDefaults.standard.setValue("zh-Hans", forKey: "language")
        case .english:
            typeStr = "en"
            UserDefaults.standard.setValue("en", forKey: "language")
        default:
            break
        }
        //返回项目中 en.lproj 文件的路径
        let path = Bundle.main.path(forResource: typeStr, ofType: "lproj")
        //用这个路径生成新的bundle
        bundle = Bundle(path: path!)!
        if type == .auto {
            //和系统语言一致
            bundle = Bundle.main
            UserDefaults.standard.removeObject(forKey: "language")
        }
        NotificationCenter.default.post(name: LocalizableManager.languageChangedNotification, object: nil)
    }

}

extension LocalizableManager {
    /// 初始化语言文件
    private func _initLanguage() throws {
        
        if let languageType = UserDefaults.standard.value(forKey: "language") {
            print("languageType = \(languageType)")
            let type = languageType as! String
            switch type {
            case "en":
                setLanguage(.english)
            case "zh-Hans":
                setLanguage(.chinese)
            default:
                break
            }
        } else {
            // 如果没有设置当前语言，则使用系统首选语言
            setLanguage(getSystemLanguage())
        }
    }

}


