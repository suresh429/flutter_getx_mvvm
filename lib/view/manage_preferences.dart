import 'package:flutter/material.dart';
import 'package:flutter_getx_mvvm/utilites/constants_Utils.dart';
import '../model/AreaOption.dart';
import '../model/CategoryModel.dart';
import '../utilites/colors.dart';

class ManagePreferences extends StatefulWidget {
  const ManagePreferences({super.key});

  @override
  State<ManagePreferences> createState() => _ManagePreferencesState();
}

class _ManagePreferencesState extends State<ManagePreferences> {
  final List<Category> categories = [
    Category(
      title: 'Board Member',
      subtitle:
      'Empower nonprofits to unlock their potential & amplify their impact as a Board Member.',
      image: 'assets/board_member.png',
    ),
    Category(
      title: 'Event Speaker',
      subtitle:
      'Enable nonprofits & individuals to reimagine possibilities & unlock growth as a Mentor.',
      image: 'assets/event_speaker.png',
    ),
    Category(
      title: 'Mentoring',
      subtitle:
      'Share your expertise & knowledge as a thought leader by featuring on nonprofits’ Podcasts.',
      image: 'assets/mentoring.png',
    ),
    Category(
      title: 'Podcast',
      subtitle:
      'Offer invaluable insights as an Event Speaker, inspiring the audience to take social action.',
      image: 'assets/podcast.png',
    ),
  ];

  final List<AreaOption> areasOfInterest = [
    AreaOption("No Poverty"),
    AreaOption("Zero Hunger"),
    AreaOption("Good Health and Well-being"),
    AreaOption("Quality Education"),
    AreaOption("Gender Equality"),
    AreaOption("Clean Water and Sanitation"),
    AreaOption("Affordable and Clean Energy"),
    AreaOption("Decent Work and Economic Growth"),
    AreaOption("Industry, Innovation and Infrastructure"),
    AreaOption("Reduced Inequality"),
    AreaOption("Sustainable Cities and Communities"),
    AreaOption("Responsible Consumption and Production"),
    AreaOption("Climate Action"),
    AreaOption("Life Below Water"),
    AreaOption("Life on Land"),
    AreaOption("Peace, Justice and Strong Institutions"),
    AreaOption("Partnership for the Goals"),
  ];

  final List<String> languages = ['Any', 'English', 'Hindi', 'Telugu']; // Example languages
  Set<int> selectedCategoriesIndices = <int>{};
  Set<int> selectedLanguagesIndices = <int>{}; // Track selected languages

  @override
  Widget build(BuildContext context) {
    print('Languages list: ${languages.length}'); // Check if the list has data

    // Check if the "Podcast" category is selected
    bool isPodcastSelected = selectedCategoriesIndices.contains(3); // Index 3 corresponds to 'Podcast'

    return Scaffold(
      backgroundColor: ColorUtils.colorSurface,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text('Manage Preferences'),
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 50.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Text widget for Select App Category
                  const Padding(
                    padding: EdgeInsets.only(left: 10, top: 20, bottom: 5),
                    child: Text(
                      'Select App Category',
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  // ListView for category selection
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.45,
                    child: ListView.builder(
                      itemCount: categories.length,
                      itemBuilder: (context, index) {
                        final category = categories[index];
                        bool isSelected = selectedCategoriesIndices.contains(index);
                        return InkWell(
                          onTap: () {
                            setState(() {
                              if (isSelected) {
                                // Deselect item
                                selectedCategoriesIndices.remove(index);
                              } else {
                                // Select item
                                selectedCategoriesIndices.add(index);
                              }
                            });
                          },
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            elevation: 1,
                            margin: const EdgeInsets.only(left: 8, right: 8, top: 8),
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: isSelected
                                      ? ColorUtils.colorPrimary
                                      : Colors.grey,
                                  width: isSelected ? 2 : 1,
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: ListTile(
                                leading: Image.asset(
                                  category.image,
                                  height: 40,
                                  width: 40,
                                ),
                                title: Padding(
                                  padding: const EdgeInsets.only(top: 5),
                                  child: Text(category.title),
                                ),
                                subtitle: Padding(
                                  padding: const EdgeInsets.only(top: 5, bottom: 5),
                                  child: Text(
                                    category.subtitle,
                                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  // Only show Preferred Language section if "Podcast" category is selected
                  if (isPodcastSelected) ...[
                    const Padding(
                      padding: EdgeInsets.only(left: 10, top: 20, bottom: 5),
                      child: Text(
                        'Preferred Language',
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    // Horizontal ListView for Preferred Languages
                    SizedBox(
                      height: 40, // Fixed height for horizontal list view
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: languages.length,
                        itemBuilder: (context, index) {
                          final language = languages[index];
                          bool isSelected = selectedLanguagesIndices.contains(index);
                          return InkWell(
                            onTap: () {
                              setState(() {
                                if (isSelected) {
                                  selectedLanguagesIndices.remove(index);
                                } else {
                                  selectedLanguagesIndices.add(index);
                                }
                              });
                            },
                            child: SizedBox(
                              width: 100, // Set width for each item in horizontal list
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Checkbox(
                                    value: isSelected,
                                    onChanged: (bool? value) {
                                      setState(() {
                                        if (value != null) {
                                          if (value) {
                                            selectedLanguagesIndices.add(index);
                                          } else {
                                            selectedLanguagesIndices.remove(index);
                                          }
                                        }
                                      });
                                    },
                                    activeColor: Colors.red,
                                  ),
                                  Text(language),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],

                  const Padding(
                    padding: EdgeInsets.only(left: 10, top: 20, bottom: 5),
                    child: Text(
                      'Areas of Interest',
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Wrap(
                      spacing: 8.0, // Horizontal spacing between chips
                      runSpacing: 4.0, // Vertical spacing between rows of chips
                      children: areasOfInterest.map((area) {
                        return FilterChip(
                          label: Text(area.name),
                          selected: area.isChecked,
                          onSelected: (bool selected) {
                            setState(() {
                              area.isChecked = selected;
                            });
                          },
                          selectedColor: ColorUtils.colorPrimary, // Set selected color
                          backgroundColor: Colors.grey[350], // Set default color
                          checkmarkColor: Colors.white, // Color for checkmark
                          labelStyle: TextStyle(
                            color: area.isChecked ? Colors.white : Colors.black, // Change text color based on selection
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Positioned button at the bottom of the screen
          Positioned(
            bottom: 5,
            left: 10,
            right: 10,
            child: ElevatedButton(
              onPressed: () {
                // Get selected category names
                List<String> selectedCategoryNames = selectedCategoriesIndices
                    .map((index) => categories[index].title) // Map indices to category titles
                    .toList();

                // Get selected language names
                List<String> selectedLanguageNames = selectedLanguagesIndices
                    .map((index) => languages[index]) // Map indices to language names
                    .toList();

                // Get selected areas of interest
                List<String> selectedAreas = areasOfInterest
                    .where((area) => area.isChecked) // Check if the chip is selected
                    .map((area) => area.name) // Get the name of the selected chip
                    .toList();



                // Validate categories
                if (selectedCategoryNames.isEmpty) {
                  ConstantsUtils.showInfoSnackbar("Please select at least one category.");
                  return; // Stop execution if validation fails
                }

                // Validate languages only if "Podcast" is in the selected categories
                if (selectedCategoryNames.contains("Podcast") && selectedLanguageNames.isEmpty) {
                  ConstantsUtils.showInfoSnackbar("Please select at least one language.");
                  return; // Stop execution if validation fails
                }

                ConstantsUtils.showInfoSnackbar("Preferences updated successfully!");

              },
              child: const Text("UPDATE PREFERENCE"),
            ),
          ),
        ],
      ),
    );
  }
}
