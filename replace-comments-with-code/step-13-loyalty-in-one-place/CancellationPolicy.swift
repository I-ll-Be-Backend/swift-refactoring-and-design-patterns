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
    private static let loyaltyFreeDays = 7
    private static let lastMinuteDays = 2
    private static let nonRefundable: Character = "N"

    static func fee(_ b: Booking, today: Date) -> Double {
        let daysBeforeCheckIn = today.days(until: b.checkIn)
        if isFreeCancellation(b, days: daysBeforeCheckIn) { return 0 }
        if paysInFull(b, days: daysBeforeCheckIn) { return b.total }
        let halfTotal = b.total * 0.5
        // partner contracts require a one-night minimum
        return max(halfTotal, nightlyPrice(b))
    }

    private static func isFreeCancellation(_ b: Booking, days: Int) -> Bool {
        if b.isLoyal { return days >= loyaltyFreeDays }
        return days >= freeCancellationDays
    }

    private static func paysInFull(_ b: Booking, days: Int) -> Bool {
        b.rate == nonRefundable || days < lastMinuteDays
    }

    private static func nightlyPrice(_ b: Booking) -> Double {
        b.total / Double(b.nights)
    }
}
