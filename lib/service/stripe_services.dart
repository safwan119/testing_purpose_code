import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;
import 'package:testing_purpose/constants/app_strings.dart';
import 'package:testing_purpose/constants/app_urls.dart';

class StripeServices {
  StripeServices._();

  static final StripeServices stripeServicesInstance = StripeServices._();

  //this will make payment and give success or failure in during the paying the price
  Future<bool> makePayment(double amount) async {
    try {
      final paymentClientSecrete = await paymentIntent(amount, "MYR");
      if (paymentClientSecrete == null) {
        return false;
      } else {
        await Stripe.instance.initPaymentSheet(
          paymentSheetParameters: SetupPaymentSheetParameters(
            paymentIntentClientSecret: paymentClientSecrete,
            merchantDisplayName: "Muhammad Safwan",
          ),
        );
        return await processPayment();
      }
    } catch (e) {
      debugPrint("The error during making the payment is :$e");
      return false;
    }
  }

  //this function is used for sending request to server using api and
  // then using calculated amount using given currency and
  // then return the response body in json decode form
  Future<String?> paymentIntent(double amount, String currency) async {
    try {
      final Map<dynamic, dynamic> data = {
        "amount": calculatePayment(amount).toString(),
        "currency": currency,
      };
      final response = await http.post(
        Uri.parse(AppUrls.stripUrl),
        body: data,
        headers: {
          "Authorization": "Bearer ${AppStrings.stripeSecreteKey}",
          "Content-Type": "application/x-www-form-urlencoded",
        },
      );
      final body = jsonDecode(response.body);
      if (body["client_secret"] != null) {
        return body["client_secret"];
      } else {
        debugPrint("The Stripe Error is :${body["error"]}");
      }
    } catch (e) {
      debugPrint("The Error during fetching or using api:$e");
    }
    return null;
  }

  //using this function we show the model sheet for payment
  Future<bool> processPayment() async {
    try {
      await Stripe.instance.presentPaymentSheet();
      return true;
    } catch (e) {
      debugPrint("The Error during process payment is $e");
      return false;
    }
  }

  //this will calculate the payment in the form int by
  // using double amount written by user during buying item
  int calculatePayment(double amount) {
    return (amount * 100).toInt();
  }
}
