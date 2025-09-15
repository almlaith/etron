import 'dart:math' as math;
import 'package:etron_flutter/pages/profile/personal_info_screen.dart';
import 'package:etron_flutter/pages/profile/vehicle/vehicle_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:etron_flutter/ui/theme/colors.dart';
import 'package:etron_flutter/common/button/primary_icon.dart';
import 'package:etron_flutter/common/card/group_card.dart';
import 'package:etron_flutter/common/button/outlined_soft_button.dart';
import 'package:etron_flutter/common/button/language/language_switch_bar.dart';
import 'package:etron_flutter/l10n/app_localizations.dart';
import 'package:etron_flutter/services/auth_service.dart';
import 'package:etron_flutter/services/vehicle_service.dart';
import 'package:etron_flutter/services/user_service.dart';
import 'package:etron_flutter/services/storage_service.dart';
import '../../common/card/add_vehicle_card.dart';
import '../auth/login/login_screen.dart';
import 'change_password_screen.dart';

class ProfileScreen extends StatefulWidget {
  final String? userName;
  final String brandName;
  final VoidCallback? onLoggedOutNavigate;

  const ProfileScreen({
    super.key,
    this.userName,
    this.brandName = 'ETRON',
    this.onLoggedOutNavigate,
  });

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _loggingOut = false;
  String? _fetchedName;
  bool _userHasCar = true;

  @override
  void initState() {
    super.initState();
    _loadDisplayName();
    _checkCarStatus();
  }

  Future<void> _checkCarStatus() async {
    final hasCar = await VehicleService.checkUserHasCar();
    if (mounted) {
      setState(() {
        _userHasCar = hasCar;
      });
    }
  }

  Future<void> _loadDisplayName() async {
    final name = await UserService.getDisplayNameFromProfile();
    if (!mounted) return;
    setState(() => _fetchedName = name);
  }

  Future<void> _logout() async {
    if (_loggingOut) return;
    setState(() => _loggingOut = true);

    bool navigated = false;
    try {
      await AuthService.logout();
      await StorageService.clear();

      if (!mounted) return;
      if (widget.onLoggedOutNavigate != null) {
        navigated = true;
        widget.onLoggedOutNavigate!();
      } else {
        navigated = true;
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (_) => const LoginScreen()),
              (route) => false,
        );
      }
    } finally {
      if (!navigated && mounted) setState(() => _loggingOut = false);
    }
  }

  Widget _buildHandIcon(bool isRtl, {double height = 30}) {
    return Transform(
      alignment: Alignment.center,
      transform: isRtl ? Matrix4.identity() : Matrix4.rotationY(math.pi),
      child: SvgPicture.asset(
        'assets/icons/hand-wave.svg',
        height: height,
        colorFilter: const ColorFilter.mode(AppColors.primary, BlendMode.srcIn),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final year = DateTime.now().year.toString();

    final displayName = _fetchedName?.trim().isNotEmpty == true
        ? _fetchedName!
        : (widget.userName ?? '');

    final isRtl = Directionality.of(context) == TextDirection.rtl;

    const double titleFontSize = 30.0;
    final welcomeText = t.welcomeUser(displayName.isEmpty ? ' ' : displayName);

    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: AlignmentDirectional.centerStart,
                child: IconButton(
                  onPressed: () => Navigator.of(context).maybePop(),
                  icon: const Icon(
                    Icons.arrow_back_ios_new,
                    color: AppColors.textPrimary,
                  ),
                  splashRadius: 22,
                ),
              ),
              const SizedBox(height: 22),

              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(text: welcomeText),
                    WidgetSpan(
                      alignment: PlaceholderAlignment.middle,
                      child: Padding(
                        padding: const EdgeInsetsDirectional.only(start: 8.0),
                        child: _buildHandIcon(isRtl, height: titleFontSize),
                      ),
                    ),
                  ],
                ),
                textAlign: TextAlign.start,
                style: const TextStyle(
                  fontSize: titleFontSize,
                  fontWeight: FontWeight.w900,
                  color: AppColors.textPrimary,
                  letterSpacing: .2,
                  height: 1.1,
                ),
              ),
              const SizedBox(height: 5),
              if (!_userHasCar)
                AddVehicleCard(
                  onTap: () async {
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const VehiclesScreen(),
                      ),
                    );
                    _checkCarStatus();
                  },
                ),

              const SizedBox(height: 10),

              Text(
                t.account,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w900,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 14),

              GroupCard(
                children: [
                  ListTile(
                    leading: const PrimaryIcon(
                      icon: 'assets/icons/user.svg',
                      iconSize: 28,
                      iconColor: AppColors.primary,
                    ),
                    title: Text(
                      t.personalInformation,
                      style: const TextStyle(
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.w800,
                        fontSize: 18,
                      ),
                    ),
                    trailing: const Icon(
                      Icons.chevron_right,
                      color: AppColors.textSecondary,
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const PersonalInfoScreen(),
                        ),
                      );
                    },
                  ),
                  ListTile(
                    leading: const PrimaryIcon(
                      icon: 'assets/icons/lock.svg',
                      iconSize: 28,
                      iconColor: AppColors.primary,
                    ),
                    title: Text(
                      t.password,
                      style: const TextStyle(
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.w800,
                        fontSize: 18,
                      ),
                    ),
                    trailing: const Icon(
                      Icons.chevron_right,
                      color: AppColors.textSecondary,
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const ChangePasswordScreen(),
                        ),
                      );
                    },
                  ),
                  ListTile(
                    leading: const PrimaryIcon(
                      icon: 'assets/icons/car.svg',
                      iconSize: 28,
                      iconColor: AppColors.primary,
                    ),
                    title: Text(
                      t.vehicles,
                      style: const TextStyle(
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.w800,
                        fontSize: 18,
                      ),
                    ),
                    trailing: const Icon(
                      Icons.chevron_right,
                      color: AppColors.textSecondary,
                    ),
                    onTap: () async {
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const VehiclesScreen(),
                        ),
                      );
                      _checkCarStatus();
                    },
                  ),
                ],
              ),
              const SizedBox(height: 28),
              Text(
                t.settings,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w900,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 14),
              GroupCard(
                children: [
                  ListTile(
                    leading: const PrimaryIcon(
                      icon: 'assets/icons/bell.svg',
                      iconSize: 28,
                      iconColor: AppColors.primary,
                    ),
                    title: Text(
                      t.notifications,
                      style: const TextStyle(
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.w800,
                        fontSize: 18,
                      ),
                    ),
                    trailing: const Icon(
                      Icons.chevron_right,
                      color: AppColors.textSecondary,
                    ),
                    onTap: () {},
                  ),
                ],
              ),
              const SizedBox(height: 14),
              LanguageSwitchBar(
                onChanged: () => mounted ? setState(() {}) : null,
              ),
              const SizedBox(height: 100),
              Center(
                child: Column(
                  children: [
                    Image.asset('assets/logo/logo-name.png', height: 80),
                    const SizedBox(height: 6),
                    Text(
                      t.copyright(widget.brandName, year),
                      style: const TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              const Divider(color: AppColors.divider, thickness: 1),
              const SizedBox(height: 12),
              OutlinedSoftButton(
                text: t.logout,
                onPressed: _loggingOut ? null : _logout,
              ),
            ],
          ),
        ),
      ),
    );
  }
}