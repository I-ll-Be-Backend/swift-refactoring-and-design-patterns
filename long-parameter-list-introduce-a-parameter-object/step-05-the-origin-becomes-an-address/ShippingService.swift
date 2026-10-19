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
struct Address {
    let postal: String
    let country: String
}

struct ShippingService {
    let rates: RateTable

    func quote(from: Address,
               toPostal: String, toCountry: String, weightKg: Double,
               lengthCm: Double, widthCm: Double, heightCm: Double,
               express: Bool) -> Quote {
        let cost = price(from: from, toCountry: toCountry,
                         weightKg: weightKg, lengthCm: lengthCm,
                         widthCm: widthCm, heightCm: heightCm,
                         express: express)
        return Quote(fromPostal: from.postal, toPostal: toPostal, price: cost)
    }

    private func price(from: Address, toCountry: String,
                       weightKg: Double, lengthCm: Double,
                       widthCm: Double, heightCm: Double,
                       express: Bool) -> Double {
        let volumetricKg = lengthCm * widthCm * heightCm / 5000
        var cost = rates.perKg(from: from.country, to: toCountry) *
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
        let from = Address(postal: Warehouse.postal,
                           country: Warehouse.country)
        return shipping.quote(
            from: from,
            toPostal: customer.postalCode, toCountry: customer.country,
            weightKg: cart.weightKg, lengthCm: cart.lengthCm,
            widthCm: cart.widthCm, heightCm: cart.heightCm,
            express: cart.express)
    }
}
