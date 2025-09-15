import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en')
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'Etron'**
  String get appTitle;

  /// No description provided for @welcomeMessage.
  ///
  /// In en, this message translates to:
  /// **'Welcome to Etron Station Finder'**
  String get welcomeMessage;

  /// No description provided for @welcomeUser.
  ///
  /// In en, this message translates to:
  /// **'Welcome, {userName}'**
  String welcomeUser(Object userName);

  /// No description provided for @findStation.
  ///
  /// In en, this message translates to:
  /// **'Find a Station'**
  String get findStation;

  /// No description provided for @station.
  ///
  /// In en, this message translates to:
  /// **'Station'**
  String get station;

  /// No description provided for @status.
  ///
  /// In en, this message translates to:
  /// **'Status'**
  String get status;

  /// No description provided for @componentsPreviewTitle.
  ///
  /// In en, this message translates to:
  /// **'Etron Components'**
  String get componentsPreviewTitle;

  /// No description provided for @sectionButtons.
  ///
  /// In en, this message translates to:
  /// **'Buttons'**
  String get sectionButtons;

  /// No description provided for @primaryButton.
  ///
  /// In en, this message translates to:
  /// **'Primary Button'**
  String get primaryButton;

  /// No description provided for @buttonWithIcon.
  ///
  /// In en, this message translates to:
  /// **'Button with Icon'**
  String get buttonWithIcon;

  /// No description provided for @loadingButton.
  ///
  /// In en, this message translates to:
  /// **'Loading...'**
  String get loadingButton;

  /// No description provided for @warningButton.
  ///
  /// In en, this message translates to:
  /// **'Warning Button'**
  String get warningButton;

  /// No description provided for @sectionCards.
  ///
  /// In en, this message translates to:
  /// **'Cards & List Items'**
  String get sectionCards;

  /// No description provided for @totalBalance.
  ///
  /// In en, this message translates to:
  /// **'Total Balance'**
  String get totalBalance;

  /// Title for the profile screen
  ///
  /// In en, this message translates to:
  /// **'Profile Settings'**
  String get profileSettings;

  /// No description provided for @updateYourInfo.
  ///
  /// In en, this message translates to:
  /// **'Update your personal info'**
  String get updateYourInfo;

  /// No description provided for @myVehicles.
  ///
  /// In en, this message translates to:
  /// **'My Vehicles'**
  String get myVehicles;

  /// No description provided for @deleteAccount.
  ///
  /// In en, this message translates to:
  /// **'Delete Account'**
  String get deleteAccount;

  /// No description provided for @sectionInputFields.
  ///
  /// In en, this message translates to:
  /// **'Input Fields'**
  String get sectionInputFields;

  /// No description provided for @invalidInput.
  ///
  /// In en, this message translates to:
  /// **'Invalid Input'**
  String get invalidInput;

  /// No description provided for @invalidEmailError.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid email'**
  String get invalidEmailError;

  /// No description provided for @sectionDisplay.
  ///
  /// In en, this message translates to:
  /// **'Display & Layout'**
  String get sectionDisplay;

  /// No description provided for @overview.
  ///
  /// In en, this message translates to:
  /// **'Overview'**
  String get overview;

  /// No description provided for @details.
  ///
  /// In en, this message translates to:
  /// **'Details'**
  String get details;

  /// No description provided for @history.
  ///
  /// In en, this message translates to:
  /// **'History'**
  String get history;

  /// No description provided for @emptyStateMessage.
  ///
  /// In en, this message translates to:
  /// **'No data to display for this section.'**
  String get emptyStateMessage;

  /// No description provided for @sectionOverlays.
  ///
  /// In en, this message translates to:
  /// **'Overlays'**
  String get sectionOverlays;

  /// No description provided for @showDialog.
  ///
  /// In en, this message translates to:
  /// **'Show Dialog'**
  String get showDialog;

  /// No description provided for @showSnackbar.
  ///
  /// In en, this message translates to:
  /// **'Show Snackbar'**
  String get showSnackbar;

  /// No description provided for @showError.
  ///
  /// In en, this message translates to:
  /// **'Show Error'**
  String get showError;

  /// No description provided for @showBottomSheet.
  ///
  /// In en, this message translates to:
  /// **'Show BottomSheet'**
  String get showBottomSheet;

  /// No description provided for @dialogTitle.
  ///
  /// In en, this message translates to:
  /// **'Confirmation'**
  String get dialogTitle;

  /// No description provided for @dialogMessage.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to proceed?'**
  String get dialogMessage;

  /// No description provided for @snackbarSuccess.
  ///
  /// In en, this message translates to:
  /// **'Profile updated successfully'**
  String get snackbarSuccess;

  /// No description provided for @snackbarError.
  ///
  /// In en, this message translates to:
  /// **'Failed to connect to the server.'**
  String get snackbarError;

  /// No description provided for @bottomSheetTitle.
  ///
  /// In en, this message translates to:
  /// **'Filter Options'**
  String get bottomSheetTitle;

  /// No description provided for @bottomSheetContent.
  ///
  /// In en, this message translates to:
  /// **'Here you can place your filter widgets like sliders, checkboxes, etc.'**
  String get bottomSheetContent;

  /// No description provided for @sideMenuDashboard.
  ///
  /// In en, this message translates to:
  /// **'Dashboard'**
  String get sideMenuDashboard;

  /// No description provided for @sideMenuStations.
  ///
  /// In en, this message translates to:
  /// **'Stations'**
  String get sideMenuStations;

  /// No description provided for @sideMenuUsers.
  ///
  /// In en, this message translates to:
  /// **'Users'**
  String get sideMenuUsers;

  /// No description provided for @sideMenuLogout.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get sideMenuLogout;

  /// No description provided for @loginTitle.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get loginTitle;

  /// User's phone number field label
  ///
  /// In en, this message translates to:
  /// **'Phone Number'**
  String get phoneNumber;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @forgotPassword.
  ///
  /// In en, this message translates to:
  /// **'Forgot Password'**
  String get forgotPassword;

  /// No description provided for @notAMember.
  ///
  /// In en, this message translates to:
  /// **'Not a member?'**
  String get notAMember;

  /// No description provided for @signUp.
  ///
  /// In en, this message translates to:
  /// **'Sign up'**
  String get signUp;

  /// No description provided for @loginButton.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get loginButton;

  /// No description provided for @otpVerificationTitle.
  ///
  /// In en, this message translates to:
  /// **'OTP Verification'**
  String get otpVerificationTitle;

  /// No description provided for @otpSentTo.
  ///
  /// In en, this message translates to:
  /// **'Code sent to {phoneNumber}'**
  String otpSentTo(Object phoneNumber);

  /// No description provided for @verificationCode.
  ///
  /// In en, this message translates to:
  /// **'Verification Code'**
  String get verificationCode;

  /// No description provided for @enterVerificationCode.
  ///
  /// In en, this message translates to:
  /// **'Enter the code'**
  String get enterVerificationCode;

  /// No description provided for @codeExpiresIn.
  ///
  /// In en, this message translates to:
  /// **'Code expires in {time}'**
  String codeExpiresIn(Object time);

  /// No description provided for @codeExpired.
  ///
  /// In en, this message translates to:
  /// **'Code has expired'**
  String get codeExpired;

  /// No description provided for @verify.
  ///
  /// In en, this message translates to:
  /// **'Verify'**
  String get verify;

  /// No description provided for @resendCode.
  ///
  /// In en, this message translates to:
  /// **'Resend Code'**
  String get resendCode;

  /// No description provided for @invalidOtpError.
  ///
  /// In en, this message translates to:
  /// **'Please enter a 4-digit code'**
  String get invalidOtpError;

  /// No description provided for @otpSuccessMessage.
  ///
  /// In en, this message translates to:
  /// **'Verified successfully'**
  String get otpSuccessMessage;

  /// No description provided for @otpErrorMessage.
  ///
  /// In en, this message translates to:
  /// **'Incorrect or expired code'**
  String get otpErrorMessage;

  /// No description provided for @sendOtpTitle.
  ///
  /// In en, this message translates to:
  /// **'Send Verification Code'**
  String get sendOtpTitle;

  /// No description provided for @enterPhoneForOtp.
  ///
  /// In en, this message translates to:
  /// **'Enter your phone number to send a verification code'**
  String get enterPhoneForOtp;

  /// No description provided for @phoneHint.
  ///
  /// In en, this message translates to:
  /// **'Phone Number'**
  String get phoneHint;

  /// No description provided for @invalidPhoneError.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid phone number'**
  String get invalidPhoneError;

  /// No description provided for @otpSentSuccess.
  ///
  /// In en, this message translates to:
  /// **'Verification code sent successfully'**
  String get otpSentSuccess;

  /// No description provided for @otpSendError.
  ///
  /// In en, this message translates to:
  /// **'Error: {message}'**
  String otpSendError(Object message);

  /// No description provided for @otpSendFailGeneric.
  ///
  /// In en, this message translates to:
  /// **'Failed to send code'**
  String get otpSendFailGeneric;

  /// No description provided for @pleaseWait.
  ///
  /// In en, this message translates to:
  /// **'Please wait {seconds} seconds'**
  String pleaseWait(Object seconds);

  /// No description provided for @sendCode.
  ///
  /// In en, this message translates to:
  /// **'Send Code'**
  String get sendCode;

  /// No description provided for @wait.
  ///
  /// In en, this message translates to:
  /// **'Wait...'**
  String get wait;

  /// No description provided for @failedToLoadCountries.
  ///
  /// In en, this message translates to:
  /// **'Failed to load country list'**
  String get failedToLoadCountries;

  /// No description provided for @connectionErrorMessage.
  ///
  /// In en, this message translates to:
  /// **'A connection error occurred'**
  String get connectionErrorMessage;

  /// No description provided for @pleaseWaitSeconds.
  ///
  /// In en, this message translates to:
  /// **'Please wait {seconds} seconds'**
  String pleaseWaitSeconds(Object seconds);

  /// No description provided for @sendOtpInstruction.
  ///
  /// In en, this message translates to:
  /// **'Enter your phone number to send a verification code'**
  String get sendOtpInstruction;

  /// No description provided for @invalidPhoneInput.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid phone number'**
  String get invalidPhoneInput;

  /// No description provided for @otpResentMessage.
  ///
  /// In en, this message translates to:
  /// **'Verification code has been resent'**
  String get otpResentMessage;

  /// Generic validation for required fields
  ///
  /// In en, this message translates to:
  /// **'This field is required'**
  String get requiredField;

  /// No description provided for @createAccount.
  ///
  /// In en, this message translates to:
  /// **'Create account'**
  String get createAccount;

  /// User's full name field label
  ///
  /// In en, this message translates to:
  /// **'Full Name'**
  String get fullName;

  /// User's email field label
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// No description provided for @confirmPassword.
  ///
  /// In en, this message translates to:
  /// **'Confirm Password'**
  String get confirmPassword;

  /// No description provided for @ok.
  ///
  /// In en, this message translates to:
  /// **'OK'**
  String get ok;

  /// No description provided for @invalidEmail.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid email address'**
  String get invalidEmail;

  /// No description provided for @passwordComplexError.
  ///
  /// In en, this message translates to:
  /// **'Password must be at least 8 characters, include uppercase letter and a symbol'**
  String get passwordComplexError;

  /// No description provided for @passwordMismatch.
  ///
  /// In en, this message translates to:
  /// **'Passwords do not match'**
  String get passwordMismatch;

  /// No description provided for @invalidPhone.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid Jordanian phone number starting with +9627'**
  String get invalidPhone;

  /// No description provided for @invalidPassword.
  ///
  /// In en, this message translates to:
  /// **'Password must be at least 8 characters'**
  String get invalidPassword;

  /// No description provided for @welcomeBack.
  ///
  /// In en, this message translates to:
  /// **'Welcome Back'**
  String get welcomeBack;

  /// No description provided for @pleaseSignIn.
  ///
  /// In en, this message translates to:
  /// **'Please sign in to continue'**
  String get pleaseSignIn;

  /// No description provided for @username.
  ///
  /// In en, this message translates to:
  /// **'Username'**
  String get username;

  /// No description provided for @signIn.
  ///
  /// In en, this message translates to:
  /// **'Sign In'**
  String get signIn;

  /// No description provided for @addStation.
  ///
  /// In en, this message translates to:
  /// **'Add Station'**
  String get addStation;

  /// No description provided for @notMember.
  ///
  /// In en, this message translates to:
  /// **'Not a member? '**
  String get notMember;

  /// No description provided for @countryCode.
  ///
  /// In en, this message translates to:
  /// **'Country Code'**
  String get countryCode;

  /// Logout button label
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logout;

  /// No description provided for @logoutFailed.
  ///
  /// In en, this message translates to:
  /// **'Logout failed'**
  String get logoutFailed;

  /// Generic error message
  ///
  /// In en, this message translates to:
  /// **'Unexpected error. Please try again later.'**
  String get unexpectedError;

  /// No description provided for @otpCode.
  ///
  /// In en, this message translates to:
  /// **'Verification Code'**
  String get otpCode;

  /// No description provided for @resetPassword.
  ///
  /// In en, this message translates to:
  /// **'Reset Password'**
  String get resetPassword;

  /// No description provided for @sendOtp.
  ///
  /// In en, this message translates to:
  /// **'Send Code'**
  String get sendOtp;

  /// No description provided for @passwordsDoNotMatch.
  ///
  /// In en, this message translates to:
  /// **'Passwords do not match'**
  String get passwordsDoNotMatch;

  /// No description provided for @unknownError.
  ///
  /// In en, this message translates to:
  /// **'An unknown error occurred. Please try again.'**
  String get unknownError;

  /// No description provided for @passwordLengthError.
  ///
  /// In en, this message translates to:
  /// **'Password must be at least 8 characters'**
  String get passwordLengthError;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @resetPasswordTitle.
  ///
  /// In en, this message translates to:
  /// **'Reset Password'**
  String get resetPasswordTitle;

  /// No description provided for @newPassword.
  ///
  /// In en, this message translates to:
  /// **'New Password'**
  String get newPassword;

  /// No description provided for @confirmNewPassword.
  ///
  /// In en, this message translates to:
  /// **'Confirm New Password'**
  String get confirmNewPassword;

  /// No description provided for @passwordResetSuccess.
  ///
  /// In en, this message translates to:
  /// **'Password has been reset successfully'**
  String get passwordResetSuccess;

  /// No description provided for @passwordsNotMatch.
  ///
  /// In en, this message translates to:
  /// **'Passwords do not match'**
  String get passwordsNotMatch;

  /// No description provided for @otpExpiredOrInvalid.
  ///
  /// In en, this message translates to:
  /// **'The OTP has expired.'**
  String get otpExpiredOrInvalid;

  /// No description provided for @stations.
  ///
  /// In en, this message translates to:
  /// **'Stations'**
  String get stations;

  /// No description provided for @map.
  ///
  /// In en, this message translates to:
  /// **'Map'**
  String get map;

  /// No description provided for @list.
  ///
  /// In en, this message translates to:
  /// **'List'**
  String get list;

  /// No description provided for @loginRequired.
  ///
  /// In en, this message translates to:
  /// **'Login Required'**
  String get loginRequired;

  /// No description provided for @loginRequiredMessage.
  ///
  /// In en, this message translates to:
  /// **'You need to log in to access this feature.'**
  String get loginRequiredMessage;

  /// No description provided for @login.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get login;

  /// No description provided for @close.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get close;

  /// No description provided for @searchLocation.
  ///
  /// In en, this message translates to:
  /// **'Search location'**
  String get searchLocation;

  /// No description provided for @chargerType.
  ///
  /// In en, this message translates to:
  /// **'Charger Type'**
  String get chargerType;

  /// No description provided for @city.
  ///
  /// In en, this message translates to:
  /// **'City'**
  String get city;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @invalidPhoneNumber.
  ///
  /// In en, this message translates to:
  /// **'Invalid phone number format'**
  String get invalidPhoneNumber;

  /// No description provided for @country.
  ///
  /// In en, this message translates to:
  /// **'Country'**
  String get country;

  /// No description provided for @searchCountries.
  ///
  /// In en, this message translates to:
  /// **'Search countries...'**
  String get searchCountries;

  /// No description provided for @noResultsFound.
  ///
  /// In en, this message translates to:
  /// **'No results found'**
  String get noResultsFound;

  /// No description provided for @invalidCountryCode.
  ///
  /// In en, this message translates to:
  /// **'Invalid country code. Please select a valid country.'**
  String get invalidCountryCode;

  /// No description provided for @passwordTooShort.
  ///
  /// In en, this message translates to:
  /// **'Password must be at least 8 characters'**
  String get passwordTooShort;

  /// No description provided for @passwordComplexity.
  ///
  /// In en, this message translates to:
  /// **'Password must contain letters and numbers'**
  String get passwordComplexity;

  /// No description provided for @loginFailed.
  ///
  /// In en, this message translates to:
  /// **'Login failed. Please check your credentials.'**
  String get loginFailed;

  /// Shown when the phone number or password is incorrect
  ///
  /// In en, this message translates to:
  /// **'Incorrect phone number or password'**
  String get loginUnexpectedError;

  /// No description provided for @withEtron.
  ///
  /// In en, this message translates to:
  /// **'With ETRON'**
  String get withEtron;

  /// Shown when the phone number or password is incorrect
  ///
  /// In en, this message translates to:
  /// **'Incorrect phone number or password'**
  String get invalidCredentials;

  /// Shown when phone number has no account
  ///
  /// In en, this message translates to:
  /// **'Phone number is not registered'**
  String get phoneNotRegistered;

  /// No description provided for @phoneAlreadyExists.
  ///
  /// In en, this message translates to:
  /// **'This phone number is already registered.'**
  String get phoneAlreadyExists;

  /// No description provided for @accountCreatedSuccess.
  ///
  /// In en, this message translates to:
  /// **'Account created successfully!'**
  String get accountCreatedSuccess;

  /// No description provided for @loginSuccess.
  ///
  /// In en, this message translates to:
  /// **'Login successful!'**
  String get loginSuccess;

  /// No description provided for @signupSuccess.
  ///
  /// In en, this message translates to:
  /// **'Account created successfully!'**
  String get signupSuccess;

  /// No description provided for @exploreStationsNearYou.
  ///
  /// In en, this message translates to:
  /// **'Explore stations\nnear you'**
  String get exploreStationsNearYou;

  /// No description provided for @availableNowCompatible.
  ///
  /// In en, this message translates to:
  /// **'Available now and compatible with your EV'**
  String get availableNowCompatible;

  /// No description provided for @register.
  ///
  /// In en, this message translates to:
  /// **'Register'**
  String get register;

  /// No description provided for @continueAsVisitor.
  ///
  /// In en, this message translates to:
  /// **'Continue as visitor'**
  String get continueAsVisitor;

  /// No description provided for @loginHere.
  ///
  /// In en, this message translates to:
  /// **'Login here'**
  String get loginHere;

  /// No description provided for @welcomeBackBig.
  ///
  /// In en, this message translates to:
  /// **'Welcome back you’ve'**
  String get welcomeBackBig;

  /// No description provided for @createNewAccount.
  ///
  /// In en, this message translates to:
  /// **'Create new account'**
  String get createNewAccount;

  /// No description provided for @signupSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Create an account so you can explore all the existing jobs'**
  String get signupSubtitle;

  /// No description provided for @alreadyHaveAccount.
  ///
  /// In en, this message translates to:
  /// **'Already have an account?'**
  String get alreadyHaveAccount;

  /// No description provided for @verifyPhoneNumber.
  ///
  /// In en, this message translates to:
  /// **'Verify Phone Number'**
  String get verifyPhoneNumber;

  /// No description provided for @enterRegisteredPhoneForReset.
  ///
  /// In en, this message translates to:
  /// **'Enter your registered phone number to reset your password'**
  String get enterRegisteredPhoneForReset;

  /// No description provided for @phoneNumberNotRegistered.
  ///
  /// In en, this message translates to:
  /// **'Phone number is not registered'**
  String get phoneNumberNotRegistered;

  /// No description provided for @phoneRequired.
  ///
  /// In en, this message translates to:
  /// **'Phone Number Required'**
  String get phoneRequired;

  /// Shown when the account is temporarily locked
  ///
  /// In en, this message translates to:
  /// **'Your account has been temporarily locked, please try again later'**
  String get accountLocked;

  /// Shown after the user exceeds the maximum login attempts; {minutes} is the remaining wait time
  ///
  /// In en, this message translates to:
  /// **'You have exceeded the allowed login attempts. Try again in {minutes} minutes'**
  String tooManyAttempts(Object minutes);

  /// Shown when the user must reset an expired password
  ///
  /// In en, this message translates to:
  /// **'Your password has expired, please reset it'**
  String get passwordExpired;

  /// Shown when the backend is unreachable
  ///
  /// In en, this message translates to:
  /// **'The server is currently unavailable, please try again'**
  String get serverUnavailable;

  /// No description provided for @main.
  ///
  /// In en, this message translates to:
  /// **'Main'**
  String get main;

  /// No description provided for @searchHint.
  ///
  /// In en, this message translates to:
  /// **'Where do you want to charge?'**
  String get searchHint;

  /// No description provided for @filter.
  ///
  /// In en, this message translates to:
  /// **'Filter'**
  String get filter;

  /// No description provided for @tesla.
  ///
  /// In en, this message translates to:
  /// **'Tesla'**
  String get tesla;

  /// No description provided for @type2.
  ///
  /// In en, this message translates to:
  /// **'Type 2'**
  String get type2;

  /// No description provided for @chademo.
  ///
  /// In en, this message translates to:
  /// **'CHAdeMO'**
  String get chademo;

  /// No description provided for @listPlaceholder.
  ///
  /// In en, this message translates to:
  /// **'List View Placeholder'**
  String get listPlaceholder;

  /// No description provided for @invalidCode.
  ///
  /// In en, this message translates to:
  /// **'Invalid verification code'**
  String get invalidCode;

  /// No description provided for @otpExpired.
  ///
  /// In en, this message translates to:
  /// **'The OTP code has expired. Please request a new one.'**
  String get otpExpired;

  /// No description provided for @incorrectOtp.
  ///
  /// In en, this message translates to:
  /// **'The OTP entered is incorrect.'**
  String get incorrectOtp;

  /// No description provided for @documents.
  ///
  /// In en, this message translates to:
  /// **'Documents'**
  String get documents;

  /// No description provided for @viewAndManageDocuments.
  ///
  /// In en, this message translates to:
  /// **'View and manage your documents'**
  String get viewAndManageDocuments;

  /// No description provided for @addDocument.
  ///
  /// In en, this message translates to:
  /// **'Add document'**
  String get addDocument;

  /// No description provided for @comingSoon.
  ///
  /// In en, this message translates to:
  /// **'Coming soon'**
  String get comingSoon;

  /// No description provided for @noDocumentsFound.
  ///
  /// In en, this message translates to:
  /// **'No documents found'**
  String get noDocumentsFound;

  /// No description provided for @addYourFirstDocument.
  ///
  /// In en, this message translates to:
  /// **'Add your first document to get started'**
  String get addYourFirstDocument;

  /// No description provided for @document.
  ///
  /// In en, this message translates to:
  /// **'Document'**
  String get document;

  /// No description provided for @expiry.
  ///
  /// In en, this message translates to:
  /// **'Expiry'**
  String get expiry;

  /// No description provided for @documentStatusValid.
  ///
  /// In en, this message translates to:
  /// **'Valid'**
  String get documentStatusValid;

  /// No description provided for @documentStatusExpiringSoon.
  ///
  /// In en, this message translates to:
  /// **'Expiring Soon'**
  String get documentStatusExpiringSoon;

  /// No description provided for @documentStatusExpired.
  ///
  /// In en, this message translates to:
  /// **'Expired'**
  String get documentStatusExpired;

  /// No description provided for @changeLanguage.
  ///
  /// In en, this message translates to:
  /// **'Change language'**
  String get changeLanguage;

  /// No description provided for @changeLanguageSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Switch between Arabic and English'**
  String get changeLanguageSubtitle;

  /// No description provided for @myDocuments.
  ///
  /// In en, this message translates to:
  /// **'My Documents'**
  String get myDocuments;

  /// Confirmation button text in dialogs and actions
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get confirm;

  /// No description provided for @account.
  ///
  /// In en, this message translates to:
  /// **'Account'**
  String get account;

  /// No description provided for @notifications.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get notifications;

  /// No description provided for @personalInformation.
  ///
  /// In en, this message translates to:
  /// **'Personal Information'**
  String get personalInformation;

  /// No description provided for @vehicles.
  ///
  /// In en, this message translates to:
  /// **'Vehicles'**
  String get vehicles;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @copyright.
  ///
  /// In en, this message translates to:
  /// **'© {brand} {year}'**
  String copyright(Object brand, Object year);

  /// No description provided for @switchLanguageToArabic.
  ///
  /// In en, this message translates to:
  /// **'Switch Language To Arabic'**
  String get switchLanguageToArabic;

  /// No description provided for @switchLanguageToEnglish.
  ///
  /// In en, this message translates to:
  /// **'Switch Language To English'**
  String get switchLanguageToEnglish;

  /// Top-right save action
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @yourAccount.
  ///
  /// In en, this message translates to:
  /// **'Your Account'**
  String get yourAccount;

  /// No description provided for @accountInformation.
  ///
  /// In en, this message translates to:
  /// **'Account Information'**
  String get accountInformation;

  /// No description provided for @changeQuestion.
  ///
  /// In en, this message translates to:
  /// **'Change?'**
  String get changeQuestion;

  /// No description provided for @nationalNumber.
  ///
  /// In en, this message translates to:
  /// **'National Number'**
  String get nationalNumber;

  /// No description provided for @deleteMyAccount.
  ///
  /// In en, this message translates to:
  /// **'Delete My Account'**
  String get deleteMyAccount;

  /// No description provided for @currentPasswordIncorrect.
  ///
  /// In en, this message translates to:
  /// **'Current password is incorrect'**
  String get currentPasswordIncorrect;

  /// No description provided for @userNotFound.
  ///
  /// In en, this message translates to:
  /// **'User not found'**
  String get userNotFound;

  /// No description provided for @currentPassword.
  ///
  /// In en, this message translates to:
  /// **'Current Password'**
  String get currentPassword;

  /// No description provided for @activeUserNotFound.
  ///
  /// In en, this message translates to:
  /// **'No active user found'**
  String get activeUserNotFound;

  /// No description provided for @phoneOrEmailRequired.
  ///
  /// In en, this message translates to:
  /// **'Phone or email is required'**
  String get phoneOrEmailRequired;

  /// No description provided for @changePasswordTitle.
  ///
  /// In en, this message translates to:
  /// **'Change Password'**
  String get changePasswordTitle;

  /// No description provided for @enterCurrentPasswordHint.
  ///
  /// In en, this message translates to:
  /// **'Enter your current password'**
  String get enterCurrentPasswordHint;

  /// No description provided for @enterNewPasswordHint.
  ///
  /// In en, this message translates to:
  /// **'Enter your new password'**
  String get enterNewPasswordHint;

  /// No description provided for @confirmNewPasswordHint.
  ///
  /// In en, this message translates to:
  /// **'Re-enter your new password to confirm'**
  String get confirmNewPasswordHint;

  /// No description provided for @addVehicleCta.
  ///
  /// In en, this message translates to:
  /// **'Add a vehicle'**
  String get addVehicleCta;

  /// No description provided for @vehiclesEmptyHelper.
  ///
  /// In en, this message translates to:
  /// **'Get the best charging results tailored just for you! Add your car details to see charging points that perfectly match your vehicle and enjoy top performance every time.'**
  String get vehiclesEmptyHelper;

  /// No description provided for @addYourCharger.
  ///
  /// In en, this message translates to:
  /// **'Add Your Charger'**
  String get addYourCharger;

  /// No description provided for @acChargerType.
  ///
  /// In en, this message translates to:
  /// **'AC Charger Type'**
  String get acChargerType;

  /// No description provided for @dcChargerType.
  ///
  /// In en, this message translates to:
  /// **'DC Charger Type'**
  String get dcChargerType;

  /// No description provided for @addVehicleLicense.
  ///
  /// In en, this message translates to:
  /// **'Add Vehicle License'**
  String get addVehicleLicense;

  /// No description provided for @plateCountry.
  ///
  /// In en, this message translates to:
  /// **'Plate Country'**
  String get plateCountry;

  /// No description provided for @plateNumber.
  ///
  /// In en, this message translates to:
  /// **'Plate Number'**
  String get plateNumber;

  /// No description provided for @fromDate.
  ///
  /// In en, this message translates to:
  /// **'From Date'**
  String get fromDate;

  /// Expiry date field label
  ///
  /// In en, this message translates to:
  /// **'Expiry Date'**
  String get expiryDate;

  /// No description provided for @carNameEn.
  ///
  /// In en, this message translates to:
  /// **'Vehicle Name (EN)'**
  String get carNameEn;

  /// No description provided for @carNameAr.
  ///
  /// In en, this message translates to:
  /// **'Vehicle Name (AR)'**
  String get carNameAr;

  /// No description provided for @manufacturingCountry.
  ///
  /// In en, this message translates to:
  /// **'Manufacturing Country'**
  String get manufacturingCountry;

  /// No description provided for @carYearHint.
  ///
  /// In en, this message translates to:
  /// **'Year'**
  String get carYearHint;

  /// No description provided for @carColorHint.
  ///
  /// In en, this message translates to:
  /// **'Color'**
  String get carColorHint;

  /// No description provided for @carAddedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Car added successfully'**
  String get carAddedSuccessfully;

  /// No description provided for @searchChargerType.
  ///
  /// In en, this message translates to:
  /// **'Search for charger type...'**
  String get searchChargerType;

  /// No description provided for @exampleCarNameEn.
  ///
  /// In en, this message translates to:
  /// **'e.g., My Tesla Model 3'**
  String get exampleCarNameEn;

  /// No description provided for @exampleCarNameAr.
  ///
  /// In en, this message translates to:
  /// **'e.g., تسلا موديل 3'**
  String get exampleCarNameAr;

  /// No description provided for @exampleManufacturingCountry.
  ///
  /// In en, this message translates to:
  /// **'e.g., Germany'**
  String get exampleManufacturingCountry;

  /// No description provided for @examplePlateCountry.
  ///
  /// In en, this message translates to:
  /// **'e.g., Jordan'**
  String get examplePlateCountry;

  /// No description provided for @exampleCarYear.
  ///
  /// In en, this message translates to:
  /// **'e.g., 2022'**
  String get exampleCarYear;

  /// No description provided for @exampleCarColor.
  ///
  /// In en, this message translates to:
  /// **'e.g., Black'**
  String get exampleCarColor;

  /// No description provided for @examplePlateNumber.
  ///
  /// In en, this message translates to:
  /// **'e.g., 20-12345'**
  String get examplePlateNumber;

  /// No description provided for @exampleFromDate.
  ///
  /// In en, this message translates to:
  /// **'e.g., 01/01/2024'**
  String get exampleFromDate;

  /// No description provided for @exampleExpiryDate.
  ///
  /// In en, this message translates to:
  /// **'e.g., 12/31/2026'**
  String get exampleExpiryDate;

  /// No description provided for @exampleAcType.
  ///
  /// In en, this message translates to:
  /// **'e.g., Type 2 (Mennekes)'**
  String get exampleAcType;

  /// No description provided for @exampleDcType.
  ///
  /// In en, this message translates to:
  /// **'e.g., CCS Type 2'**
  String get exampleDcType;

  /// No description provided for @carModel.
  ///
  /// In en, this message translates to:
  /// **'Car Model'**
  String get carModel;

  /// No description provided for @carProfile.
  ///
  /// In en, this message translates to:
  /// **'Vehicle Profile'**
  String get carProfile;

  /// No description provided for @documentDetails.
  ///
  /// In en, this message translates to:
  /// **'Document Details'**
  String get documentDetails;

  /// Document type field label
  ///
  /// In en, this message translates to:
  /// **'Type'**
  String get documentType;

  /// Owner name field label
  ///
  /// In en, this message translates to:
  /// **'Owner Name'**
  String get ownerName;

  /// No description provided for @uploadAttachment.
  ///
  /// In en, this message translates to:
  /// **'Upload attachment'**
  String get uploadAttachment;

  /// No description provided for @attachFile.
  ///
  /// In en, this message translates to:
  /// **'Please attach a file'**
  String get attachFile;

  /// No description provided for @savedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Saved successfully'**
  String get savedSuccessfully;

  /// No description provided for @noDocumentsYet.
  ///
  /// In en, this message translates to:
  /// **'No documents yet'**
  String get noDocumentsYet;

  /// No description provided for @pickDocumentType.
  ///
  /// In en, this message translates to:
  /// **'Select document type'**
  String get pickDocumentType;

  /// No description provided for @defaultVehicleLicense.
  ///
  /// In en, this message translates to:
  /// **'Vehicle License'**
  String get defaultVehicleLicense;

  /// Screen title: add a new document
  ///
  /// In en, this message translates to:
  /// **'Add Document'**
  String get addDocumentCta;

  /// Owner name placeholder/hint
  ///
  /// In en, this message translates to:
  /// **'e.g. Ahmed Ali'**
  String get ownerNameHint;

  /// Expiry date field hint
  ///
  /// In en, this message translates to:
  /// **'Select expiry date'**
  String get selectExpiryDate;

  /// Attachment section title
  ///
  /// In en, this message translates to:
  /// **'Attachment'**
  String get attachment;

  /// Button text to choose a file
  ///
  /// In en, this message translates to:
  /// **'Choose file'**
  String get chooseFile;

  /// Shown in file input when empty
  ///
  /// In en, this message translates to:
  /// **'No file chosen'**
  String get noFileChosen;

  /// Toast/error when user cancels picking a file
  ///
  /// In en, this message translates to:
  /// **'No file selected'**
  String get noFileSelected;

  /// Helper text under attachment input
  ///
  /// In en, this message translates to:
  /// **'PDF, JPG, PNG • Max 10MB'**
  String get allowedFileTypes;

  /// Success toast when document is created
  ///
  /// In en, this message translates to:
  /// **'Document added successfully'**
  String get documentAddedSuccessfully;

  /// Header tag above vehicle name
  ///
  /// In en, this message translates to:
  /// **'Vehicle Profile'**
  String get vehicleProfile;

  /// No description provided for @selectDocumentType.
  ///
  /// In en, this message translates to:
  /// **'Choose a document type'**
  String get selectDocumentType;

  /// No description provided for @expiryDateHint.
  ///
  /// In en, this message translates to:
  /// **'YYYY-MM-DD'**
  String get expiryDateHint;

  /// No description provided for @pickFile.
  ///
  /// In en, this message translates to:
  /// **'Pick file'**
  String get pickFile;

  /// No description provided for @failedToUploadDocument.
  ///
  /// In en, this message translates to:
  /// **'Failed to upload document'**
  String get failedToUploadDocument;

  /// No description provided for @vehicleLicense.
  ///
  /// In en, this message translates to:
  /// **'Vehicle License'**
  String get vehicleLicense;

  /// No description provided for @version.
  ///
  /// In en, this message translates to:
  /// **'Version'**
  String get version;

  /// No description provided for @loading.
  ///
  /// In en, this message translates to:
  /// **'Loading'**
  String get loading;

  /// No description provided for @emailAlreadyExists.
  ///
  /// In en, this message translates to:
  /// **'This email is already registered.'**
  String get emailAlreadyExists;

  /// No description provided for @fillRequiredFields.
  ///
  /// In en, this message translates to:
  /// **'Please fill in all required fields.'**
  String get fillRequiredFields;

  /// No description provided for @atLeastOneCharger.
  ///
  /// In en, this message translates to:
  /// **'Please select at least one charger type.'**
  String get atLeastOneCharger;

  /// No description provided for @documentNumber.
  ///
  /// In en, this message translates to:
  /// **'Document Number'**
  String get documentNumber;

  /// No description provided for @documentNumberHint.
  ///
  /// In en, this message translates to:
  /// **'e.g., The number on the document'**
  String get documentNumberHint;

  /// No description provided for @addYourVehicleNow.
  ///
  /// In en, this message translates to:
  /// **'Add Your Vehicle Now!'**
  String get addYourVehicleNow;

  /// No description provided for @addVehicleToAccessFeatures.
  ///
  /// In en, this message translates to:
  /// **'To access charging services and manage documents.'**
  String get addVehicleToAccessFeatures;

  /// No description provided for @retry.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get retry;

  /// No description provided for @etronNumber.
  ///
  /// In en, this message translates to:
  /// **'Etron Number'**
  String get etronNumber;

  /// No description provided for @carDetails.
  ///
  /// In en, this message translates to:
  /// **'Car Details'**
  String get carDetails;

  /// No description provided for @deleteAccountConfirmationMessage.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to permanently delete your account? This action cannot be undone.'**
  String get deleteAccountConfirmationMessage;

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @accountDeletedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Your account has been deleted successfully'**
  String get accountDeletedSuccessfully;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar': return AppLocalizationsAr();
    case 'en': return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
