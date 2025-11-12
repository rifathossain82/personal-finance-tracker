// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:personal_finance_tracker/src/core/core.dart';
// import 'package:personal_finance_tracker/src/features/auth/controller/auth_controller.dart';
//
// class ContactTypeSelectorWidget extends StatelessWidget {
//   const ContactTypeSelectorWidget({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final authController = Get.find<AuthController>();
//
//     return Obx(() {
//       return Container(
//         width: double.maxFinite,
//         height: 51,
//         alignment: Alignment.center,
//         padding: const EdgeInsets.all(4),
//         decoration: BoxDecoration(
//           color: kTextFieldFillColor,
//           borderRadius: BorderRadius.circular(24),
//           border: Border.all(
//             color: kBorderColor,
//             width: 1.0,
//           ),
//         ),
//         child: Row(
//           children: ContactType.values
//               .map(
//                 (type) => _ContactTypeWidget(
//                   type: type,
//                   isSelected: authController.selectedContactType.value == type,
//                   onPressed: () => authController.changeContactType(
//                     type,
//                   ),
//                 ),
//               )
//               .toList(),
//         ),
//       );
//     });
//   }
// }
//
// class _ContactTypeWidget extends StatelessWidget {
//   final ContactType type;
//   final bool isSelected;
//   final VoidCallback onPressed;
//
//   const _ContactTypeWidget({
//     required this.type,
//     required this.isSelected,
//     required this.onPressed,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Expanded(
//       child: GestureDetector(
//         onTap: onPressed,
//         child: AnimatedOpacity(
//           opacity: isSelected ? 1.0 : 0.8,
//           duration: const Duration(milliseconds: 300),
//           child: AnimatedContainer(
//             duration: const Duration(milliseconds: 300),
//             alignment: Alignment.center,
//             decoration: BoxDecoration(
//               color: isSelected ? kWhite : kTextFieldFillColor,
//               borderRadius: BorderRadius.circular(24),
//             ),
//             child: Text(
//               type.name.capitalizedFirst,
//               style: context.bodyLarge(
//                 fontWeight: FontWeight.w500,
//                 color: isSelected ? kPrimaryColor : kGreyTextColor,
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
