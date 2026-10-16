import Foundation

struct Booking {
    let checkIn: Date
    let total: Double
    let nights: Int
    let rate: Character
    let isLoyal: Bool
}

extension Date {
    func days(until other: Date) -> Int {
        Calendar.current.dateComponents([.day], from: self, to: other).day ?? 0
    }
}
enum CancellationPolicy {
    private static let freeCancellationDays = 14

    static func fee(_ b: Booking, today: Date) -> Double {
        let daysBeforeCheckIn = today.days(until: b.checkIn)
        // free cancellation 14 days or more before check-in
        if daysBeforeCheckIn >= freeCancellationDays { return 0 }
        // non-refundable or under 2 days out: pay in full
        if b.rate == "N" || daysBeforeCheckIn < 2 { return b.total }
        // otherwise half the total
        let f = b.total * 0.5
        // partner contracts require a one-night minimum
        return max(f, b.total / Double(b.nights))
    }
}
