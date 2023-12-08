# PZXLanguageManager
iOS Swift 本地化 Localizable 方案 

# iOS Swift 本地化总结

## 一.自己建立LanguageManager的方式

### 1.建立Localizable文件

参考地址

https://www.jianshu.com/p/478b3f90187

上面地址可以建立Localizable文件

### 2.创建LanguageManager.swift

文件代码

```swift
//
//  LanguageManager.swift
//  Localizable
//
//  Created by - on 2023/12/8.
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



```

### 3.使用



```swift
//
//  ViewController.swift
//  Localizable
//
//  Created by - on 2023/7/4.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var textLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
//三方用法
//        textLabel.hc_Text = "geeting"

        setUpdateUI()
        
        NotificationCenter.default.addObserver(forName: LocalizableManager.languageChangedNotification, object: nil,  queue: nil) { (notification) in
            self.setUpdateUI()
        }



    }
    
    func setUpdateUI(){
        //取值
        //自己写的LanguageManager用法
        textLabel.text = LocalizableManager.localValue("geeting")
    }


    @IBAction func jumpToSecondButtonPressed(_ sender: UIButton) {
        
        let vc : SecondLanguageViewController = UIStoryboard.init(name: "SecondLanguageViewController", bundle: nil).instantiateViewController(withIdentifier: "SecondLanguageViewController") as! SecondLanguageViewController;
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func switchChineseButtonPressed(_ sender: UIButton) {
        
        //自己写的LanguageManager用法
        LocalizableManager.setLanguage(.chinese)

        //三方用法
//        HCLocalizableManager.share.updateLanguage("zh-Hans")
//        //语言切换监听
//        HCLocalizableManager.share.languageDidChange {
//            debugPrint("语言切换了")
//            // 当前语言type,后端需要数据
//            debugPrint("当前语言type:" + HCLocalizableResourcesFilter.share.currentLanguageType)
//        }

        
    }
    
    @IBAction func switchEnglishButtonPressed(_ sender: UIButton) {
        //自己写的LanguageManager用法
        LocalizableManager.setLanguage(.english)

        //三方用法
//        HCLocalizableManager.share.updateLanguage("en")
//        //语言切换监听
//        HCLocalizableManager.share.languageDidChange {
//            debugPrint("语言切换了")
//            // 当前语言type,后端需要数据
//            debugPrint("当前语言type:" + HCLocalizableResourcesFilter.share.currentLanguageType)
//        }

        
    }
    
    
}


```

## 二.三方使用

### 1.使用三方**HCLanguageSwitch**

发现了一个三方**HCLanguageSwitch**

比较好用用法也在Demo里



### Demo地址:https://github.com/PZXforXcode/PZXLanguageManager

