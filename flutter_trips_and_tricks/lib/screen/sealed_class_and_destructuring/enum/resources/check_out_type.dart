// enum CheckoutFailure {
//   paymentDeclined(String reason),
//   paymentTimeout,
//   invalidAddress(String field),
//   outOfStock(String productId),
//   unknownFailure(String message);

//   // Field to hold additional data
//   final String? message;

//   // Constructor for failures with associated data
//   const CheckoutFailure._internal([this.message]);

//   const CheckoutFailure.paymentDeclined(String reason) : this._internal(reason);

//   const CheckoutFailure.invalidAddress(String field) : this._internal(field);

//   const CheckoutFailure.outOfStock(String productId) : this._internal(productId);

//   const CheckoutFailure.unknownFailure(String message) : this._internal(message);

//   // Constructor for failures without additional data
//   const CheckoutFailure.paymentTimeout() : this._internal();
// }

enum CheckoutStateType {
  cartReview,
  shippingDetails,
  paymentProcessing,
  //mfaRequired,
  orderConfirmation,
  checkoutError,
}
