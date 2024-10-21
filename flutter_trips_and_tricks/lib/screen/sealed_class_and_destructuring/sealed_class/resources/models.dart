// Shipping Information
class ShippingInfo {
  final String address;
  final String city;
  final String postalCode;

  ShippingInfo(this.address, this.city, this.postalCode);
}

// Payment Information
class PaymentInfo {
  final String cardNumber;
  final String expiryDate;

  PaymentInfo(this.cardNumber, this.expiryDate);
}

// Order Details
class OrderDetails {
  final String orderId;
  final List<String> items;

  OrderDetails(this.orderId, this.items);
}
