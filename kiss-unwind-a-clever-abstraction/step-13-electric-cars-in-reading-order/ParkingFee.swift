struct Ticket {
    let minutes: Int
    let electric: Bool
    var hours: Double { (Double(minutes) / 60).rounded(.up) }
}
enum ParkingFee {
    private static let hourlyRate = 3.0
    private static let dailyCap = 20.0
    private static let graceMinutes = 15
    private static let evFreeHours = 2.0

    static func charge(_ t: Ticket) -> Double {
        guard t.minutes > graceMinutes else { return 0 }
        let freeHours = t.electric ? evFreeHours : 0
        let hours = max(0, t.hours - freeHours)
        return min(hours * hourlyRate, dailyCap)
    }
}
