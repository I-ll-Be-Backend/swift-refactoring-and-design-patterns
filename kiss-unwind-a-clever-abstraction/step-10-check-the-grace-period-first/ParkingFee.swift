struct Ticket {
    let minutes: Int
    let electric: Bool
    var hours: Double { (Double(minutes) / 60).rounded(.up) }
}
enum ParkingFee {
    static func fee(_ t: Ticket) -> Double {
        guard t.minutes > 15 else { return 0 }
        return min(t.hours * 3.0, 20.0)
    }

    static func charge(_ t: Ticket) -> Double {
        fee(t)
    }
}
