struct Cart {
    let subtotal: Double
    let member: Bool
}
enum ShippingPolicy {
    private static let freeShippingFrom = 50.0
    static let fee = 4.99

    static func shipsFree(_ cart: Cart) -> Bool {
        cart.subtotal >= freeShippingFrom
    }

    static func amountToFree(_ cart: Cart) -> Double {
        freeShippingFrom - cart.subtotal
    }
}

struct Checkout {
    func shippingFee(_ cart: Cart) -> Double {
        if ShippingPolicy.shipsFree(cart) {
            return 0.0
        }
        return ShippingPolicy.fee
    }
}

struct CartBanner {
    func message(_ cart: Cart) -> String {
        if !ShippingPolicy.shipsFree(cart) {
            let missing = ShippingPolicy.amountToFree(cart)
            return "Add $\(missing) to ship free"
        }
        return "Your order ships free"
    }
}

struct OrderEmail {
    func shippingLine(_ cart: Cart) -> String {
        let free = ShippingPolicy.shipsFree(cart)
        return "Shipping: " + (free ? "free" : "$\(ShippingPolicy.fee)")
    }
}
