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
        <key>delimiter</key><string>,</string>
        <key>header</key><true/>
    </dict>
</dict>
*/
struct ExportConfig {
    let delimiter: String
    let header: Bool
}

struct OrderExport {
    private let delimiter: String
    private let header: Bool

    init(_ cfg: ExportConfig) {
        delimiter = cfg.delimiter
        header = cfg.header
    }

    func export(_ orders: [Order]) -> String {
        var out = ""
        if header {
            out += "id\(delimiter)total\n"
        }
        for o in orders {
            let row = "\(o.id)\(delimiter)\(o.total)"
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
