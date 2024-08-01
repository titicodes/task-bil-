import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taskitly/UI/widgets/apptexts.dart';
import 'package:taskitly/constants/palette.dart';
import 'package:taskitly/constants/reuseables.dart';
import '../../../../../core/models/tv_bill_Response.dart';
//import '../../../../../core/models/tv_billers_response.dart';

class TelevisionProviderScreen extends StatelessWidget {
  final List<ResponseData> providers;
  final Function(ResponseData) selectTvProvider;
  final ResponseData? selectedProvider;
  const TelevisionProviderScreen({
    super.key,
    required this.selectTvProvider,
    required this.providers,
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
            shrinkWrap: true,
            itemCount: providers.length,
            itemBuilder: (context, index) {
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
                            selectTvProvider(providers[index]);
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
                      await selectTvProvider(providers[index]);
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
