# Persistence

Layer responsible for persistant data storage of the application

## Use cases

### User Defaults
Just call for example `UserDefaults.favouriteRecipes`. All user defaults keys are described in [UserDefaults.swift](/Persistence/Sources/UserDefaults/UserDefaults.swift).

### Core Data

In this case, we have `CoreDataManagerProtocol` - typealias of another two protocols for working with `Step` and `Recipe` managed object models.

```swift
public typealias CoreDataManagerProtocol = CDRecipeProtocol & CDStepProtocol
```

## User Defaults

For working with User Defaults, we have implemented 2 property wrappers:

- [Usual](/Persistence/Sources/UserDefaults/UserDefault.swift)
- [For `Codable` models](/Persistence/Sources/UserDefaults/UserDefaultCodable.swift)

## Core Data

For working with Core Data we have implemented Core Data manager - the only place where `import CoreData` is placed.

It has 2 initializers:

- Usual init
- For unit-tests with `NSInMemoryStoreType` description for `NSPersistentContainer`

---

For more details, read [GitHub Wiki] documentation(https://github.com/iCookbook/Persistence/wiki)
