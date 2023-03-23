import 'package:get/get.dart';

class LocaleString extends Translations {

  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': {
          'title': 'Flutter Demo Multi Language',
          'hello': 'Hello World',
          'message': 'Welcome to SMI Infotech',
          'sub': 'Subscribe Now',
          'changelang': 'Change Language'
        },
        'hi_IN': {
          'title': 'स्पंदन डेमो बहु भाषा',
          'hello': 'नमस्ते दुनिया',
          'message': 'एसएमआई इन्फोटेक में आपका स्वागत है',
          'subscribe': 'सब्सक्राइब',
          'changelang': 'भाषा बदलो'
        },
      };
}
