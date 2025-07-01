import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

class CityDropdownField extends StatelessWidget {
  final TextEditingController textController;
  final RxString selectedCity;
  final Future<List<String>> Function(String) fetchSuggestions;

  const CityDropdownField({
    super.key,
    required this.textController,
    required this.selectedCity,
    required this.fetchSuggestions,
  });

  @override
  Widget build(BuildContext context) {
    return TypeAheadField<String>(
      textFieldConfiguration: TextFieldConfiguration(
        controller: textController,
        decoration: const InputDecoration(
          labelText: 'City',
          border: OutlineInputBorder(),
          suffixIcon: Icon(Icons.arrow_drop_down), // ⬇️ Add dropdown icon here
        ),
        style: const TextStyle(fontSize: 16),
      ),
      suggestionsCallback: (pattern) async => await fetchSuggestions(pattern),
      itemBuilder: (context, String suggestion) => ListTile(
        title: Text(suggestion, style: const TextStyle(fontSize: 14)),
      ),
      onSuggestionSelected: (String suggestion) {
        textController.text = suggestion;
        selectedCity.value = suggestion;
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
