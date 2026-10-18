struct Order {
    let id: String
    let total: Double
    let postalCode: String
}
protocol OrderRepo { func today() -> [Order] }
protocol Warehouse { func uploadCsv(_ csv: String) }
/* Config.plist
<dict>
    <key>export</key>
    <dict>
    </dict>
</dict>
*/
struct ExportConfig {}

struct OrderExport {
    init(_ cfg: ExportConfig) {}

    func export(_ orders: [Order]) -> String {
        var out = ""
        out += "id,total\n"
        for o in orders {
            let row = "\(o.id),\(o.total)"
            out += row + "\n"
        }
        return out
    }
}

struct NightlyJob {
    let config: ExportConfig
    let orders: OrderRepo
    let warehouse: Warehouse

    func run() {
        let csv = OrderExport(config).export(orders.today())
        warehouse.uploadCsv(csv)
    }
}
