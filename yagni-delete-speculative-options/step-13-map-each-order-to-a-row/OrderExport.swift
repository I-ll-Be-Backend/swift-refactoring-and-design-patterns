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
        let rows = orders.map { o in
            "\(o.id),\(o.total),\(o.postalCode)\n"
        }
        return "id,total,postalCode\n" + rows.joined()
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
