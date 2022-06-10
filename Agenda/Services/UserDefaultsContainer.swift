//
//  UserDefaultsContainer.swift
//  Agenda
//
//  Created by Егор Бадмаев on 10.06.2022.
//

import Foundation

final class UserDefaultsContainer<K: CodingKey> {
    private let userDefaults: UserDefaults
    
    public init(keyedBy: K.Type, userDefaults: UserDefaults = .standard) {
        self.userDefaults = userDefaults
    }
    
    public subscript<T>(key: K) -> T? {
        get { getValue(forKey: key.stringValue) as? T }
        set { set(value: newValue, forKey: key.stringValue) }
    }
    
    public subscript<T>(key: K) -> T? where T: RawRepresentable {
        get {
            if let rawValue = getValue(forKey: key.stringValue) as? T.RawValue {
                return T(rawValue: rawValue)
            } else {
                return nil
            }
        }
        set {
            set(value: newValue?.rawValue, forKey: key.stringValue)
        }
    }
    
    private func set(value: Any?, forKey key: String) {
        if let value = value {
            userDefaults.set(value, forKey: key)
        } else {
            userDefaults.removeObject(forKey: key)
        }
    }
    
    private func getValue(forKey key: String) -> Any? {
        return userDefaults.object(forKey: key)
    }
}
