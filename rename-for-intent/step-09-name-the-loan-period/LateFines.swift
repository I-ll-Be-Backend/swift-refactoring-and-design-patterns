
struct Loan {
    let daysOut: Int
    let isStudent: Bool
}

private let loanDays = 14

struct Fees {
    func calc(_ loan: Loan) -> Double {
        let daysLate = loan.daysOut - loanDays
        if daysLate <= 0 {
            return 0
        }
        let dailyRate = loan.isStudent ? 0.10 : 0.25
        return min(Double(daysLate) * dailyRate, 10.0)
    }
}

struct ReturnDesk {
    let fees = Fees()

    func receipt(_ loan: Loan) -> String {
        "Late fine: $\(fees.calc(loan))"
    }
}
