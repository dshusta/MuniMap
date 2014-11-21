import Foundation

struct Stop : Printable {
    var name : String
    var stopCode : String

    var description : String {
        return "\(name) - \(stopCode)"
    }
}
