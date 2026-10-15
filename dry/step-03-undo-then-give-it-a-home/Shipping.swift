struct Cart {
    let subtotal: Double
    let member: Bool
}
struct Checkout {
    func shippingFee(_ cart: Cart) -> Double {
        if cart.subtotal >= 50.0 {
            return 0.0
        }
        return 4.99
    }
}

struct CartBanner {
    func message(_ cart: Cart) -> String {
        if cart.subtotal < 50.0 {
            let missing = 50.0 - cart.subtotal
            return "Add $\(missing) to ship free"
        }
        return "Your order ships free"
    }
}

struct OrderEmail {
    func shippingLine(_ cart: Cart) -> String {
        let free = cart.subtotal >= 50.0
        return "Shipping: " + (free ? "free" : "$4.99")
    }
}
