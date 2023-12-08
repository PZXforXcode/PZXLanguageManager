//
//  ThirdLanguageViewController.swift
//  Localizable
//
//  Created by 彭祖鑫 on 2023/12/8.
//

import UIKit

class ThirdLanguageViewController: UIViewController {

    @IBOutlet weak var label: UILabel!
    //MARK: - lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setSubviews()

    }
    //MARK: – UI
    // subviews
    func setSubviews(){
        updateLanguage()
    }
    func  updateLanguage(){
        label.text = "组合字符串 \(LocalizableManager.localValue("geeting")),\(LocalizableManager.localValue("farewell"))"

    }
    //MARK: – request
    // 获取服务数据
    
    
    //MARK: – 填充数据
    // 填充数据
    
    
    //MARK: – 点击事件
    
    @IBAction func switchLanguageButtonPressed(_ sender: UIButton) {
        
        print("LocalizableManager.shared.getCurrentLanguage() = \(LocalizableManager.shared.getCurrentLanguage())")
        
        if (LocalizableManager.shared.getCurrentLanguage() == .chinese) {
            LocalizableManager.setLanguage(.english)
            
        } else {
            LocalizableManager.setLanguage(.chinese)
        }
        updateLanguage()
        
    }
    
    //MARK: – Public Method
    // 公有方法
    
    
    //MARK: – Private Method
    // 私有方法

}
