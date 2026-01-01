import 'package:flutter/material.dart';

// Kelas untuk mengelola state antar halaman
class PageState {
  String? selectedCategory;
  int? itemCount;
  Map<String, dynamic>? userPreferences;
  
  void updateCategory(String category) {
    selectedCategory = category;
  }
  
  void updateItemCount(int count) {
    itemCount = count;
  }
  
  void updatePreferences(Map<String, dynamic> prefs) {
    userPreferences = prefs;
  }
}