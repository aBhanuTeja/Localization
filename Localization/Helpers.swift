//
//  Helpers.swift
//  Swift - Localization
//
//  Created by Bhanuteja on 09/06/21.
//

import UIKit

@IBDesignable class CustomLabel: UILabel {

    @IBInspectable var localizedKey: String?

    override func awakeFromNib() {
        super.awakeFromNib()
        if localizedKey != nil {
            self.text = localizedKey?.localize()
        }
    }
}

//MARK:- Approach-1
// Un comment below code and comment Approach-2 code (line: 50-80)
/*
enum ChooseLanguageStrings: String {
    case englishTopLbl      = "EnglishTopLbl"
    case englishBottomLbl   = "EnglishBottomLbl"
    case arabicTopLbl       = "ArabicTopLbl"
    case arabicBottomLbl    = "ArabicBottomLbl"
    case frenchTopLbl       = "FrenchTopLbl"
    case frenchBottomLbl    = "FrenchBottomLbl"
    case spanishTopLbl      = "SpanishTopLbl"
    case spanishBottomLbl   = "SpanishBottomLbl"

    var localized: String {
        return self.rawValue.localize()
    }
}

extension String {
    func localize() -> String {
        return NSLocalizedString(self, tableName: "Localizable", value: self, comment: "")
    }
}
*/

//MARK:- Approach-2
// Comment below code and Un comment Approach-1 code (line: 25-44)
extension String {
    func localize(tableName: String = "Localizable") -> String {
        return NSLocalizedString(self, tableName: tableName, value: self, comment: "")
    }
}

protocol Localizable {
    var tableName: String { get }
    var localized: String { get }
}

extension Localizable where Self: RawRepresentable, Self.RawValue == String {
    var localized: String {
        return rawValue.localize(tableName: tableName)
    }
}

enum ChooseLanguageStrings: String, Localizable {
    case englishTopLbl      = "EnglishTopLbl"
    case englishBottomLbl   = "EnglishBottomLbl"
    case arabicTopLbl       = "ArabicTopLbl"
    case arabicBottomLbl    = "ArabicBottomLbl"
    case frenchTopLbl       = "FrenchTopLbl"
    case frenchBottomLbl    = "FrenchBottomLbl"
    case spanishTopLbl      = "SpanishTopLbl"
    case spanishBottomLbl   = "SpanishBottomLbl"

    var tableName: String {
        return "Localizable"
    }
}

enum CommonStrings: String, Localizable {
    case myLanguage = "MyLanguage"
    case langDesc = "langDesc"
    
    var tableName: String {
        return "Localizable"
    }
}

enum AvailableLanguages: String {
    case english = "en"
    case arabic = "ar"
    case french = "fr"
    case spanish = "es"
}
/*
let APPLE_LANGUAGE_KEY = "AppleLanguages"

class ChangeLanguage {
    class func currentAppleLanguage() -> String{
        let userdef = UserDefaults.standard
        var currentWithoutLocale = "Base"
        if let langArray = userdef.object(forKey: APPLE_LANGUAGE_KEY) as? [String] {
            if var current = langArray.first {
                if let range = current.range(of: "-") {
                    current = String(current[..<range.lowerBound])
                }
                currentWithoutLocale = current
            }
        }
        return currentWithoutLocale
    }

    class func setAppleLAnguageTo(_ lang: String) {
        let userdef = UserDefaults.standard
        userdef.set([lang,currentAppleLanguage()], forKey: APPLE_LANGUAGE_KEY)
        userdef.synchronize()
    }
}
*/
