// Define the base sealed class for Checkout States
import 'failure_state.dart';
import 'models.dart';

sealed class CheckoutState {}

// Initial State
class CartReview extends CheckoutState {}

// Shipping Details State
class ShippingDetails extends CheckoutState {
  final ShippingInfo shippingInfo;

  ShippingDetails(this.shippingInfo);
}

// class MFARequired extends CheckoutState {
//   final String mfaToken;

//   MFARequired(this.mfaToken);
// }

// Payment Processing State
class PaymentProcessing extends CheckoutState {
  final PaymentInfo paymentInfo;

  PaymentProcessing(this.paymentInfo);
}

// Order Confirmation State
class OrderConfirmation extends CheckoutState {
  final OrderDetails orderDetails;

  OrderConfirmation(this.orderDetails);
}

// Checkout Error State
class CheckoutError extends CheckoutState {
  final CheckoutFailure failure;

  CheckoutError(this.failure);
}
