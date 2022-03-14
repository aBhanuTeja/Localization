//
//  ViewController.swift
//  Localization
//
//  Created by Bhanuteja on 14/03/22.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var languageBtn: UILabel!
    @IBOutlet weak var myLanguageLbl: CustomLabel!
    @IBOutlet weak var descLbl: CustomLabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setUpLocalization()
    }

    func setUpLocalization() {
        let selectedLanguage = UserDefaults.standard.value(forKey: "selectedLanguage")
        if selectedLanguage != nil {
            languageBtn.text = selectedLanguage as? String
        }
        myLanguageLbl.text = CommonStrings.myLanguage.localized
        descLbl.text = CommonStrings.langDesc.localized
    }

    @IBAction func myLanguageBtnClicked(_ sender: Any) {
        let chooseLangVC = self.storyboard?.instantiateViewController(identifier: "ChooseLanguageVC") as! ChooseLanguageVC
        self.navigationController?.pushViewController(chooseLangVC, animated: true)
    }
}
