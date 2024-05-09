import 'package:intl/intl.dart';

class ValueFormats {
  static phoneNumber({required phone}) {
    phone = phone.trim().replaceAll(' ', '');
    String phoneNumber;
    if (phone.toString().startsWith('0')) {
      String temp = phone.toString();
      phoneNumber = temp.replaceRange(0, 1, '+255');
    } else if (phone.toString().startsWith('255')) {
      String temp = phone.toString();
      phoneNumber = '+${temp.toString()}';
    } else if (phone.toString().startsWith('+2550')) {
      String temp = phone.toString();

      phoneNumber = temp.replaceRange(0, 4, '+255');
    } else if (phone.toString().startsWith('2550')) {
      String temp = phone.toString();
      phoneNumber = temp.replaceRange(0, 3, '+255');
    } else {
      phoneNumber = phone;
    }
    return phoneNumber;
  }

  ///Function to format number -> 22,2222
  static numberFormat(number) {
    var f = NumberFormat.currency(
        customPattern: "###,###",
        locale: "en_US",
        symbol: '',
        decimalDigits: 0);
    var newNum = f.format(double.parse(number.toString()));
    return newNum;
  }

  ///Function to format a date in the format yyyy-MM-dd. For example 2000-12-31
  static dateFormat({String? inputDate}) {
    DateTime date = DateTime.parse(inputDate!);
    String formattedDate = DateFormat('yyyy-MM-dd').format(date);
    return formattedDate;
  }

  ///Function to format a date in the format yyyy-MM-dd. For example May 18, 2021
  static stingDateFormat({String? inputDate}) {
    DateTime date = DateTime.parse(inputDate!);
    String formattedDate = DateFormat('MMMM d, yyyy').format(date);
    return formattedDate;
  }

  ///Function to format the number value -> 222,222.00
  static balanceFormat(number) {
    var f = NumberFormat("###,###.###", "en_US");
    var newNum = f.format(number);
    return newNum;
  }

  ///Function to format the card number -> 2222 2222 2222
  static String formatStringWithSpaces(String input) {
    final chunks = <String>[];
    for (var i = 0; i < input.length; i += 4) {
      final chunk = input.substring(i, i + 4);
      chunks.add(chunk);
    }
    return chunks.join(' ');
  }



}

extension StringExtension on String {
  String capitalizeFirstLetterOfEachWord() {
    if (this.isEmpty) return this;

    List<String> words = this.split(' ');
    List<String> capitalizedWords = [];

    for (var word in words) {
      if (word.isNotEmpty) {
        capitalizedWords.add(word[0].toUpperCase() + word.substring(1).toLowerCase());
      }
    }

    return capitalizedWords.join(' ');
  }
}
