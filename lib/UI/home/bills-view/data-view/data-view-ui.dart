import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:taskitly/UI/home/bills-view/data-view/data-view-vm.dart';
import 'package:taskitly/UI/widgets/appCard.dart';
import 'package:taskitly/UI/widgets/apptexts.dart';
import 'package:taskitly/UI/widgets/price-widget.dart';
import 'package:taskitly/constants/palette.dart';
import 'package:taskitly/utils/widget_extensions.dart';
import '../../../../constants/reuseables.dart';
import '../../../../core/models/mtn_data_response_model.dart';
import '../../../base/base.ui.dart';
import '../../../widgets/appbar.dart';
import '../../../widgets/text_field.dart';

class DataViewScreen extends StatelessWidget {
  const DataViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView<DataBillViewViewModel>(
      onModelReady: (model) async => model.init(context),
      builder: (_, model, child) => RefreshIndicator(
        onRefresh: () async => model.init(context),
        child: Scaffold(
            appBar: AppBars(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Text("Mobile data"),
                        const Spacer(),
                        InkWell(
                          onTap: () {
                            model.history();
                          },
                          child: AppText(
                            "History",
                            size: 15.sp,
                            color: primaryColor,
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              elevation: 1,
            ),
            body: SafeArea(
                child: Column(children: [
              30.0.sbH,
              SizedBox(
                height: 40,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    16.0.sbW,
                    SizedBox(
                      width: 80,
                      child: IntrinsicWidth(
                        child: DropdownButtonFormField<Map<String, dynamic>>(
                          borderRadius: BorderRadius.circular(12),
                          icon: const Icon(Icons.keyboard_arrow_down),
                          value: model.selectedBiller,
                          items: model.dataBillers
                              .map((e) => DropdownMenuItem(
                                    value: e,
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        SvgPicture.asset(
                                          e["image"],
                                          height: 25,
                                          width: 25,
                                        ),
                                      ],
                                    ),
                                  ))
                              .toList(),
                          onChanged: model.changeBiller,
                          hint: const AppText("Select"),
                          isExpanded: true,
                          // validator: validator,
                          decoration: InputDecoration(
                            errorMaxLines: 3,
                            border: InputBorder.none,
                            isDense: true,
                            hintStyle: TextStyle(
                                color: Theme.of(context).disabledColor),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 5, right: 8),
                      height: 40,
                      width: 1,
                      color: Colors.grey,
                    ),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          AppTextField(
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                              LengthLimitingTextInputFormatter(11)
                            ],
                            keyboardType: TextInputType.phone,
                            borderless: true,
                            onChanged: model.onChange,
                            controller: model.phoneNumberController,
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 0),
                            isPassword: false,
                            hint: "Enter phone number",
                            enabledBorder: InputBorder.none,
                          ),
                        ],
                      ),
                    ),
                    10.0.sbW,
                    InkWell(
                      onTap: model.requestContactsPermission,
                      child: SvgPicture.asset(
                        AppImages.personCircle,
                        height: 30,
                        width: 30,
                      ),
                    ),
                    16.0.sbW
                  ],
                ),
              ),
              const Divider(),
              14.0.sbH,
              Expanded(
                child: AppCard(
                  margin: 16.0.padA,
                  useShadow: true,
                  padding: 10.0.padA,
                  backgroundColor: Colors.white,
                  child: DefaultTabController(
                    length: 4,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TabBar(
                          isScrollable: true,
                          indicatorColor: primaryColor,
                          labelPadding: 15.0.padH,
                          indicator: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                                      color: primaryColor, width: 2))),
                          tabs: const [
                            Tab(text: 'Daily'),
                            Tab(text: 'Weekly'),
                            Tab(text: 'Monthly'),
                            Tab(text: 'Other'),
                          ],
                        ),
                        Expanded(
                          child: TabBarView(
                            children: [
                              DataScreenButton(
                                  data: model.daily,
                                  onTap: model.selectData,
                                  model: model),
                              DataScreenButton(
                                  data: model.weekly,
                                  onTap: model.selectData,
                                  model: model),
                              DataScreenButton(
                                  data: model.monthly,
                                  onTap: model.selectData,
                                  model: model),
                              DataScreenButton(
                                  data: model.other,
                                  onTap: model.selectData,
                                  model: model),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ]))),
      ),
    );
  }
}

class DataScreenButton extends StatelessWidget {
  final List<UseData> data;
  final Function(UseData) onTap;
  final DataBillViewViewModel model;
  const DataScreenButton({
    super.key,
    required this.data,
    required this.onTap,
    required this.model,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: 20.0.padA,
      child: GridView.builder(
          itemCount: data.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 16.0,
            mainAxisSpacing: 16.0,
            childAspectRatio: 1.5,
            mainAxisExtent: 91.0,
          ),
          itemBuilder: (_, i) {
            return AppCard(
              onTap: () => model.payData(data[i].object?.slug,
                  data[i].object?.amount), //onTap(data[i]),
              padding: 10.0.padA,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  AppText(extractDataAmount(data[i].name ?? "")),
                  5.0.sbH,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      PriceWidget(
                        value: data[i].object?.amount,
                        fontSize: 12,
                        color: hintTextColor,
                      ),
                    ],
                  )
                ],
              ),
            );
          }),
    );
  }

  String extractDataAmount(String packageName) {
    // Split the package name into words
    List<String> words = packageName.split(' ');

    String data = words[1];

    if (data.contains("_")) {
      String newData = data.replaceAll("_", ".");
      data = newData;
    }
    String amount = data + words[2];

    return amount;
  }
}
