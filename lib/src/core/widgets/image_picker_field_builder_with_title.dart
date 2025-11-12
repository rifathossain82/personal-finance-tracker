import 'dart:io';
import 'package:personal_finance_tracker/src/core/core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ImagePickerFieldBuilderWithTitle extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  final VoidCallback onClear;
  final File? picture;
  final String? imgURL;
  final String? hintText;
  final String? secondaryHintText;

  const ImagePickerFieldBuilderWithTitle({
    Key? key,
    required this.title,
    required this.onTap,
    required this.onClear,
    this.picture,
    this.imgURL,
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
        Row(
          children: [
            Expanded(
              child: KOutlinedButton(
                onPressed: onTap,
                borderColor: kGrey,
                height: 45,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Icon(
                      Icons.image,
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
                    if (picture != null || imgURL != null)
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
            ),
            const SizedBox(width: 8),
            Container(
              height: 45,
              width: 45,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                border: Border.all(
                  color: kGrey,
                  width: 1,
                ),
              ),
              child: picture != null
                  ? Image.file(
                      picture!,
                      height: 45,
                      width: 45,
                      fit: BoxFit.cover,
                    )
                  : picture == null && imgURL != null
                      ? Image.network(
                          '$imgURL',
                          height: 45,
                          width: 45,
                          fit: BoxFit.cover,
                        )
                      : const Icon(
                          CupertinoIcons.photo,
                        ),
            ),
          ],
        ),
        const SizedBox(height: 15),
      ],
    );
  }

  String _getDisplayText() {
    String text = hintText ?? "Choose File";

    if (picture != null) {
      text = ImageServices.getFileName(picture) ?? "";
    } else if (imgURL != null) {
      text = imgURL!.split('/').last;
    }

    return text.length > 25 ? text.substring(text.length - 25) : text;
  }
}
