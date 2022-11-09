//
//  UserDefault.swift
//  Expense
//
//  Created by Егор Бадмаев on 30.07.2022.
//

@propertyWrapper
public struct UserDefault<Value> {
    /// Key for user default setting.
    let key: String
    /// Default value for user default setting.
    let defaultValue: Value
    /// UserDefaults container. `.standard` by default.
    var container: UserDefaults = .standard
    
    /// Wrapper of value to deal with `defaultValue` and different cases of usage.
    public var wrappedValue: Value {
        get {
            return container.object(forKey: key) as? Value ?? defaultValue
        }
        set {
            /// Check whether we're dealing with an optional and remove the object if the new value is `nil`.
            if let optional = newValue as? AnyOptional, optional.isNil {
                container.removeObject(forKey: key)
            } else {
                container.set(newValue, forKey: key)
            }
        }
    }
}

/// We define a new initializer in `extension` so as not  to lose memberwise initializer
extension UserDefault where Value: ExpressibleByNilLiteral {
    /// Creates a new UserDefaults property wrapper for the given key with `nil` as the ``defaultValue``.
    ///
    /// - Parameters:
    ///   - key: The key to use with the UserDefaults store.
    ///   - container: Defaults object to share data in. A default value is `standard`.
    public init(key: String, _ container: UserDefaults = .standard) {
        self.init(key: key, defaultValue: nil, container: container)
    }
}
