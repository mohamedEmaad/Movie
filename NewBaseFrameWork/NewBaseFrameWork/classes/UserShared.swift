//
//  UserShared.swift
//  farh
//
//  Created by Yousef on 8/26/18.
//  Copyright © 2018 Ismael AlShabrawy. All rights reserved.
//

import Foundation

open class UserShared {
    static let instance = UserShared()
    let defaults = UserDefaults.standard
    
    var isFirstTime : Bool { get { return defaults.bool(forKey: FIRST_TIME) } set { defaults.set(newValue, forKey: FIRST_TIME)  } }
    
  
    var isLoggedIn : Bool {
        get {
            if !userToken.isEmpty && !userID.isEmpty {
                return true
            }else{
                return false
            }
        }
    }
    
    var userName : String { get { return defaults.string(forKey: USER_NAME_KEY) ?? "" } set { defaults.set(newValue, forKey: USER_NAME_KEY)  } }
    
    var userEmail : String { get { return defaults.string(forKey: USER_EMAIL_KEY) ?? "" } set { defaults.set(newValue, forKey: USER_EMAIL_KEY)  } }
    
    var userID : String { get { return defaults.string(forKey: USER_ID_KEY) ?? "" } set { defaults.set(newValue, forKey: USER_ID_KEY)  } }
    
    var userPhone : String { get { return defaults.string(forKey: USER_PHONE_KEY) ?? "" } set { defaults.set(newValue, forKey: USER_PHONE_KEY)  } }
    
    var userImage : String { get { return defaults.string(forKey: USER_IMAGE_KEY) ?? "" } set { defaults.set(newValue, forKey: USER_IMAGE_KEY )  } }
    
    var userToken : String { get { return defaults.string(forKey: USER_TOKEN_KEY) ?? "" } set { defaults.set(newValue, forKey: USER_TOKEN_KEY)  } }
    
    var userType : String { get { return defaults.string(forKey: USER_TYPE_KEY) ?? "" } set { defaults.set(newValue, forKey: USER_TYPE_KEY)  } }
    
    var genderType : String { get { return defaults.string(forKey: USER_GENDER_KEY) ?? "" } set { defaults.set(newValue, forKey: USER_GENDER_KEY)  } }
    
    var birthDate : String { get { return defaults.string(forKey: USER_BIRTH_DATE_KEY) ?? "" } set { defaults.set(newValue, forKey: USER_BIRTH_DATE_KEY)  } }

    var language : String { get { return defaults.string(forKey: LANGUAGE ) ?? "" } set { defaults.set(newValue, forKey: LANGUAGE)  } }
    
     var applicationType : String { get { return defaults.string(forKey: APPLICATION_TYPE ) ?? "" } set { defaults.set(newValue, forKey: APPLICATION_TYPE)  } }

     var notificationActive : Bool { get { return defaults.bool(forKey: NOTIFICATION_ACTIVE) } set { defaults.set(newValue, forKey: NOTIFICATION_ACTIVE)  } }

    func saveUserDefaults( user_FullName: String, userEmail: String, user_Id: Int, user_Phone: String, user_Roll: String, user_Image: String, user_Token: String){
        
        self.userName = user_FullName
        self.userEmail = userEmail
        self.userID = String(user_Id)
        self.userPhone = user_Phone
        self.userImage = user_Image
        self.userToken = user_Token
        
    }
    
    func signout() {
        let lang = Language.currentLanguage()
        self.isFirstTime = true
        self.defaults.removePersistentDomain(forName: Bundle.main.bundleIdentifier!)
        self.defaults.synchronize()
        self.userToken = ""
        self.language = lang
        Language.setAppLanguage(lang: lang)
    }
}

