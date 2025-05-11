import 'package:get/get.dart';
import 'package:mini_service_booking_app/core/translations/am_ET.dart';
import 'package:mini_service_booking_app/core/translations/en_US.dart';
import 'package:mini_service_booking_app/core/translations/es_ES.dart';
import 'package:mini_service_booking_app/core/translations/fr_FR.dart';

class TranslationLanguges extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': enUS,
        'am_ET': amET,
        'es_ES': esES,
        'fr_FR': frFR,
      };
}
