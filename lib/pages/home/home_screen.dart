import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../services/gateway_service.dart';
import '../../services/vehicle_service.dart';
import '../../common/login_required_dialog.dart';
import '../../l10n/app_localizations.dart';
import '../auth/login/login_screen.dart';
import '../auth/otp/otp_verification_dialog.dart';
import '../profile/profile_screen.dart';
import '../../ui/theme/colors.dart';
import '../../common/field/search_location_field.dart';
import '../../common/filters/charger_filter_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _bottomIndex = 2;

  bool isPhoneVerified = false;
  bool isLoggedIn = false;
  bool _userHasCar = true;

  List<String> _chargerTypes = [];
  bool _typesLoading = false;
  String? _selectedChargerType;

  String _query = '';
  bool _searchLoading = false;

  @override
  void initState() {
    super.initState();
    _init();
  }

  Future<void> _init() async {
    await _loadVerificationState();
    if (isLoggedIn) {
      await _checkUserCarStatus();
    }
    if (!mounted) return;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      _maybeShowPhonePopup();
    });
  }

  Future<void> _loadVerificationState() async {
    final prefs = await SharedPreferences.getInstance();
    if (!mounted) return;
    setState(() {
      isPhoneVerified = prefs.getBool('isPhoneVerified') ?? false;
      isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
    });
  }

  Future<void> _checkUserCarStatus() async {
    if (!isLoggedIn) return;

    final hasCar = await VehicleService.checkUserHasCar();
    if (mounted) {
      setState(() {
        _userHasCar = hasCar;
      });
    }
  }

  Future<void> _saveVisitorState() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isPhoneVerified', true);
    await prefs.setBool('isLoggedIn', false);
  }

  void _maybeShowPhonePopup() {
    if (!isLoggedIn && !isPhoneVerified) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => PhoneVerificationDialog(
          onVerified: (phone) async {
            final formatted = await GatewayService.formatPhone('jo', phone);
            if (formatted != null &&
                await GatewayService.registerVisitorPhone(formatted)) {
              await _saveVisitorState();
              if (!mounted) return;
              setState(() => isPhoneVerified = true);
            }
          },
        ),
      );
    }
  }

  Widget _topOverlay(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SearchLocationField(
              hintText: l10n.searchHint,
              onChanged: (text) {
                _query = text;
              },
            ),
            const SizedBox(height: 10),
            if (_typesLoading)
              const SizedBox(
                height: 36,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: CircularProgressIndicator(strokeWidth: 2),
                ),
              )
            else
              ChargerFilterBar(
                chargerTypes: _chargerTypes,
                selectedType: _selectedChargerType,
                onTypeSelected: (type) {
                  if (!mounted) return;
                  setState(() => _selectedChargerType = type);
                },
                onFilterTap: () {
                },
              ),
          ],
        ),
      ),
    );
  }

  Widget _mapArea() => Container(color: Colors.grey.shade200);

  BottomNavigationBarItem _item(String path, int index) {
    final isSelected = _bottomIndex == index;
    final bool showNotificationDot = index == 4 && isLoggedIn && !_userHasCar;

    return BottomNavigationBarItem(
      icon: Stack(
        clipBehavior: Clip.none,
        children: [
          SvgPicture.asset(
            path,
            width: 24,
            colorFilter: ColorFilter.mode(
              isSelected ? AppColors.primary : AppColors.textPrimary,
              BlendMode.srcIn,
            ),
          ),
          if (showNotificationDot)
            Positioned(
              top: -2,
              right: -4,
              child: Container(
                width: 8,
                height: 8,
                decoration: const BoxDecoration(
                  color: AppColors.error,
                  shape: BoxShape.circle,
                ),
              ),
            ),
        ],
      ),
      label: '',
    );
  }

  Future<void> _onNavTap(int index) async {
    if (_bottomIndex == index && index != 4) return;

    if (index == 4) {
      if (!isLoggedIn) {
        final result = await showDialog<bool>(
          context: context,
          builder: (_) => LoginRequiredDialog(
            onConfirm: () => Navigator.pop(context, true),
          ),
        );

        if (result == true && mounted) {
          await Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (_) => const LoginScreen()),
                (route) => false,
          );
          return;
        }
      } else {
        await Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const ProfileScreen()),
        );
        if (!mounted) return;
        await _loadVerificationState();
        await _checkUserCarStatus();
      }
    } else {
      if (!mounted) return;
      setState(() => _bottomIndex = index);
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (isLoggedIn) {
          SystemNavigator.pop();
          return false;
        }
        return true;
      },
      child: Scaffold(
        body: Stack(
          children: [
            _mapArea(),
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: _topOverlay(context),
            ),
            Positioned(
              bottom: 20,
              right: 20,
              child: SvgPicture.asset(
                'assets/icons/heart.svg',
                width: 24,
                colorFilter: const ColorFilter.mode(
                  AppColors.primary,
                  BlendMode.srcIn,
                ),
              ),
            ),
            if (_searchLoading)
              const Positioned(
                bottom: 90,
                left: 16,
                child: SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(strokeWidth: 2),
                ),
              ),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: AppColors.surface,
          currentIndex: _bottomIndex,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: AppColors.primary,
          unselectedItemColor: AppColors.textPrimary,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          items: [
            _item('assets/icons/star.svg', 0),
            _item('assets/icons/plug.svg', 1),
            _item('assets/icons/home.svg', 2),
            _item('assets/icons/bell.svg', 3),
            _item('assets/icons/profile.svg', 4),
          ],
          onTap: _onNavTap,
        ),
      ),
    );
  }
}