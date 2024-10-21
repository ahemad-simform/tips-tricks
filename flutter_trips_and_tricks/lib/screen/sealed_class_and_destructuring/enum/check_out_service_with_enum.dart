import 'resources/check_out_type.dart';
import 'resources/failure_type.dart';
import 'resources/models.dart';

class CheckoutServiceWithEnum {
  CheckoutStateType _state = CheckoutStateType.cartReview;

  // Associated data
  ShippingInfo? shippingInfo;
  PaymentInfo? paymentInfo;
  OrderDetails? orderDetails;
  FailureDetails? failureDetails;
  String? mfaToken;

  CheckoutStateType get state => _state;

  void proceed() {
    _state = match(state);
  }

  CheckoutStateType match(CheckoutStateType type) {
    switch (type) {
      case CheckoutStateType.cartReview:
        return _handleCartReview();

      case CheckoutStateType.shippingDetails:
        return _handleShippingDetails();

      case CheckoutStateType.paymentProcessing:
        return _handlePaymentProcessing();

      // case CheckoutStateType.mfaRequired:
      //   return _handleMFARequired();

      case CheckoutStateType.orderConfirmation:
        print('Order confirmed: ${orderDetails?.orderId}');
        return type;

      case CheckoutStateType.checkoutError:
        // Handle errors or retry
        print('Checkout failed due to: ${_describeFailure(failureDetails!)}');
        return type;
    }
  }

  CheckoutStateType _handleCartReview() {
    print('Reviewing Cart...');
    // Transition to Shipping Details
    return CheckoutStateType.shippingDetails;
  }

  CheckoutStateType _handleShippingDetails() {
    // Simulate shipping info entry
    shippingInfo = ShippingInfo('123 Main St', 'Anytown', '12345');
    print(
        'Entering Shipping Details: ${shippingInfo?.address}, ${shippingInfo?.city}');
    if (_validateShipping(shippingInfo!)) {
      // Transition to Payment Processing
      return CheckoutStateType.paymentProcessing;
    } else {
      // Transition to Checkout Error
      failureDetails = FailureDetails(
          CheckoutFailureType.invalidAddress, 'Invalid postal code');
      return CheckoutStateType.checkoutError;
    }
  }

  CheckoutStateType _handlePaymentProcessing() {
    // Simulate payment processing
    paymentInfo = PaymentInfo('4111111111111111', '12/24');
    print('Processing Payment: ${paymentInfo?.cardNumber}');

    // bool outOfStock = true;

    // if (outOfStock) {
    //   // Transition to Checkout Error
    //   failureDetails =
    //       FailureDetails(CheckoutFailureType.outOfStock, 'PROD123');
    //   return CheckoutStateType.checkoutError;
    // }

    bool paymentSuccess = _processPayment(paymentInfo!);

    if (paymentSuccess) {
      // Transition to MFA Required
      // mfaToken = 'MFA_TOKEN_ABC123';
      // return CheckoutStateType.mfaRequired;
      orderDetails = OrderDetails('ORD123456', ['Item1', 'Item2']);
      return CheckoutStateType.orderConfirmation;
    } else {
      // Transition to Checkout Error
      failureDetails =
          FailureDetails(CheckoutFailureType.paymentDeclined, 'Card declined');
      return CheckoutStateType.checkoutError;
    }
  }

  // CheckoutStateType _handleMFARequired() {
  //   print('MFA Required: Token $mfaToken');
  //   // Simulate MFA verification
  //   bool mfaSuccess = _verifyMFA(mfaToken!);
  //   if (mfaSuccess) {
  //     // Transition to Order Confirmation
  //     orderDetails = OrderDetails('ORD123456', ['Item1', 'Item2']);
  //     return CheckoutStateType.orderConfirmation;
  //   } else {
  //     // Transition to Checkout Error
  //     failureDetails = FailureDetails(
  //         CheckoutFailureType.unknownFailure, 'MFA Verification Failed');
  //     return CheckoutStateType.checkoutError;
  //   }
  // }

  bool _validateShipping(ShippingInfo info) {
    // Implement validation logic
    return info.postalCode.length == 5;
  }

  bool _processPayment(PaymentInfo payment) {
    // Implement payment processing logic
    // Simulate a successful payment
    return false;
  }

  // bool _verifyMFA(String token) {
  //   // Simulate MFA verification logic
  //   return token == 'MFA_TOKEN_ABC123';
  // }

  String _describeFailure(FailureDetails failure) {
    switch (failure.failure) {
      case CheckoutFailureType.paymentDeclined:
        return 'Payment Declined: ${failure.message}';
      case CheckoutFailureType.paymentTimeout:
        return 'Payment Timeout';
      case CheckoutFailureType.invalidAddress:
        return 'Invalid Address Field: ${failure.message}';
      // case CheckoutFailureType.outOfStock:
      //   return 'Product Out of Stock: ${failure.message}';
      case CheckoutFailureType.unknownFailure:
        return 'Unknown Failure: ${failure.message}';
    }
  }
}
