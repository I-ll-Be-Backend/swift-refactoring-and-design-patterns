struct Ticket {
    let minutes: Int
    let electric: Bool
    var hours: Double { (Double(minutes) / 60).rounded(.up) }
}
typealias Rule = (Ticket, Double) -> Double

enum ParkingFee {
    static let rules: [String: Rule] = [
        "base": { t, _ in t.hours * 3.0 },
        "cap": { _, f in min(f, 20.0) },
        "grace": { t, f in t.minutes <= 15 ? 0 : f },
    ]

    static func fee(_ t: Ticket) -> Double {
        var f = 0.0
        f = t.hours * 3.0
        f = rules["cap"]!(t, f)
        f = rules["grace"]!(t, f)
        return f
    }

    static func charge(_ t: Ticket) -> Double {
        fee(t)
    }
}
