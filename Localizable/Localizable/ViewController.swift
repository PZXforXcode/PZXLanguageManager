//
//  ViewController.swift
//  Localizable
//
//  Created by 彭祖鑫 on 2023/7/4.
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

