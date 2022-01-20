import 'package:flutter_dotenv/flutter_dotenv.dart';

class Environment {
  static String get stripePublishableKey {
    return dotenv.env['STRIPE_PUBLISHABLE_KEY'] ?? '';
  }
}
