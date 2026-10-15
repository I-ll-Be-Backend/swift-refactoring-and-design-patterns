struct Cart {
    let subtotal: Double
    let member: Bool
}
enum ShippingPolicy {
    static let freeShippingFrom = 50.0
}

struct Checkout {
    func shippingFee(_ cart: Cart) -> Double {
        if cart.subtotal >= ShippingPolicy.freeShippingFrom {
            return 0.0
        }
        return 4.99
    }
}

struct CartBanner {
    func message(_ cart: Cart) -> String {
        if cart.subtotal < ShippingPolicy.freeShippingFrom {
            let missing = ShippingPolicy.freeShippingFrom - cart.subtotal
            return "Add $\(missing) to ship free"
        }
        return "Your order ships free"
    }
}

struct OrderEmail {
    func shippingLine(_ cart: Cart) -> String {
        let free = cart.subtotal >= ShippingPolicy.freeShippingFrom
        return "Shipping: " + (free ? "free" : "$4.99")
    }
}
