struct Ticket {
    let minutes: Int
    let electric: Bool
    var hours: Double { (Double(minutes) / 60).rounded(.up) }
}
enum ParkingFee {
    static func fee(_ t: Ticket) -> Double {
        var f = 0.0
        f = t.hours * 3.0
        f = min(f, 20.0)
        f = t.minutes <= 15 ? 0 : f
        return f
    }

    static func charge(_ t: Ticket) -> Double {
        fee(t)
    }
}
