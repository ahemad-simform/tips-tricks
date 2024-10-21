import 'package:flutter/material.dart';
import 'package:flutter_trips_and_tricks/screen/sealed_class_and_destructuring/enum/check_out_service_with_enum.dart';
import 'package:flutter_trips_and_tricks/screen/sealed_class_and_destructuring/sealed_class/check_out_service_with_sealed_class.dart';

import 'enum/resources/check_out_type.dart';
import 'sealed_class/resources/check_out_state.dart';

class CheckOutScreen extends StatelessWidget {
  const CheckOutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Enum, Sealed with Destructuring Example'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: handleCheckOutWithEnum,
              child: const Text("Checkout with enum"),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: handleCheckOutWithSealedClass,
              child: const Text("Checkout with sealed class"),
            ),
          ],
        ),
      ),
    );
  }

  void handleCheckOutWithSealedClass() {
    final processor = CheckoutServiceWithSealedClass();

    while (processor.state is! OrderConfirmation &&
        processor.state is! CheckoutError) {
      processor.proceed();
    }

    // Final state handling
    if (processor.state is OrderConfirmation) {
      print('Checkout completed successfully.');
    } else if (processor.state is CheckoutError) {
      print('Checkout failed. Please try again.');
    }
  }

  void handleCheckOutWithEnum() {
    final processor = CheckoutServiceWithEnum();

    while (processor.state != CheckoutStateType.orderConfirmation &&
        processor.state != CheckoutStateType.checkoutError) {
      processor.proceed();
    }

    // Final state handling
    if (processor.state == CheckoutStateType.orderConfirmation) {
      processor.proceed();
      print('Checkout completed successfully.');
    } else if (processor.state == CheckoutStateType.checkoutError) {
      processor.proceed();
      print('Checkout failed. Please try again.');
    }
  }
}
