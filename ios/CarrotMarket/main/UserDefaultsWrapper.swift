//
//  UserDefaultsWrapper.swift
//  ios
//
//  Created by 태로고침 on 2020/09/08.
//  Copyright © 2020 Jerry Jung. All rights reserved.
//

import Foundation

//shoud be..
class UserDefaultsWrapper {

    // MARK: - singleton
    
    static let wrapper = UserDefaultsWrapper()

    // MARK: - getters

    func getUserName() -> String? {
        return UserDefaults.standard.value(forKey: userNameKey) as? String
    }

    
    // MARK: - setters
    
    func store(userName: String) {
         UserDefaults.standard.set(userName, forKey: userNameKey)
    }

    
    // MARK: - private keyNames
    
    private let userNameKey  = "userName"
    
}
