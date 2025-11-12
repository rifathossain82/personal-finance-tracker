import 'package:flutter/material.dart';
import 'package:personal_finance_tracker/src/core/core.dart';

class GoogleMapButton extends StatelessWidget {
  final String? location;
  final String? label;

  const GoogleMapButton({
    super.key,
    required this.location,
    this.label,
  });

  @override
  Widget build(BuildContext context) {
    if (location == null) {
      return const SizedBox.shrink();
    }

    return GestureDetector(
      onTap: () => UrlLauncherServices.openGoogleMapsWithSearch(location ?? ''),
      behavior: HitTestBehavior.opaque,
      child: Container(
        height: 30,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: kWhite,
          borderRadius: BorderRadius.circular(4),
          border: Border.all(
            color: kPrimaryColor,
            width: 1.0,
          )
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.location_on,
              color: kPrimaryColor,
              size: 20,
            ),
            const SizedBox(width: 6),
            Text(
              label ?? "গুগল ম্যাপ",
              style: context.outlinedButtonTextStyle(),
            ),
          ],
        ),
      ),
    );
  }
}
