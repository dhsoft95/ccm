import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

extension StringExtension on String {
  String capitalizeFirstLetterOfEachWord() {
    if (this.isEmpty) return this;

    List<String> words = this.split(' ');
    List<String> capitalizedWords = [];

    for (var word in words) {
      if (word.isNotEmpty) {
        capitalizedWords
            .add(word[0].toUpperCase() + word.substring(1).toLowerCase());
      }
    }

    return capitalizedWords.join(' ');
  }
}

extension NameExtensions on String {
  String capitalizeNames() {
    return this.split(' ').map((name) {
      if (name.isNotEmpty) {
        return name[0].toUpperCase() + name.substring(1).toLowerCase();
      }
      return name;
    }).join(' ');
  }

  String extractInitials() {
    List<String> names = this.split(' ');
    String initials = '';
    for (var name in names) {
      if (name.isNotEmpty) {
        initials += name[0].toUpperCase();
      }
    }
    return initials;
  }
}
