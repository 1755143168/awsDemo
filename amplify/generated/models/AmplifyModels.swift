// swiftlint:disable all
import Amplify
import Foundation

// Contains the set of classes that conforms to the `Model` protocol. 

final public class AmplifyModels: AmplifyModelRegistration {
  public let version: String = "5103454605190ce286594daa01b44253"
  
  public func registerModels(registry: ModelRegistry.Type) {
    ModelRegistry.register(modelType: Todo.self)
  }
}