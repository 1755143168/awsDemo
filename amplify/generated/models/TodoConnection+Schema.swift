// swiftlint:disable all
import Amplify
import Foundation

extension TodoConnection {
  // MARK: - CodingKeys 
   public enum CodingKeys: String, ModelKey {
    case items
    case nextToken
  }
  
  public static let keys = CodingKeys.self
  //  MARK: - ModelSchema 
  
  public static let schema = defineSchema { model in
    let todoConnection = TodoConnection.keys
    
    model.pluralName = "TodoConnections"
    
    model.fields(
      .field(todoConnection.items, is: .optional, ofType: .embeddedCollection(of: Todo.self)),
      .field(todoConnection.nextToken, is: .optional, ofType: .string)
    )
    }
}