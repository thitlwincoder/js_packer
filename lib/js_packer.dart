library js_packer;

import 'dart:math';

/// A JSPacker.
class JSPacker {
  /// get js code
  final String packedJS;

  JSPacker(this.packedJS);

  /// detect code has match
  bool detect() {
    String js = packedJS.replaceAll(" ", "");
    RegExp exp = RegExp("eval\\(function\\(p,a,c,k,e,(?:r|d)");
    return exp.hasMatch(js);
  }

  /// change code to value
  String unpack() {
    try {
      /// pattern
      RegExp exp = RegExp(
        "\\}\\s*\\('(.*)',\\s*(.*?),\\s*(\\d+),\\s*'(.*?)'\\.split\\('\\|'\\)",
        dotAll: true,
      );

      /// get value from elementAt 0
      var matches = exp.allMatches(packedJS).elementAt(0);

      /// if group count is 4
      if (matches.groupCount == 4) {
        /// get value with group
        String payload = matches.group(1).replaceAll("\\'", "\'");
        String radixStr = matches.group(2);
        String countStr = matches.group(3);
        List sym = matches.group(4).split("\|");

        /// initial value
        int radix = 36;
        int count = 0;

        /// set radix value
        try {
          radix = int.parse(radixStr);
        } catch (e) {}

        /// set count value
        try {
          count = int.parse(countStr);
        } catch (e) {}

        /// error condition
        if (sym.length != count) {
          throw new Exception("Unknown p.a.c.k.e.r. encoding");
        }

        /// call UnBase class
        UnBase unBase = new UnBase(radix);

        /// Pattern
        exp = RegExp("\\b\\w+\\b");

        /// get value from elementAt 0
        matches = exp.allMatches(payload).elementAt(0);

        /// initial value
        int replaceOffset = 0;

        /// foreach looping
        exp.allMatches(payload).forEach((element) {
          /// get word from group 0
          String word = element.group(0);

          String value;

          /// change code to value
          int x = unBase.unBase(word);

          /// set value
          if (x < sym.length) {
            value = sym[x];
          }

          if (value != null && value.length > 0) {
            payload = payload.replaceRange(element.start + replaceOffset,
                element.end + replaceOffset, value);
            replaceOffset += value.length - word.length;
          }
        });

        /// return result
        return payload;
      }
      return null;
    } catch (_) {
      return null;
    }
  }
}

/// UnBase Class
class UnBase {
  final String alpha_62 =
      "0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
  final String alpha_95 =
      " !\"#\$%&\\'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\\\]^_`abcdefghijklmnopqrstuvwxyz{|}~";
  String alphabet;
  Map<String, int> dictionary;
  int radix;

  UnBase(int radix) {
    this.radix = radix;

    if (radix > 36) {
      if (radix < 62)
        alphabet = alpha_62.substring(0, radix);
      else if (radix > 62 && radix < 95)
        alphabet = alpha_95.substring(0, radix);
      else if (radix == 62)
        alphabet = alpha_62;
      else if (radix == 95) alphabet = alpha_95;

      for (int i = 0; i < alphabet.length; i++) {
        dictionary[alphabet.substring(i, i + 1)] = i;
      }
    }
  }

  /// change code to value
  int unBase(String str) {
    int ret = 0;

    if (alphabet == null) {
      ret = int.parse(str, radix: radix);
    } else {
      for (int i = 0; i < str.length; i++) {
        ret += pow(radix, i) * dictionary[str.substring(i, i + 1)];
      }
    }
    return ret;
  }
}
