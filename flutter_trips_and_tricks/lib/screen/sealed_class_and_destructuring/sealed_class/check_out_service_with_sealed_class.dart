import 'resources/check_out_state.dart';
import 'resources/failure_state.dart';
import 'resources/models.dart';

class CheckoutServiceWithSealedClass {
  CheckoutState _state = CartReview();

  CheckoutState get state => _state;

  void proceed() {
    _state = match(_state);
    _handleState(_state);
  }

  CheckoutState match(CheckoutState state) {
    switch (state) {
      case CartReview():
        print('Reviewing Cart...');
        // Transition to Shipping Details
        return ShippingDetails(ShippingInfo('123 Main St', 'Anytown', '12345'));

      case ShippingDetails(shippingInfo: var info) when _validateShipping(info):
        // Transition to Payment Processing
        return PaymentProcessing(PaymentInfo('4111111111111111', '12/24'));

      case ShippingDetails():
        // Invalid shipping info
        return CheckoutError(InvalidAddress('postalCode'));

      case PaymentProcessing(paymentInfo: var payment)
          when _processPayment(payment):

        // // Out of stock
        // return CheckoutError(OutOfStock('PROD123'));
        // Transition to Order Confirmation
        return OrderConfirmation(OrderDetails('ORD123456', ['Item1', 'Item2']));
      //return MFARequired('MFA_TOKEN_ABC123');

      case PaymentProcessing():
        return CheckoutError(PaymentDeclined('Card declined'));

      // case MFARequired(mfaToken: var token):
      //   // Simulate MFA verification
      //   if (_verifyMFA(token)) {
      //     // Transition to Order Confirmation
      //     return OrderConfirmation(
      //         OrderDetails('ORD123456', ['Item1', 'Item2']));
      //   } else {
      //     // MFA failed
      //     return CheckoutError(UnknownFailure('MFA Verification Failed'));
      //   }

      // case MFARequired(mfaToken: var token) when _verifyMFA(token):
      //   // Simulate MFA verification
      //   return OrderConfirmation(OrderDetails('ORD123456', ['Item1', 'Item2']));

      // case MFARequired():
      //   // MFA failed
      //   return CheckoutError(UnknownFailure('MFA Verification Failed'));

      case OrderConfirmation():
        // Checkout complete
        print('Order confirmed: ${(state).orderDetails.orderId}');
        return state;

      case CheckoutError(failure: var failure):
        // Handle errors or retry
        print('Checkout failed due to: ${_describeFailure(failure)}');
        return state;
    }
  }

  bool _validateShipping(ShippingInfo info) {
    // Implement validation logic
    return info.postalCode.length == 5;
  }

  bool _processPayment(PaymentInfo payment) {
    // Implement payment processing logic
    // Simulate a successful payment
    return true;
  }

  // bool _verifyMFA(String token) {
  //   // Simulate MFA verification logic
  //   return token == 'MFA_TOKEN_ABC123';
  // }

  String _describeFailure(CheckoutFailure failure) {
    switch (failure) {
      case PaymentDeclined(reason: var reason):
        return 'Payment Declined: $reason';
      case PaymentTimeout():
        return 'Payment Timeout';
      case InvalidAddress(field: var field):
        return 'Invalid Address Field: $field';
      // case OutOfStock(productId: var id):
      //   return 'Product Out of Stock: $id';
      case UnknownFailure(message: var msg):
        return 'Unknown Failure: $msg';
    }
  }

  void _handleState(CheckoutState state) {
    switch (state) {
      case CartReview():
        print('Reviewing Cart...');
      case ShippingDetails(shippingInfo: var info):
        print('Entering Shipping Details: ${info.address}, ${info.city}');
      case PaymentProcessing(paymentInfo: var payment):
        print('Processing Payment: ${payment.cardNumber}');
      case OrderConfirmation(orderDetails: var details):
        print('Order Confirmed: ${details.orderId}');
      // case MFARequired(mfaToken: var token):
      //   print('MFA Required: Token $token');
      case CheckoutError(failure: var failure):
        print('Error: ${_describeFailure(failure)}');
    }
  }
}
