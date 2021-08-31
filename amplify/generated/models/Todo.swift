// swiftlint:disable all
import Amplify
import Foundation

public struct Todo: Model {
  public let id: String
  public var name: String
  public var description: String?
  public var password: String?
  public var createdAt: Temporal.DateTime?
  public var updatedAt: Temporal.DateTime?
  
  public init(id: String = UUID().uuidString,
      name: String,
      description: String? = nil,
      password: String? = nil) {
    self.init(id: id,
      name: name,
      description: description,
      password: password,
      createdAt: nil,
      updatedAt: nil)
  }
  internal init(id: String = UUID().uuidString,
      name: String,
      description: String? = nil,
      password: String? = nil,
      createdAt: Temporal.DateTime? = nil,
      updatedAt: Temporal.DateTime? = nil) {
      self.id = id
      self.name = name
      self.description = description
      self.password = password
      self.createdAt = createdAt
      self.updatedAt = updatedAt
  }
}