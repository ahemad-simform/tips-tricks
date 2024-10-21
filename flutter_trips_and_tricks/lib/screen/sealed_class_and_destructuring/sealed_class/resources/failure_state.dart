// Base sealed class for Checkout Failures
sealed class CheckoutFailure {}

// Payment Failures
class PaymentDeclined extends CheckoutFailure {
  final String reason;

  PaymentDeclined(this.reason);
}

class PaymentTimeout extends CheckoutFailure {}

// Shipping Failures
class InvalidAddress extends CheckoutFailure {
  final String field;

  InvalidAddress(this.field);
}

// // Inventory Failures
// class OutOfStock extends CheckoutFailure {
//   final String productId;

//   OutOfStock(this.productId);
// }

// Unknown Failures
class UnknownFailure extends CheckoutFailure {
  final String message;

  UnknownFailure(this.message);
}
