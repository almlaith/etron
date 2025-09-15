import 'package:etron_flutter/pages/Intro/welcome_screen.dart';
import 'package:etron_flutter/pages/home/home_screen.dart';
import 'package:etron_flutter/ui/theme/type.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'common/button/language/language_wrapper.dart';
import 'l10n/app_localizations.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

   await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
     // DeviceOrientation.portraitDown,
  ]);

  await dotenv.load(fileName: ".env");
  // await dotenv.load(fileName: ".env.development", mergeWith: dotenv.env);
  // await dotenv.load(fileName: ".env.stg", mergeWith: dotenv.env);
  // await dotenv.load(fileName: ".env.pre", mergeWith: dotenv.env);
  debugPrint('BEARER_TOKEN loaded: ${dotenv.env['BEARER_TOKEN_MZN_GATEWAY']}');

  runApp(const EtronApp());
}

class EtronApp extends StatefulWidget {
  const EtronApp({super.key});

  @override
  State<EtronApp> createState() => _EtronAppState();
}

class _EtronAppState extends State<EtronApp> {
  Locale _locale = const Locale('en');

  void _toggleLanguage() {
    setState(() {
      _locale = _locale.languageCode == 'en'
          ? const Locale('ar')
          : const Locale('en');
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Etron',
      debugShowCheckedModeBanner: false,
      locale: _locale,
      supportedLocales: const [Locale('en'), Locale('ar')],
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF3A5DAE)),
        useMaterial3: true,
      ),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(textTheme: buildTextTheme(context)),
          child: Builder(
            builder: (ctx) => Directionality(
              textDirection: _locale.languageCode == 'ar'
                  ? TextDirection.rtl
                  : TextDirection.ltr,
              child: LanguageWrapper(
                onToggleLanguage: _toggleLanguage,
                child: child!,
              ),
            ),
          ),
        );
      },
      home: const StartGate(),
    );
  }
}

class StartGate extends StatefulWidget {
  const StartGate({super.key});

  @override
  State<StartGate> createState() => _StartGateState();
}

class _StartGateState extends State<StartGate> {
  late Future<_StartDest> _future;

  @override
  void initState() {
    super.initState();
    _future = _decideStartDestination();
  }

  Future<_StartDest> _decideStartDestination() async {
    final prefs = await SharedPreferences.getInstance();

    final isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
    final isPhoneVerified = prefs.getBool('isPhoneVerified') ?? false;

    final accessToken = prefs.getString('accessToken');
    final hasToken = accessToken != null && accessToken.isNotEmpty;

    if (isLoggedIn && hasToken) {
      return _StartDest.home;
    }

    if (!isLoggedIn && isPhoneVerified) {
      return _StartDest.home;
    }

    return _StartDest.welcome;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<_StartDest>(
      future: _future,
      builder: (context, snap) {
        if (snap.connectionState != ConnectionState.done) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (snap.hasError) {
          return const WelcomeScreen();
        }

        final dest = snap.data ?? _StartDest.welcome;
        if (dest == _StartDest.home) {
          return const HomeScreen();
        } else {
          return const WelcomeScreen();
        }
      },
    );
  }
}

enum _StartDest { welcome, home }
