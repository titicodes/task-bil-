// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:taskitly/UI/widgets/apptexts.dart';
import 'package:taskitly/constants/palette.dart';
import 'package:taskitly/constants/reuseables.dart';

import '../../../../../core/models/electricity_biller_type_res.dart';

class BettingProviderTypeScreen extends StatelessWidget {
  // int electricityProviderId;
  final List<ResponseTypeData> typeProviders;
  final Function(ResponseTypeData) selectBettingTypeProvider;
  final ResponseTypeData? selectedTypeProvider;
  const BettingProviderTypeScreen({
    Key? key,
    required this.typeProviders,
    required this.selectBettingTypeProvider,
    this.selectedTypeProvider,
    // required this.electricityProviderId,
  }) : super(key: key);

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
            itemCount: typeProviders.length,
            itemBuilder: (context, index) {
              // final provider = model.electricityResponseModel.data?.values
              //     .elementAt(index);
              return Column(
                children: [
                  ListTile(
                    title: Row(
                      children: [
                        Text(
                          typeProviders[index].slug!.toLowerCase(),
                          style: const TextStyle(color: Colors.black),
                        ),
                        const Spacer(),
                        Radio(
                          value: typeProviders[index].slug,
                          groupValue: selectedTypeProvider
                              ?.slug, // Use the selected provider here
                          onChanged: (value) {
                            selectBettingTypeProvider(typeProviders[index]);
                            navigationService.goBack();
                          },
                          toggleable: true,
                          activeColor: selectedTypeProvider?.slug ==
                                  typeProviders[index].slug
                              ? Colors.green
                              : null, // Set the active color to green if this provider is selected
                        ),
                      ],
                    ),
                    onTap: () {
                      selectBettingTypeProvider(typeProviders[index]);
                      navigationService.goBack();
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
