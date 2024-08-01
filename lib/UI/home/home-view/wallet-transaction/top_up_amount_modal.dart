import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:iconsax/iconsax.dart'; // Import BaseView
import 'package:provider/provider.dart';
import 'package:taskitly/UI/base/base.ui.dart';
import 'package:taskitly/UI/home/home-view/home-view-vm.dart';
import 'package:taskitly/UI/home/home-view/trasaction-view-vm/transactions-view-model.dart';
import 'package:taskitly/UI/widgets/appCard.dart';
import 'package:taskitly/UI/widgets/app_button.dart';
import 'package:taskitly/UI/widgets/apptexts.dart';
import 'package:taskitly/UI/widgets/text_field.dart';
import 'package:taskitly/constants/palette.dart';
import 'package:taskitly/constants/reuseables.dart';
import 'package:taskitly/utils/snack_message.dart';
import 'package:taskitly/utils/widget_extensions.dart';

class TopUpAmountModal extends StatelessWidget {
  const TopUpAmountModal({super.key});

  @override
  Widget build(BuildContext context) {
    return OtherView<TransactionViewModel>(
      onModelReady: (model) => () {},
      builder: (context, model, child) {
        return Column(
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
                    "Top Up Wallet",
                    size: 20.sp,
                    weight: FontWeight.w600,
                    align: TextAlign.center,
                  ),
                  16.0.sbH,
                  SvgPicture.asset(
                    AppImages.walletImage,
                    height: 80,
                    width: 80,
                  ),
                  16.0.sbH,
                  Padding(
                    padding: 16.0.padH,
                    child: AppText(
                      "Money sent to this account will automatically be credited to your wallet",
                      color: const Color(0xFF6B6B6B),
                      size: 12.sp,
                      align: TextAlign.center,
                    ),
                  ),
                  20.0.sbH,
                  Row(
                    children: [
                      AppText(
                        "Top up amount",
                        color: const Color(0xFF2B2B2B),
                        size: 15.sp,
                        weight: FontWeight.w400,
                      ),
                    ],
                  ),
                  10.0.sbH,
                  Row(
                    children: [
                      AppText(
                        "Enter the amount you will like to top-up",
                        align: TextAlign.end,
                        color: const Color(0xFF6B6B6B),
                        size: 12.sp,
                        maxLine: 1,
                        overflow: TextOverflow.ellipsis,
                        weight: FontWeight.w400,
                      ),
                    ],
                  ),
                  AppTextField(
                    hintText: "",
                    hint: "",
                    controller: model.amountController,
                    onChanged: model.onChange,
                    // validator: emailValidator,
                  ),
                  // 10.0.sbH,
                  Row(
                    children: [
                      Expanded(
                        child: AppButton(
                          text: "Make Payment",
                          onTap: () async {
                            model.fundWallet(
                                amount: model.amountController.text,
                                onComplete: () {
                                  model.accountInfo('weeee');
                                });

                            // navigationService.goBack();
                            //onTap();
                          },
                          textColor: Colors.white,
                          borderWidth: 2,
                          backGroundColor: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  40.0.sbH,
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
