//: Playground - noun: a place where people can play

import UIKit
import XCTest

struct Person {
  let name: String
}

protocol Database {
  func save(person: Person)
}

protocol DatabaseLocator {
  func database() -> Database
}

final class DatabaseImpl: Database {
  func save(person: Person) {
    print("Saving \(person.name)")
  }
}

extension DatabaseLocator {
  func database() -> Database {
    return DatabaseImpl()
  }
}


protocol Fetcher {
  func fetch() -> Person
}

protocol FetcherLocator {
  func fetcher() -> Fetcher
}

final class FetcherImpl: Fetcher {
  func fetch() -> Person {
    return Person(name: "Alex Salom")
  }
}

extension FetcherLocator {
  func fetcher() -> Fetcher {
    return FetcherImpl()
  }
}

final class PeopleManager {
  typealias ServiceLocator = DatabaseLocator & FetcherLocator
  final class ServiceLocatorImpl: ServiceLocator {}
  
  private let database: Database
  private let fetcher: Fetcher
  
  init(serviceLocator: ServiceLocator = ServiceLocatorImpl()) {
    self.database = serviceLocator.database()
    self.fetcher = serviceLocator.fetcher()
  }
  
  func person() -> Person {
    return fetcher.fetch()
  }
  
  func addPerson() {
    let person = Person(name: "Nick Cave")
    database.save(person: person)
  }
}

let peopleManager = PeopleManager()
peopleManager.person().name
peopleManager.addPerson()
