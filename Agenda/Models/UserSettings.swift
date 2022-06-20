//
//  UserSettings.swift
//  Agenda
//
//  Created by Егор Бадмаев on 10.06.2022.
//

fileprivate enum SettingsKey: CodingKey {
    case hasOnboarded
    case summaries
}

struct UserSettings {
    private let storage = UserDefaultsContainer(keyedBy: SettingsKey.self)
    
    var hasOnboarded: Bool? {
        get { storage[.hasOnboarded] }
        set { storage[.hasOnboarded] = newValue }
    }
    
    var summaries: [Int]? {
        get { storage[.summaries] }
        set { storage[.summaries] = newValue}
    }
}
