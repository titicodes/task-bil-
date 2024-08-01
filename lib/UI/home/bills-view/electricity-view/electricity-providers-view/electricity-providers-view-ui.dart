import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taskitly/UI/widgets/apptexts.dart';
import 'package:taskitly/constants/palette.dart';
import 'package:taskitly/constants/reuseables.dart';
import '../../../../../core/models/electricity_billers_response.dart';

class ElectricityProviderScreen extends StatelessWidget {
  final List<EnuguDisco> providers;
  final Function(EnuguDisco) selectElectricityProvider;
  final EnuguDisco? selectedProvider;
  const ElectricityProviderScreen({
    required this.providers,
    required this.selectElectricityProvider,
    super.key,
    this.selectedProvider,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
        child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            InkWell(
              onTap: navigationService.goBack,
              child: Container(
                height: 30,
                width: 30,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: secondaryColor),
                child: const Icon(
                  Icons.clear,
                  size: 18,
                  color: Colors.black,
                ),
              ),
            )
          ],
        ),
        AppText(
          "Select Provider",
          size: 14.sp,
          overflow: TextOverflow.ellipsis,
          maxLine: 1,
          weight: FontWeight.bold,
        ),
        Container(
          margin: const EdgeInsets.only(top: 10),
          color: Colors.white,
          height: 300,
          child: ListView.builder(
            shrinkWrap: false,
            itemCount: providers.length,
            itemBuilder: (context, index) {
              // final provider = model.electricityResponseModel.data?.values
              //     .elementAt(index);
              return Column(
                children: [
                  ListTile(
                    title: Row(
                      children: [
                        Text(
                          providers[index].slug!.toLowerCase(),
                          style: const TextStyle(color: Colors.black),
                        ),
                        const Spacer(),
                        Radio(
                          value: providers[index].slug,
                          groupValue: selectedProvider
                              ?.slug, // Use the selected provider here
                          onChanged: (value) {
                            selectElectricityProvider(providers[index]);
                            navigationService.goBack();
                          },
                          toggleable: true,
                          activeColor: selectedProvider?.slug ==
                                  providers[index].slug
                              ? Colors.green
                              : null, // Set the active color to green if this provider is selected
                        ),
                      ],
                    ),
                    onTap: () async {
                      await selectElectricityProvider(providers[index]);
                      navigationService.goBack();
                      // String selectedSlug = model.providers[index].slug!;
                      // int selectedProviderId = model.providers[index].id!;
                      // model.printSelectedValue(
                      //     selectedSlug, selectedProviderId);
                      // Navigator.pop(
                      //     context, [selectedSlug, selectedProviderId]);
                    },
                  ),
                  const Divider()
                ],
              );
            },
          ),
        ),
      ],
    ));
  }
}
