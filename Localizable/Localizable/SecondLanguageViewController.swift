//
//  SecondLanguageViewController.swift
//  Localizable
//
//  Created by 彭祖鑫 on 2023/12/8.
//

import UIKit

class SecondLanguageViewController: UIViewController {

    @IBOutlet weak var languageLabel: UILabel!
    //MARK: - lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setSubviews()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        languageLabel.text = LocalizableManager.localValue("farewell")

    }
    
    //MARK: – UI
    // subviews
    func setSubviews(){
        
        
    }
    
    //MARK: – request
    // 获取服务数据
    
    
    //MARK: – 填充数据
    // 填充数据
    
    
    //MARK: – 点击事件
    
    @IBAction func jumpToNextButtonPressed(_ sender: UIButton) {
        
        let vc : ThirdLanguageViewController = UIStoryboard.init(name: "ThirdLanguageViewController", bundle: nil).instantiateViewController(withIdentifier: "ThirdLanguageViewController") as! ThirdLanguageViewController;
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    //MARK: – Public Method
    // 公有方法
    
    
    //MARK: – Private Method
    // 私有方法

}
