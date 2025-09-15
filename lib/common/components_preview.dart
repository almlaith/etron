// import 'package:etron_flutter/ui/theme/colors.dart';
// import 'package:flutter/material.dart';
// import '../l10n/app_localizations.dart';
// import 'button/primary_button.dart';
// import 'card/card.dart';
// import 'card/list_item.dart';
// import 'display/empty_state.dart';
// import 'display/section_title.dart';
// import 'field/input_field.dart';
// import 'field/toggle_switch.dart';
// import 'navigation/bar.dart';
// import 'navigation/bottom_sheet.dart';
// import 'navigation/side_menu.dart';
// import 'navigation/tab_bar.dart';
// import 'overlays/dialog.dart';
// import 'overlays/snackbar.dart';
//
// class ComponentsPreviewScreen extends StatefulWidget {
//   const ComponentsPreviewScreen({super.key});
//
//   @override
//   State<ComponentsPreviewScreen> createState() =>
//       _ComponentsPreviewScreenState();
// }
//
// class _ComponentsPreviewScreenState extends State<ComponentsPreviewScreen>
//     with SingleTickerProviderStateMixin {
//   bool _isSwitchOn = true;
//   int _selectedMenuItemIndex = 0;
//   late final TabController _tabController;
//   final _textController = TextEditingController();
//   final _passwordController = TextEditingController();
//
//   @override
//   void initState() {
//     super.initState();
//     _tabController = TabController(length: 3, vsync: this);
//   }
//
//   @override
//   void dispose() {
//     _tabController.dispose();
//     _textController.dispose();
//     _passwordController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final l10n = AppLocalizations.of(context)!;
//
//     final sideMenuItems = [
//       SideMenuItem(
//         title: l10n.sideMenuDashboard,
//         leadingIcon: Icons.dashboard_outlined,
//         onTap: () {},
//       ),
//       SideMenuItem(
//         title: l10n.sideMenuStations,
//         icon: 'assets/icons/sidebar.svg',
//         onTap: () {},
//       ),
//       SideMenuItem(
//         title: l10n.sideMenuUsers,
//         leadingIcon: Icons.people_outline,
//         onTap: () {},
//       ),
//       SideMenuItem(
//         title: l10n.sideMenuLogout,
//         leadingIcon: Icons.logout,
//         onTap: () {},
//       ),
//     ];
//
//     return Scaffold(
//       backgroundColor: AppColors.backgroundLight,
//       appBar: Bar(
//         title: l10n.componentsPreviewTitle,
//         actions: [
//           IconButton(onPressed: () {}, icon: const Icon(Icons.info_outline)),
//         ],
//       ),
//       drawer: SideMenu(
//         items: sideMenuItems.asMap().entries.map((entry) {
//           int idx = entry.key;
//           SideMenuItem item = entry.value;
//           return SideMenuItem(
//             title: item.title,
//             icon: item.icon,
//             leadingIcon: item.leadingIcon,
//             isSelected: _selectedMenuItemIndex == idx,
//             onTap: () {
//               setState(() => _selectedMenuItemIndex = idx);
//               Navigator.of(context).pop();
//             },
//           );
//         }).toList(),
//       ),
//       body: ListView(
//         padding: const EdgeInsets.all(16.0),
//         children: [
//           SectionTitle(
//             title: l10n.sectionButtons,
//             leadingIcon: Icons.touch_app,
//           ),
//           const SizedBox(height: 12),
//           PrimaryButton(text: l10n.primaryButton, onPressed: () {}),
//           const SizedBox(height: 12),
//           PrimaryButton(
//             text: l10n.buttonWithIcon,
//             icon: 'assets/icons/battery_half.svg',
//             onPressed: () {},
//           ),
//           const SizedBox(height: 12),
//           PrimaryButton(
//             text: l10n.loadingButton,
//             isLoading: true,
//             onPressed: () {},
//           ),
//           const SizedBox(height: 12),
//           PrimaryButton(
//             text: l10n.warningButton,
//             color: AppColors.warning,
//             onPressed: () {},
//           ),
//           const SizedBox(height: 24),
//
//           SectionTitle(
//             title: l10n.sectionCards,
//             leadingIcon: Icons.view_agenda_outlined,
//           ),
//           const SizedBox(height: 12),
//           EtronCard(
//             icon: 'assets/icons/car.svg',
//             iconColor: AppColors.secondary,
//             trailing: AppToggleSwitch(
//               value: _isSwitchOn,
//               onChanged: (val) => setState(() => _isSwitchOn = val),
//             ),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   l10n.totalBalance,
//                   style: const TextStyle(color: AppColors.textSecondary),
//                 ),
//                 const Text(
//                   '\$ 1,488.00',
//                   style: TextStyle(
//                     fontSize: 22,
//                     fontWeight: FontWeight.bold,
//                     color: AppColors.textPrimary,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           const SizedBox(height: 24),
//
//           SectionTitle(title: l10n.sectionCards, leadingIcon: Icons.list_alt),
//           const SizedBox(height: 12),
//           EtronCard(
//             padding: const EdgeInsets.symmetric(horizontal: 8),
//             child: Column(
//               children: [
//                 ListItem(
//                   title: l10n.profileSettings,
//                   subtitle: l10n.updateYourInfo,
//                   leadingIcon: Icons.person_outline,
//                   onTap: () {},
//                 ),
//                 const Divider(height: 1, color: AppColors.divider),
//                 ListItem(
//                   title: l10n.myVehicles,
//                   icon: 'assets/icons/car.svg',
//                   iconColor: AppColors.tertiary,
//                   onTap: () {},
//                 ),
//                 const Divider(height: 1, color: AppColors.divider),
//                 ListItem(
//                   title: l10n.deleteAccount,
//                   leadingIcon: Icons.delete_outline,
//                   leadingIconColor: AppColors.error,
//                   titleStyle: const TextStyle(color: AppColors.error),
//                   onTap: () {},
//                 ),
//               ],
//             ),
//           ),
//           const SizedBox(height: 24),
//
//            SectionTitle(
//             title: l10n.sectionInputFields,
//             leadingIcon: Icons.edit_note,
//           ),
//           const SizedBox(height: 12),
//           InputField(label: l10n.username, controller: _textController),
//           const SizedBox(height: 12),
//           InputField(
//             label: l10n.password,
//             controller: _passwordController,
//             obscureText: true,
//           ),
//           const SizedBox(height: 12),
//           InputField(
//             label: l10n.invalidInput,
//             controller: TextEditingController(text: 'wrong@'),
//             errorText: l10n.invalidEmailError,
//           ),
//           const SizedBox(height: 24),
//
//            SectionTitle(
//             title: l10n.sectionDisplay,
//             leadingIcon: Icons.layers_outlined,
//           ),
//           const SizedBox(height: 12),
//           AppTabBar(
//             controller: _tabController,
//             tabs: [
//               Tab(text: l10n.overview),
//               Tab(text: l10n.details),
//               Tab(text: l10n.history),
//             ],
//           ),
//           SizedBox(
//             height: 120,
//             child: EmptyState(
//               message: l10n.emptyStateMessage,
//               icon: 'assets/icons/empty.svg',
//             ),
//           ),
//           const SizedBox(height: 24),
//
//           SectionTitle(
//             title: l10n.sectionOverlays,
//             leadingIcon: Icons.notifications_outlined,
//           ),
//           const SizedBox(height: 12),
//           Wrap(
//             spacing: 8,
//             alignment: WrapAlignment.center,
//             children: [
//               ElevatedButton(
//                 child: Text(l10n.showDialog),
//                 onPressed: () => showAppDialog(
//                   context,
//                   title: l10n.dialogTitle,
//                   message: l10n.dialogMessage,
//                   leadingIcon: Icons.help_outline,
//                 ),
//               ),
//               ElevatedButton(
//                 child: Text(l10n.showSnackbar),
//                 onPressed: () => showAppSnackbar(
//                   context,
//                   l10n.snackbarSuccess,
//                   leadingIcon: Icons.check_circle,
//                 ),
//               ),
//               ElevatedButton(
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: AppColors.error,
//                 ),
//                 child: Text(l10n.showError),
//                 onPressed: () => showAppSnackbar(
//                   context,
//                   l10n.snackbarError,
//                   isError: true,
//                   leadingIcon: Icons.error_outline,
//                 ),
//               ),
//               ElevatedButton(
//                 child: Text(l10n.showBottomSheet),
//                 onPressed: () => showModalBottomSheet(
//                   context: context,
//                   builder: (_) => EtronBottomSheet(
//                     title: l10n.bottomSheetTitle,
//                     content: Text(l10n.bottomSheetContent),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }
