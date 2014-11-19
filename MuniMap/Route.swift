import Foundation

struct Route : Printable {
    var name : String
    var code : String
    var inboundName : String?
    var outboundName : String?

    var description: String {
        return "\(name) - \(code), from \(inboundName) to \(outboundName)\n"
    }
}
