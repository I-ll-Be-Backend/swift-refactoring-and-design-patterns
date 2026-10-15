
struct Loan {
    let daysOut: Int
    let isStudent: Bool
}

private let loanDays = 14
private let graceDays = 3
private let studentRate = 0.10
private let standardRate = 0.25
private let maxFine = 10.0

struct Fees {
    func overdueFine(_ loan: Loan) -> Double {
        let daysLate = loan.daysOut - loanDays
        if daysLate <= graceDays {
            return 0
        }
        let dailyRate = loan.isStudent ? studentRate : standardRate
        return min(Double(daysLate) * dailyRate, maxFine)
    }
}

struct ReturnDesk {
    let fees = Fees()

    func receipt(_ loan: Loan) -> String {
        "Late fine: $\(fees.overdueFine(loan))"
    }
}
