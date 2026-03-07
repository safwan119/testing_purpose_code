import 'package:flutter/material.dart';
import 'package:testing_purpose/service/stripe_services.dart';

class StripePractiseView extends StatelessWidget {
  const StripePractiseView({super.key});

  @override
  Widget build(BuildContext context) {
    final StripeServices stripeServices = StripeServices.stripeServicesInstance;
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: Text("Stripe Payment Practise")),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            InkWell(
              onTap: () async {
                await stripeServices.makePayment(30.0)
                    ? debugPrint(
                    "Payment successfully or purchase successfully")
                    : debugPrint("TYhe Error found during purchasing");
              },
              child: Container(
                height: 45,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Center(child: Text("Purchase")),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
