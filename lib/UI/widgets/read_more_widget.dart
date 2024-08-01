import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class ReadMoreText extends StatefulWidget {
  final String fullText;
  final int viewableCharacterCount;
  final double? fontSize;
  final Color? fontColor;

  const ReadMoreText({
    super.key,
    required this.fullText,
    required this.viewableCharacterCount,
    this.fontSize,
    this.fontColor,
  });

  @override
  _ReadMoreTextState createState() => _ReadMoreTextState();
}

class _ReadMoreTextState extends State<ReadMoreText> {
  bool isExpanded = false;

  void toggleReadMore() {
    setState(() {
      isExpanded = !isExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    final text = isExpanded
        ? widget.fullText
        : widget.fullText.substring(
            0,
            widget.viewableCharacterCount < widget.fullText.length
                ? widget.viewableCharacterCount
                : widget.fullText.length,
          );

    final readMoreText = isExpanded ? ' Read Less' : ' Read More';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        RichText(
          text: TextSpan(
            children: <InlineSpan>[
              TextSpan(
                text: text,
                style: TextStyle(
                  color: widget.fontColor,
                  fontWeight: FontWeight.w400,
                  fontSize: widget.fontSize ?? 15,
                ),
              ),
              if (widget.fullText.length > widget.viewableCharacterCount)
                TextSpan(
                  text: isExpanded ? '' : '...$readMoreText',
                  style: TextStyle(
                      color: Theme.of(context).textTheme.titleLarge?.color,
                      fontWeight: FontWeight.w600),
                  recognizer: TapGestureRecognizer()..onTap = toggleReadMore,
                ),
            ],
          ),
        ),
        if (isExpanded)
          InkWell(
            onTap: toggleReadMore,
            child: Text(
              ' Read Less',
              style: TextStyle(
                  color: Theme.of(context).textTheme.titleLarge?.color,
                  fontWeight: FontWeight.w600),
            ),
          ),
      ],
    );
  }
}
