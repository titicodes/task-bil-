import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taskitly/UI/widgets/apptexts.dart';
import 'package:taskitly/constants/palette.dart';
import 'package:taskitly/constants/reuseables.dart';
import '../../../../../core/models/bank-list-response.dart';
import '../../../../utils/widget_extensions.dart';
import '../../../widgets/text_field.dart';

class WithdrawalBankListScreen extends StatefulWidget {
  final List<BankResult> banks; // List of banks
  final Function(String, String) onBankSelected;

  const WithdrawalBankListScreen(
      {Key? key, required this.banks, required this.onBankSelected})
      : super(key: key);

  @override
  State<WithdrawalBankListScreen> createState() =>
      _WithdrawalBankListScreenState();
}

class _WithdrawalBankListScreenState extends State<WithdrawalBankListScreen> {
  List<BankResult> filteredBanks = [];
  TextEditingController searchController = TextEditingController();
  filterBanks() {
    if (searchController.text.trim().isEmpty) {
      filteredBanks = widget.banks;
    } else {
      filteredBanks = widget.banks
          .where((bank) => bank.name!
              .toLowerCase()
              .contains(searchController.text.trim().toLowerCase()))
          .toList();
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    filterBanks();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height(context) * 0.7,
      child: Form(
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
                      color: secondaryColor,
                    ),
                    child: const Icon(
                      Icons.clear,
                      size: 18,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
            AppText(
              "Select Banks",
              size: 14.sp,
              overflow: TextOverflow.ellipsis,
              maxLine: 1,
              weight: FontWeight.bold,
            ),
            10.0.sbH,
            AppTextField(
              controller: searchController,
              hint: "Search available banks",
              onChanged: (val) {
                setState(() {
                  filterBanks();
                });
              },
            ),
            10.0.sbH,
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: filteredBanks.length, // Use banks?.length
                itemBuilder: (context, index) {
                  final bankDetails = filteredBanks[index];
                  String bankCode = bankDetails.code ?? "";
                  String bankName = bankDetails.name ?? "";
                  return Column(
                    children: [
                      ListTile(
                        title: Row(
                          children: [
                            Expanded(
                              child: AppText(
                                bankName,
                              ),
                            ),
                          ],
                        ),
                        onTap: () async {
                          // Handle bank selection if needed
                          widget.onBankSelected(bankName, bankCode);
                        },
                      ),
                      const Divider()
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
