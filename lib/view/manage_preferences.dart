import 'package:flutter/material.dart';
import 'package:flutter_getx_mvvm/utilites/colors.dart';
import 'package:get/get.dart';
import '../model/AreaOption.dart';
import '../model/CategoryModel.dart';
import '../model/LoginModel.dart';
import '../utilites/constants_Utils.dart';
import '../view_model/manage_preferences_controller.dart';

class ManagePreferences extends StatefulWidget {
  const ManagePreferences({super.key});

  @override
  State<ManagePreferences> createState() => _ManagePreferencesState();
}

class _ManagePreferencesState extends State<ManagePreferences> {
  late LoginModel? loginResponse;

  final ManagePreferencesController controller =
      Get.put(ManagePreferencesController());


  @override
  void initState() {
    super.initState();
    getUserData();
  }

  // initial call
  Future<void> getUserData() async {
     loginResponse = await ConstantsUtils.getStoredLoginResponse();
    // print("areasOfInterest :  ${loginResponse?.data?.areasOfInterest}");

  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    print("screenHeight $screenHeight");

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('Manage Preferences'),
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 70.0),
            child: ListView(
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 10, top: 20, bottom: 5),
                  child: Text(
                    'Select App Category',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Obx(() {
                  return ListView.builder(
                    shrinkWrap: true,
                    primary: false,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: controller.categories.length,
                    itemBuilder: (context, index) {
                      final category = controller.categories[index];
                      return Obx(() {
                        bool isSelected = controller
                            .selectedCategoriesIndices
                            .contains(index);
                        return InkWell(
                          onTap: () {
                            controller.toggleCategorySelection(index);
                          },
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            elevation: 1,
                            margin: const EdgeInsets.only(
                                left: 8, right: 8, top: 8),
                            child: Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? Colors.red[100]
                                    : Colors.white,
                                border: Border.all(
                                  color:
                                  isSelected ? Colors.red : Colors.grey,
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
                                  padding: const EdgeInsets.only(
                                      top: 5, bottom: 5),
                                  child: Text(
                                    category.subtitle,
                                    style: const TextStyle(
                                        fontSize: 12, color: Colors.grey),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      });
                    },
                  );
                }),
                Obx(() {
                  if (controller.isPodcastSelected) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding:
                          EdgeInsets.only(left: 10, top: 20, bottom: 5),
                          child: Text(
                            'Preferred Language',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 40,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: controller.languages.length,
                            itemBuilder: (context, index) {
                              final language = controller.languages[index];
                              return Obx(() {
                                bool isSelected = controller.selectedLanguages
                                    .contains(language);
                                return InkWell(
                                  onTap: () {
                                    controller.toggleLanguageSelection(language);
                                  },
                                  child: SizedBox(
                                    width: 100,
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.start,
                                      children: [
                                        Checkbox(
                                          value: isSelected,
                                          onChanged: (bool? value) {
                                            controller
                                                .toggleLanguageSelection(language);
                                          },
                                          activeColor: Colors.red,
                                        ),
                                        Text(language),
                                      ],
                                    ),
                                  ),
                                );
                              });
                            },
                          ),
                        ),
                      ],
                    );
                  } else {
                    return const SizedBox.shrink();
                  }
                }),
                const Padding(
                  padding: EdgeInsets.only(left: 10, top: 20, bottom: 5),
                  child: Text(
                    'Areas of Interest',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8, right: 8, bottom: 25, top: 8),
                  child: Obx(() {
                    return Wrap(
                      spacing: 8.0,
                      runSpacing: 4.0,
                      children: controller.areasOfInterest.map((area) {
                        return FilterChip(
                          label: Text(area.name),
                          selected: controller.selectedAreasOfInterest
                              .contains(area),
                          onSelected: (bool selected) {
                            controller.toggleAreaSelection(area);
                          },
                          selectedColor: ColorUtils.colorPrimary,
                          backgroundColor: Colors.grey[350],
                          checkmarkColor: Colors.white,
                          labelStyle: TextStyle(
                            color: controller.selectedAreasOfInterest
                                .contains(area)
                                ? Colors.white
                                : Colors.black,
                          ),
                        );
                      }).toList(),
                    );
                  }),
                ),
              ],
            ),
          ),
          Obx(() {
            if (controller.isLoading.value) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return Positioned(
                bottom: 5,
                left: 10,
                right: 10,
                child: SafeArea(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 15), // Padding to avoid corner merging
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12), // Rounded corners
                      ),
                    ),
                    onPressed: () {
                      List<String> selectedCategoryNames = controller
                          .selectedCategoriesIndices
                          .map((index) => controller.categories[index].title.toLowerCase())
                          .toList();

                      List<String> selectedLanguageNames =
                      controller.selectedLanguages.toList();

                      List<String> selectedAreas = controller
                          .selectedAreasOfInterest
                          .map((area) => area.name)
                          .toList();

                      if (selectedCategoryNames.isEmpty) {
                        Get.snackbar("Validation", "Please select at least one category.");
                        return;
                      }

                      if (selectedCategoryNames.contains("Podcast") &&
                          selectedLanguageNames.isEmpty) {
                        Get.snackbar("Validation", "Please select at least one language.");
                        return;
                      }

                      controller.updateUserPreferences(selectedCategoryNames,
                          selectedLanguageNames, selectedAreas);
                    },
                    child: const Text("UPDATE PREFERENCE"),
                  ),
                ),
              );
            }
          }),
        ],
      ),
    );
  }

}
