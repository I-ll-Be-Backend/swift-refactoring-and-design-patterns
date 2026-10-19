protocol RateTable {
    func perKg(from: String, to: String) -> Double
}
struct Quote {
    let fromPostal: String
    let toPostal: String
    let price: Double
}
struct Cart {
    let weightKg: Double
    let lengthCm: Double
    let widthCm: Double
    let heightCm: Double
    let express: Bool
    let fragile: Bool
}
struct Customer {
    let postalCode: String
    let country: String
}
struct ShippingService {
    let rates: RateTable

    func quote(fromPostal: String, fromCountry: String,
               toPostal: String, toCountry: String, weightKg: Double,
               lengthCm: Double, widthCm: Double, heightCm: Double,
               express: Bool) -> Quote {
        let cost = price(fromCountry: fromCountry, toCountry: toCountry,
                         weightKg: weightKg, lengthCm: lengthCm,
                         widthCm: widthCm, heightCm: heightCm,
                         express: express)
        return Quote(fromPostal: fromPostal, toPostal: toPostal, price: cost)
    }

    private func price(fromCountry: String, toCountry: String,
                       weightKg: Double, lengthCm: Double,
                       widthCm: Double, heightCm: Double,
                       express: Bool) -> Double {
        let volumetricKg = lengthCm * widthCm * heightCm / 5000
        var cost = rates.perKg(from: fromCountry, to: toCountry) *
            max(weightKg, volumetricKg)
        if express { cost *= 1.5 }
        return cost
    }
}

enum Warehouse {
    static let postal = "10115"
    static let country = "DE"
}

struct Checkout {
    let shipping: ShippingService

    func shippingQuote(for cart: Cart, to customer: Customer) -> Quote {
        return shipping.quote(
            fromPostal: Warehouse.postal, fromCountry: Warehouse.country,
            toPostal: customer.postalCode, toCountry: customer.country,
            weightKg: cart.weightKg, lengthCm: cart.lengthCm,
            widthCm: cart.widthCm, heightCm: cart.heightCm,
            express: cart.express)
    }
}
