import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppStrings {
  static final String stripePublishableKey =
      dotenv.env["STRIPE_PUBLISHABLE_KEY"] ?? "";
  static final String stripeSecreteKey = dotenv.env["STRIPE_SECRET_KEY"] ?? "";
}
