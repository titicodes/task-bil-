// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:taskitly/UI/widgets/apptexts.dart';
import 'package:taskitly/constants/palette.dart';
import 'package:taskitly/constants/reuseables.dart';

import '../../../../base/base.ui.dart';
import 'electricity-provider-type-view-vm.dart';

class ElectricityProviderTypeScreen extends StatelessWidget {
  int electricityProviderId;
  ElectricityProviderTypeScreen({
    Key? key,
    required this.electricityProviderId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OtherView<ElectricityProviderTypeViewModel>(
      onModelReady: (m) => m.init(context, electricityProviderId),
      builder: (_, model, child) => Form(
          key: model.formKey,
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
                  itemCount: model.providers.length,
                  itemBuilder: (context, index) {
                    // final provider = model.electricityResponseModel.data?.values
                    //     .elementAt(index);
                    return Column(
                      children: [
                        ListTile(
                          title: Row(
                            children: [
                              Text(
                                model.providers[index].slug!.toLowerCase(),
                                style: const TextStyle(color: Colors.black),
                              ),
                              const Spacer(),
                              Radio(
                                value: model.providers[index].slug,
                                groupValue: model.selectedProvider,
                                onChanged: (value) {
                                  // model.selectProvider(value.toString());
                                  String selectedSlug =
                                      model.providers[index].slug!;
                                  model.printSelectedValue(selectedSlug);
                                },
                                toggleable: true,
                                activeColor: Colors
                                    .green, // Change this to the desired color
                              ),
                            ],
                          ),
                          onTap: () {
                            String selectedTypeSlug =
                                model.providers[index].slug!;
                            model.printSelectedValue(selectedTypeSlug);
                            Navigator.pop(context, selectedTypeSlug);
                          },
                        ),
                        const Divider()
                      ],
                    );
                  },
                ),
              ),
            ],
          )),
    );
  }
}
