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

struct Parcel {
    let weightKg: Double
    let lengthCm: Double
    let widthCm: Double
    let heightCm: Double
}

struct ShippingService {
    let rates: RateTable

    func quote(from: Address, to: Address, parcel: Parcel,
               express: Bool) -> Quote {
        let cost = price(from: from, to: to, parcel: parcel,
                         express: express)
        return Quote(fromPostal: from.postal, toPostal: to.postal,
                     price: cost)
    }

    private func price(from: Address, to: Address, parcel: Parcel,
                       express: Bool) -> Double {
        var cost = rates.perKg(from: from.country, to: to.country) *
            billableKg(of: parcel)
        if express { cost *= 1.5 }
        return cost
    }

    private func billableKg(of parcel: Parcel) -> Double {
        let volumetricKg = parcel.lengthCm * parcel.widthCm *
            parcel.heightCm / 5000
        return max(parcel.weightKg, volumetricKg)
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
        let to = Address(postal: customer.postalCode,
                         country: customer.country)
        let parcel = Parcel(weightKg: cart.weightKg,
                            lengthCm: cart.lengthCm,
                            widthCm: cart.widthCm,
                            heightCm: cart.heightCm)
        return shipping.quote(from: from, to: to, parcel: parcel,
                              express: cart.express)
    }
}
