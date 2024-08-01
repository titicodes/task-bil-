import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:taskitly/UI/home/bills-view/payment-view/payment-details-vm.dart';
import 'package:taskitly/UI/widgets/apptexts.dart';
import 'package:taskitly/constants/palette.dart';
import 'package:taskitly/constants/reuseables.dart';
import 'package:taskitly/utils/string-extensions.dart';
import 'package:taskitly/utils/widget_extensions.dart';

import '../../../../core/models/airtime_response_model.dart';
import '../../../base/base.ui.dart';
import '../../../widgets/appCard.dart';
import '../../../widgets/app_button.dart';

class ElectricityPaymentDetailsScreen extends StatelessWidget {
  // modified something here remember if code brs
  final String? phoneNumber;
  final String amount;
  final String? selectedDataName;
  final AirTimeServiceProvider? selectedProvider;

  const ElectricityPaymentDetailsScreen(
      {super.key,
      required this.phoneNumber,
      required this.amount,
      this.selectedProvider,
      this.selectedDataName});

  @override
  Widget build(BuildContext context) {
    return OtherView<PaymentDetailsViewModel>(
      onModelReady: (m) => m.init(
          phoneNumber: phoneNumber!,
          amount: amount,
          selectedProvider: selectedProvider,
          selectedDataName: selectedDataName,
          contexts: context),
      builder: (_, model, child) => Form(
        key: model.formKey,
        child: Stack(
          children: [
            Column(
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
                Padding(
                  padding: 16.0.padH,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AppText(
                        "₦$amount".toTitleCase(),
                        size: 20.sp,
                        weight: FontWeight.w600,
                      ),
                      5.0.sbH,
                      Row(
                        children: [
                          const Text(
                            "Product Name",
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const Spacer(),
                          Row(
                            children: [
                              // SvgPicture.asset(
                              //   AppImages.mtn,
                              //   height: 16,
                              //   width: 16,
                              // ),
                              5.0.sbW,
                              SizedBox(
                                width: 150,
                                child: Text(
                                  selectedDataName ?? "",
                                  maxLines: 1,
                                  textAlign: TextAlign.right,
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          const Text(
                            "Amount:",
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const Spacer(),
                          Text(
                            "₦$amount",
                            style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Row(
                        children: [
                          // Text(
                          //   "Phone Number: ",
                          //   style: TextStyle(
                          //     color: Colors.black,
                          //     fontWeight: FontWeight.w500,
                          //   ),
                          // ),
                          // Spacer(),
                          // Text(
                          //   "$phoneNumber",
                          //   style: TextStyle(
                          //     color: Colors.black,
                          //     fontWeight: FontWeight.w500,
                          //   ),
                          // ),
                        ],
                      ),
                      const Divider(),
                      const SizedBox(
                        height: 10,
                      ),
                      const Row(
                        children: [
                          Text(
                            "PAYMENT METHOD: ",
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Spacer(),
                          // Container(
                          //   width: 180,
                          //   child: Text(
                          //     selectedProvider?.name ?? selectedDataName!,
                          //     overflow: TextOverflow
                          //         .ellipsis, // Use the selected provider's name
                          //     style: TextStyle(
                          //       color: Colors.black,
                          //       fontWeight: FontWeight.w500,
                          //     ),
                          //     textAlign: TextAlign.right,
                          //   ),
                          // ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      AppCard(
                        onTap: () {},
                        margin: 0.0.padA,
                        padding: 15.0.padA,
                        child: Row(
                          children: [
                            SvgPicture.asset(
                              AppImages.walletBalance,
                              height: 24.sp,
                              width: 24.sp,
                            ),
                            5.0.sbW,
                            Expanded(
                                child: AppText(
                              "Balance (₦${model.userService.user.walletBalance ?? 0})",
                              size: 14.sp,
                              overflow: TextOverflow.ellipsis,
                              maxLine: 1,
                            ))
                          ],
                        ),
                      ),
                      32.0.sbH,
                      AppButton(
                        backGroundColor: const Color(0xFF1CBF73),
                        text: "",
                        onTap: model.enterAirtimePin,
                        child: Padding(
                          padding: 5.0.padH,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                AppImages.coins,
                                height: 16,
                                width: 16,
                              ),
                              5.0.sbW,
                              const AppText(
                                "Pay",
                                color: Colors.white,
                              ),
                            ],
                          ),
                        ),
                      ),
                      16.0.sbH,
                    ],
                  ),
                )
              ],
            ),
            model.isLoading ? const SmallLoader() : 0.0.sbH
          ],
        ),
      ),
    );
  }
}
