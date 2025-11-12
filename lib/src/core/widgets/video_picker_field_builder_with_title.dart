import 'dart:io';
import 'package:personal_finance_tracker/src/core/core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class VideoPickerFieldBuilderWithTitle extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  final VoidCallback onClear;
  final File? videoFile;
  final String? videoURL;
  final String? hintText;
  final String? secondaryHintText;

  const VideoPickerFieldBuilderWithTitle({
    Key? key,
    required this.title,
    required this.onTap,
    required this.onClear,
    this.videoFile,
    this.videoURL,
    this.hintText,
    this.secondaryHintText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: Text(
                title,
                style: context.titleMedium(
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            if (secondaryHintText != null)
              Text(
                secondaryHintText ?? '',
                textAlign: TextAlign.end,
                style: context.bodyLarge(),
              ),
          ],
        ),
        const SizedBox(height: 5),
        KOutlinedButton(
          onPressed: onTap,
          borderColor: kGrey,
          height: 45,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Icon(
                Icons.video_file,
                color: kPrimaryColor,
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  _getDisplayText(),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: context.titleSmall(
                    color: kPrimaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(width: 4),
              if (videoFile != null || videoURL != null)
                IconButton(
                  onPressed: onClear,
                  icon: const Icon(
                    CupertinoIcons.clear_circled_solid,
                    size: 20,
                    color: kRed,
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: 15),
      ],
    );
  }

  String _getDisplayText() {
    String text = hintText ?? "Choose File";

    if (videoFile != null) {
      text = ImageServices.getFileName(videoFile) ?? "";
    } else if (videoURL != null) {
      text = videoURL!.split('/').last;
    }

    return text.length > 25 ? text.substring(text.length - 25) : text;
  }
}
