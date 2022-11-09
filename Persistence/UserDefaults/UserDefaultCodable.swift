//
//  UserDefaultCodable.swift
//  Persistence
//
//  Created by Егор Бадмаев on 08.11.2022.
//

/// UserDefaults property wrapper for `Codable` structures.
///
/// We need to use it instead of usual ``UserDefault`` because otherwise it will cause _"Attempt to set a non-property-list object as an UserDefaults"_ error.
@propertyWrapper
public struct UserDefaultCodable<T: Codable> {
    /// Key for user default setting.
    let key: String
    /// Default value for user default setting.
    let defaultValue: T
    /// UserDefaults container. `.standard` by default.
    var container: UserDefaults = .standard
    
    // MARK: - Init
    
    public init(key: String, defaultValue: T) {
        self.key = key
        self.defaultValue = defaultValue
    }
    
    // MARK: - Public Properties
    
    /// Wrapper of value to deal with `defaultValue` and different cases of usage.
    public var wrappedValue: T {
        get {
            if let data = UserDefaults.standard.object(forKey: key) as? Data,
               let user = try? JSONDecoder().decode(T.self, from: data) {
                return user
            }
            return  defaultValue
        }
        set {
            if let encoded = try? JSONEncoder().encode(newValue) {
                UserDefaults.standard.set(encoded, forKey: key)
            }
        }
    }
}
