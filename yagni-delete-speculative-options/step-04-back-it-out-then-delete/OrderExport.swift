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
        <key>format</key><string>csv</string>
        <key>delimiter</key><string>,</string>
        <key>header</key><true/>
    </dict>
</dict>
*/
struct ExportConfig {
    let format: String
    let delimiter: String
    let header: Bool
}

struct OrderExport {
    private let format: String
    private let delimiter: String
    private let header: Bool

    init(_ cfg: ExportConfig) {
        format = cfg.format
        delimiter = cfg.delimiter
        header = cfg.header
    }

    func export(_ orders: [Order]) -> String {
        var out = ""
        if header && format == "csv" {
            out += "id\(delimiter)total\n"
        }
        for o in orders {
            let row = switch format {
            case "csv": "\(o.id)\(delimiter)\(o.total)"
            case "json": "{\"id\":\"\(o.id)\",\"total\":\(o.total)}"
            case "xml": "<order id=\"\(o.id)\" total=\"\(o.total)\"/>"
            default: fatalError("unknown format \(format)")
            }
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
