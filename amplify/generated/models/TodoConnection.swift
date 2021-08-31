// swiftlint:disable all
import Amplify
import Foundation

public struct TodoConnection: Embeddable {
  var items: [Todo?]?
  var nextToken: String?
}