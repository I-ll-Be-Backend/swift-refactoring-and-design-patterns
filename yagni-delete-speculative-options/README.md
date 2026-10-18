# YAGNI: delete speculative options, in Swift

> Delete the settings nobody uses, so each new column is a two-line change.

[Watch the video](https://www.youtube.com/watch?v=e_tlDuB2-0M) · [Step through it interactively](https://illbebackend.dev/lessons/yagni-delete-speculative-options/swift/)

## The problem

The warehouse wants the postal code as a third column. The header and all three cases of the format switch change.

## Steps

Each folder holds the complete `OrderExport.swift` after that step, and every one compiles. Diff two neighbouring folders to see a single refactoring.

| Step | What changes | Move |
|---|---|---|
| [01](step-01-an-export-with-three-settings/) | An export with three settings: OrderExport copies a format, a delimiter and a header flag out of Config.plist. NightlyJob uploads the result to the warehouse. | Before |
| [02](step-02-one-column-four-edits/) | One column, four edits: The warehouse wants the postal code as a third column. The header and all three cases of the format switch change. | Code smell |
| [03](step-03-two-formats-nobody-reads/) | Two formats nobody reads: Config.plist says csv and the only caller uploads CSV. The JSON and XML cases never run. | Code smell |
| [04](step-04-back-it-out-then-delete/) | Back it out, then delete: The postal code comes out. We remove the options nobody uses first, and add the column afterwards. | Plan |
| [05](step-05-delete-the-xml-case/) | Delete the XML case: No config value picks xml and no caller reads it, so the case goes. | Remove Dead Code |
| [06](step-06-delete-the-json-case/) | Delete the JSON case: JSON goes for the same reason. The switch is down to csv and a default that stops the program. | Remove Dead Code |
| [07](step-07-format-can-only-be-csv/) | Format can only be csv: The format property goes. The switch collapses to the CSV row, the header test only checks header, and format leaves Config.plist. | Remove Field |
| [08](step-08-the-delimiter-is-always-a-comma/) | The delimiter is always a comma: The comma goes straight into the header and the row. The delimiter property and its config key go. | Remove Field |
| [09](step-09-the-header-is-always-on/) | The header is always on: header is always true, so the branch that skips it is dead code. The if goes, then the property and its config key. | Remove Field |
| [10](step-10-nothing-left-to-configure/) | Nothing left to configure: The initializer, ExportConfig and the job's config property go. The export dictionary leaves Config.plist. | Remove Parameter |
| [11](step-11-the-postal-code-in-two-edits/) | The postal code, in two edits: One new name in the header and one new value in the row. The loop, the return and NightlyJob didn't change. | Payoff |
| [12](step-12-a-string-you-keep-appending-to/) | A string you keep appending to: out starts empty, grows in a loop, and every row adds its own newline before the method hands out back. | Swift bonus |
| [13](step-13-map-each-order-to-a-row/) | Map each order to a row: map turns each order into its row with a trailing closure, and joined puts the rows together after the header. | map and joined |

## Takeaways

- **Use it when:** An option has one value in the config and no caller uses the other branches.
- **Skip it when:** A second user is real and dated, like a signed contract for a JSON partner, or ops change the value per environment.
- **Spot it by:** Config values that never change, switch cases no caller reaches, defaults no caller overrides.
