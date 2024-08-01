import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taskitly/utils/string-extensions.dart';
import 'package:taskitly/utils/widget_extensions.dart';

import '../../../../../../constants/palette.dart';
import '../../../../../../constants/reuseables.dart';
import '../../../../../../core/models/skills-response.dart';
import '../../../../../widgets/apptexts.dart';

class SkillsScreenOption extends StatefulWidget {
  final List<Skill> skill;
  final List<Skill> selectedSkill;
  final Function(Skill) selectSkill;
  const SkillsScreenOption(
      {super.key,
      required this.skill,
      required this.selectSkill,
      required this.selectedSkill});

  @override
  State<SkillsScreenOption> createState() => _SkillsScreenOptionState();
}

class _SkillsScreenOptionState extends State<SkillsScreenOption> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height(context) * 0.7,
      child: Column(
        children: [
          15.0.sbH,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              30.0.sbW,
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AppText(
                    "Select service".toTitleCase(),
                    size: 18.sp,
                    weight: FontWeight.w600,
                  ),
                  AppText(
                    "you can select more than one skills".toTitleCase(),
                    size: 12.sp,
                    color: hintTextColor,
                  ),
                ],
              ),
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
              ),
            ],
          ),
          15.0.sbH,
          widget.skill.isEmpty
              ? const Expanded(
                  child: Center(
                    child: AppText("No Skill in Service Category"),
                  ),
                )
              : ListView.builder(
                  itemCount: widget.skill.length,
                  shrinkWrap: true,
                  itemBuilder: (_, i) {
                    return Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () async {
                          setState(() {
                            widget.selectSkill(widget.skill[i]);
                          });
                        },
                        child: Container(
                          height: 50,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 15),
                          decoration: BoxDecoration(
                              color: widget.selectedSkill.any(
                                      (element) => widget.skill[i] == element)
                                  ? primaryDarkColor
                                  : null,
                              border: Border(
                                  bottom: BorderSide(
                                      color: widget.selectedSkill.any(
                                              (element) =>
                                                  widget.skill[i] == element)
                                          ? white
                                          : hintTextColor.withOpacity(0.3),
                                      width: 0.5))),
                          alignment: Alignment.centerLeft,
                          child: AppText(
                            widget.skill[i].name ?? "",
                            isBold: true,
                            size: 12,
                            color: widget.selectedSkill.any(
                                    (element) => widget.skill[i] == element)
                                ? white
                                : null,
                          ),
                        ),
                      ),
                    );
                  })
        ],
      ),
    );
  }
}
