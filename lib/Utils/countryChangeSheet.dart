import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/utils.dart';
import 'package:zodo_dr/Utils/UtilsController.dart';
import 'package:zodo_dr/Utils/supportModels/disctrictModel.dart';


class SimpleStateSelector extends StatelessWidget {
  DistrictModel selectedDistrict;
  final Function(DistrictModel) onStateSelected;

  SimpleStateSelector({
    Key? key,
    required this.onStateSelected,
    required this.selectedDistrict,
  }) : super(key: key);

  Utilscontroller ctrl = Get.put(Utilscontroller());

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      child: GetBuilder<Utilscontroller>(
        builder: (__) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Handle bar
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),

              const SizedBox(height: 16),

              // Title
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  'Select District',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),

              const SizedBox(height: 12),

              // States list
              Container(
                constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height * 0.2,
                ),
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: __.districtList.length,
                  itemBuilder: (context, index) {
                    final state = __.districtList[index];
                    final isSelected = state == selectedDistrict;

                    return InkWell(
                      onTap: () {
                        onStateSelected(state);
                        __.selectedDistrict = state;
                        __.updateCountry();

                        __.update();
                        Get.back();
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                        child: Row(
                          children: [
                            Text(
                              state.name ?? "",
                              style: TextStyle(
                                color: isSelected ? Colors.blue : Colors.black,
                                fontWeight:
                                    isSelected
                                        ? FontWeight.bold
                                        : FontWeight.normal,
                              ),
                            ),
                            const Spacer(),
                            if (isSelected)
                              const Icon(Icons.check, color: Colors.blue),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

// Example usage
