
struct Loan {
    let daysOut: Int
    let isStudent: Bool
}

struct Fees {
    func calc(_ l: Loan) -> Double {
        let daysLate = l.daysOut - 14
        if daysLate <= 0 {
            return 0
        }
        let dailyRate = l.isStudent ? 0.10 : 0.25
        return min(Double(daysLate) * dailyRate, 10.0)
    }
}

struct ReturnDesk {
    let fees = Fees()

    func receipt(_ l: Loan) -> String {
        "Late fine: $\(fees.calc(l))"
    }
}
