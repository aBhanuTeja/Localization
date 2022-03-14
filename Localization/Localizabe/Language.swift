import UIKit

let APPLE_LANGUAGE_KEY = "AppleLanguages"

class Language {
    class func currentAppLanguage() -> String{
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

    class func currentAppLanguageFull() -> String{
        let userdef = UserDefaults.standard
        let langArray = userdef.object(forKey: APPLE_LANGUAGE_KEY) as! NSArray
        let current = langArray.firstObject as! String
        return current
    }
    
    class func setAppLanguageTo(_ lang: String) {
        let userdef = UserDefaults.standard
        userdef.set([lang, currentAppLanguage()], forKey: APPLE_LANGUAGE_KEY)
        userdef.synchronize()
    }

    class var isRTL: Bool {
        return Language.currentAppLanguage() == "ar"
    }
}
