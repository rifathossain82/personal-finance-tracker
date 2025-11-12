import 'dart:io';

import 'package:personal_finance_tracker/src/core/core.dart';
import 'package:flutter/material.dart';

class ImagePickerWidget extends StatelessWidget {
  final Function(File?) onPicked;
  final File? selectedFile;
  final String? existingURL;
  final double height;
  final double width;
  final double borderRadius;
  final String placeholderPath;

  const ImagePickerWidget({
    super.key,
    required this.onPicked,
    this.selectedFile,
    this.existingURL,
    this.height = 115,
    this.width = 115,
    this.borderRadius = 100,
    this.placeholderPath = AssetPath.person,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            color: kTextFieldFillColor,
            borderRadius: BorderRadius.circular(borderRadius),
            border: Border.all(
              color: kBlackLight.withValues(alpha: 0.50),
              width: 1,
            ),
            image: selectedFile != null || existingURL != null
                ? DecorationImage(
                    fit: BoxFit.cover,
                    image: selectedFile != null
                        ? FileImage(selectedFile!)
                        : NetworkImage(existingURL!),
                  )
                : DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage(placeholderPath),
                  ),
          ),
        ),
        Positioned(
          child: Container(
            width: width,
            height: height,
            padding: const EdgeInsets.all(6),
            alignment: Alignment.bottomCenter,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(borderRadius),
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.transparent,
                  kGrey,
                ],
              ),
            ),
            child: GestureDetector(
              onTap: () {
                ImageServices.openImageFileSelectorDialog(
                  context: context,
                  onPicked: onPicked,
                );
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    selectedFile == null && existingURL == null ? 'ছবি সংযুক্ত করুন' : 'ছবি আপডেট করুন',
                    textAlign: TextAlign.center,
                    style: context.bodyMedium(
                      color: kWhite,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Icon(
                    Icons.camera_alt,
                    color: kWhite,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
