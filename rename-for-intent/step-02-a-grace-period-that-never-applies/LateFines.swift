
struct Loan {
    let d: Int
    let f: Bool
}

struct Fees {
    func calc(_ l: Loan) -> Double {
        if l.d <= 3 {
            return 0
        }
        let x = l.d - 14
        if x <= 0 {
            return 0
        }
        let r = l.f ? 0.10 : 0.25
        return min(Double(x) * r, 10.0)
    }
}

struct ReturnDesk {
    let fees = Fees()

    func receipt(_ l: Loan) -> String {
        "Late fine: $\(fees.calc(l))"
    }
}
