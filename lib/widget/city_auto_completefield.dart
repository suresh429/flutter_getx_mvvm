import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';

import '../view_model/profile_controller.dart';

class CityDropdownField extends StatelessWidget {
  final ProfileController controller = Get.find<ProfileController>();

  CityDropdownField({super.key});

  @override
  Widget build(BuildContext context) {
    return TypeAheadFormField<String>(
      textFieldConfiguration: TextFieldConfiguration(
        controller: controller.cityTextController,
        decoration: const InputDecoration(
          labelText: 'City',
          border: OutlineInputBorder(),

        ),
        style: const TextStyle(fontSize: 16),
      ),
      suggestionsCallback: (pattern) async {
        return await controller.fetchCities(pattern);
      },
      itemBuilder: (context, String suggestion) {
        return ListTile(
          title: Text(
            suggestion,
            style: const TextStyle(fontSize: 14),
          ),
        );
      },
      onSuggestionSelected: (String suggestion) {
        controller.cityTextController.text = suggestion;
        controller.city.value = suggestion;
      },
      suggestionsBoxDecoration: SuggestionsBoxDecoration(
        elevation: 4,
        constraints: const BoxConstraints(maxHeight: 250),
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      noItemsFoundBuilder: (context) => const Padding(
        padding: EdgeInsets.all(12.0),
        child: Text('No cities found', style: TextStyle(fontSize: 14)),
      ),
    );
  }
}
