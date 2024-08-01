// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taskitly/UI/widgets/apptexts.dart';
import 'package:taskitly/UI/widgets/price-widget.dart';
import 'package:taskitly/constants/palette.dart';
import 'package:taskitly/constants/reuseables.dart';
import 'package:taskitly/utils/widget_extensions.dart';
import '../../../../../core/models/electricity_biller_type_res.dart';

class TelevisionProviderTypeScreen extends StatefulWidget {
  final ResponseTypeData? setlectedTypeProvider;
  final List<ResponseTypeData> typeProviders;
  final Function(ResponseTypeData) selectTvTypeProvider;
  const TelevisionProviderTypeScreen({
    Key? key,
    this.setlectedTypeProvider,
    required this.typeProviders,
    required this.selectTvTypeProvider,
  }) : super(key: key);

  @override
  State<TelevisionProviderTypeScreen> createState() =>
      _TelevisionProviderTypeScreenState();
}

class _TelevisionProviderTypeScreenState
    extends State<TelevisionProviderTypeScreen> {
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
          margin: EdgeInsets.only(top: 10.sp),
          color: Colors.white,
          height: 300,
          child: ListView.builder(
            itemCount: widget.typeProviders.length,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () async {
                        // setState(() {
                        widget
                            .selectTvTypeProvider(widget.typeProviders[index]);
                        navigationService.goBack();
                      },
                      child: Row(
                        children: [
                          10.sp.sbW,
                          Expanded(
                              child: AppText(
                            widget.typeProviders[index].name ?? "",
                            size: 13.sp,
                            weight: FontWeight.w500,
                            align: TextAlign.start,
                          )),
                          10.sp.sbW,
                          PriceWidget(
                            value: widget.typeProviders[index].amount ?? "",
                            fontSize: 11.sp,
                            fontWeight: FontWeight.w500,
                          ),
                          10.sp.sbW,
                          Radio(
                            value: widget.typeProviders[index].slug,
                            groupValue: widget.setlectedTypeProvider
                                ?.slug, // Use the selected provider here
                            onChanged: (value) {
                              widget.selectTvTypeProvider(
                                  widget.typeProviders[index]);
                              navigationService.goBack();
                            },
                            toggleable: true,
                            activeColor: widget.setlectedTypeProvider?.slug ==
                                    widget.typeProviders[index].slug
                                ? Colors.green
                                : null, // Set the active color to green if this provider is selected
                          ),
                        ],
                      ),
                    ),
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
