struct Order {
    let id: String
    let total: Double
    let postalCode: String
}
protocol OrderRepo { func today() -> [Order] }
protocol Warehouse { func uploadCsv(_ csv: String) }
/* Config.plist
<dict>
</dict>
*/

struct OrderExport {
    func export(_ orders: [Order]) -> String {
        var out = ""
        out += "id,total,postalCode\n"
        for o in orders {
            let row = "\(o.id),\(o.total),\(o.postalCode)"
            out += row + "\n"
        }
        return out
    }
}

struct NightlyJob {
    let orders: OrderRepo
    let warehouse: Warehouse

    func run() {
        let csv = OrderExport().export(orders.today())
        warehouse.uploadCsv(csv)
    }
}
