import 'package:flutter_dotenv/flutter_dotenv.dart';

const String token = 'token';
const String userTypes = 'userTypes';
const String userTypeData = 'userTypeData';

String get baseUrl => dotenv.env['BASE_URL']!;
String get publicKey => dotenv.env['PAYSTACK_PUBLIC_URL']!;
String get flutterWaveKey => dotenv.env['FLUTTERWAVE_URL'] ?? "";
String get priceUrl => dotenv.env['CRYPTO_PRICE_URL']!;
String get verificationUrl => dotenv.env['VERIFICATION_URL']!;
