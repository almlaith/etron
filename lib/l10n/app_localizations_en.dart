// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Etron';

  @override
  String get welcomeMessage => 'Welcome to Etron Station Finder';

  @override
  String welcomeUser(Object userName) {
    return 'Welcome, $userName';
  }

  @override
  String get findStation => 'Find a Station';

  @override
  String get station => 'Station';

  @override
  String get status => 'Status';

  @override
  String get componentsPreviewTitle => 'Etron Components';

  @override
  String get sectionButtons => 'Buttons';

  @override
  String get primaryButton => 'Primary Button';

  @override
  String get buttonWithIcon => 'Button with Icon';

  @override
  String get loadingButton => 'Loading...';

  @override
  String get warningButton => 'Warning Button';

  @override
  String get sectionCards => 'Cards & List Items';

  @override
  String get totalBalance => 'Total Balance';

  @override
  String get profileSettings => 'Profile Settings';

  @override
  String get updateYourInfo => 'Update your personal info';

  @override
  String get myVehicles => 'My Vehicles';

  @override
  String get deleteAccount => 'Delete Account';

  @override
  String get sectionInputFields => 'Input Fields';

  @override
  String get invalidInput => 'Invalid Input';

  @override
  String get invalidEmailError => 'Please enter a valid email';

  @override
  String get sectionDisplay => 'Display & Layout';

  @override
  String get overview => 'Overview';

  @override
  String get details => 'Details';

  @override
  String get history => 'History';

  @override
  String get emptyStateMessage => 'No data to display for this section.';

  @override
  String get sectionOverlays => 'Overlays';

  @override
  String get showDialog => 'Show Dialog';

  @override
  String get showSnackbar => 'Show Snackbar';

  @override
  String get showError => 'Show Error';

  @override
  String get showBottomSheet => 'Show BottomSheet';

  @override
  String get dialogTitle => 'Confirmation';

  @override
  String get dialogMessage => 'Are you sure you want to proceed?';

  @override
  String get snackbarSuccess => 'Profile updated successfully';

  @override
  String get snackbarError => 'Failed to connect to the server.';

  @override
  String get bottomSheetTitle => 'Filter Options';

  @override
  String get bottomSheetContent => 'Here you can place your filter widgets like sliders, checkboxes, etc.';

  @override
  String get sideMenuDashboard => 'Dashboard';

  @override
  String get sideMenuStations => 'Stations';

  @override
  String get sideMenuUsers => 'Users';

  @override
  String get sideMenuLogout => 'Logout';

  @override
  String get loginTitle => 'Login';

  @override
  String get phoneNumber => 'Phone Number';

  @override
  String get password => 'Password';

  @override
  String get forgotPassword => 'Forgot Password';

  @override
  String get notAMember => 'Not a member?';

  @override
  String get signUp => 'Sign up';

  @override
  String get loginButton => 'Login';

  @override
  String get otpVerificationTitle => 'OTP Verification';

  @override
  String otpSentTo(Object phoneNumber) {
    return 'Code sent to $phoneNumber';
  }

  @override
  String get verificationCode => 'Verification Code';

  @override
  String get enterVerificationCode => 'Enter the code';

  @override
  String codeExpiresIn(Object time) {
    return 'Code expires in $time';
  }

  @override
  String get codeExpired => 'Code has expired';

  @override
  String get verify => 'Verify';

  @override
  String get resendCode => 'Resend Code';

  @override
  String get invalidOtpError => 'Please enter a 4-digit code';

  @override
  String get otpSuccessMessage => 'Verified successfully';

  @override
  String get otpErrorMessage => 'Incorrect or expired code';

  @override
  String get sendOtpTitle => 'Send Verification Code';

  @override
  String get enterPhoneForOtp => 'Enter your phone number to send a verification code';

  @override
  String get phoneHint => 'Phone Number';

  @override
  String get invalidPhoneError => 'Please enter a valid phone number';

  @override
  String get otpSentSuccess => 'Verification code sent successfully';

  @override
  String otpSendError(Object message) {
    return 'Error: $message';
  }

  @override
  String get otpSendFailGeneric => 'Failed to send code';

  @override
  String pleaseWait(Object seconds) {
    return 'Please wait $seconds seconds';
  }

  @override
  String get sendCode => 'Send Code';

  @override
  String get wait => 'Wait...';

  @override
  String get failedToLoadCountries => 'Failed to load country list';

  @override
  String get connectionErrorMessage => 'A connection error occurred';

  @override
  String pleaseWaitSeconds(Object seconds) {
    return 'Please wait $seconds seconds';
  }

  @override
  String get sendOtpInstruction => 'Enter your phone number to send a verification code';

  @override
  String get invalidPhoneInput => 'Please enter a valid phone number';

  @override
  String get otpResentMessage => 'Verification code has been resent';

  @override
  String get requiredField => 'This field is required';

  @override
  String get createAccount => 'Create account';

  @override
  String get fullName => 'Full Name';

  @override
  String get email => 'Email';

  @override
  String get confirmPassword => 'Confirm Password';

  @override
  String get ok => 'OK';

  @override
  String get invalidEmail => 'Please enter a valid email address';

  @override
  String get passwordComplexError => 'Password must be at least 8 characters, include uppercase letter and a symbol';

  @override
  String get passwordMismatch => 'Passwords do not match';

  @override
  String get invalidPhone => 'Please enter a valid Jordanian phone number starting with +9627';

  @override
  String get invalidPassword => 'Password must be at least 8 characters';

  @override
  String get welcomeBack => 'Welcome Back';

  @override
  String get pleaseSignIn => 'Please sign in to continue';

  @override
  String get username => 'Username';

  @override
  String get signIn => 'Sign In';

  @override
  String get addStation => 'Add Station';

  @override
  String get notMember => 'Not a member? ';

  @override
  String get countryCode => 'Country Code';

  @override
  String get logout => 'Logout';

  @override
  String get logoutFailed => 'Logout failed';

  @override
  String get unexpectedError => 'Unexpected error. Please try again later.';

  @override
  String get otpCode => 'Verification Code';

  @override
  String get resetPassword => 'Reset Password';

  @override
  String get sendOtp => 'Send Code';

  @override
  String get passwordsDoNotMatch => 'Passwords do not match';

  @override
  String get unknownError => 'An unknown error occurred. Please try again.';

  @override
  String get passwordLengthError => 'Password must be at least 8 characters';

  @override
  String get language => 'Language';

  @override
  String get resetPasswordTitle => 'Reset Password';

  @override
  String get newPassword => 'New Password';

  @override
  String get confirmNewPassword => 'Confirm New Password';

  @override
  String get passwordResetSuccess => 'Password has been reset successfully';

  @override
  String get passwordsNotMatch => 'Passwords do not match';

  @override
  String get otpExpiredOrInvalid => 'The OTP has expired.';

  @override
  String get stations => 'Stations';

  @override
  String get map => 'Map';

  @override
  String get list => 'List';

  @override
  String get loginRequired => 'Login Required';

  @override
  String get loginRequiredMessage => 'You need to log in to access this feature.';

  @override
  String get login => 'Login';

  @override
  String get close => 'Close';

  @override
  String get searchLocation => 'Search location';

  @override
  String get chargerType => 'Charger Type';

  @override
  String get city => 'City';

  @override
  String get cancel => 'Cancel';

  @override
  String get invalidPhoneNumber => 'Invalid phone number format';

  @override
  String get country => 'Country';

  @override
  String get searchCountries => 'Search countries...';

  @override
  String get noResultsFound => 'No results found';

  @override
  String get invalidCountryCode => 'Invalid country code. Please select a valid country.';

  @override
  String get passwordTooShort => 'Password must be at least 8 characters';

  @override
  String get passwordComplexity => 'Password must contain letters and numbers';

  @override
  String get loginFailed => 'Login failed. Please check your credentials.';

  @override
  String get loginUnexpectedError => 'Incorrect phone number or password';

  @override
  String get withEtron => 'With ETRON';

  @override
  String get invalidCredentials => 'Incorrect phone number or password';

  @override
  String get phoneNotRegistered => 'Phone number is not registered';

  @override
  String get phoneAlreadyExists => 'This phone number is already registered.';

  @override
  String get accountCreatedSuccess => 'Account created successfully!';

  @override
  String get loginSuccess => 'Login successful!';

  @override
  String get signupSuccess => 'Account created successfully!';

  @override
  String get exploreStationsNearYou => 'Explore stations\nnear you';

  @override
  String get availableNowCompatible => 'Available now and compatible with your EV';

  @override
  String get register => 'Register';

  @override
  String get continueAsVisitor => 'Continue as visitor';

  @override
  String get loginHere => 'Login here';

  @override
  String get welcomeBackBig => 'Welcome back you’ve';

  @override
  String get createNewAccount => 'Create new account';

  @override
  String get signupSubtitle => 'Create an account so you can explore all the existing jobs';

  @override
  String get alreadyHaveAccount => 'Already have an account?';

  @override
  String get verifyPhoneNumber => 'Verify Phone Number';

  @override
  String get enterRegisteredPhoneForReset => 'Enter your registered phone number to reset your password';

  @override
  String get phoneNumberNotRegistered => 'Phone number is not registered';

  @override
  String get phoneRequired => 'Phone Number Required';

  @override
  String get accountLocked => 'Your account has been temporarily locked, please try again later';

  @override
  String tooManyAttempts(Object minutes) {
    return 'You have exceeded the allowed login attempts. Try again in $minutes minutes';
  }

  @override
  String get passwordExpired => 'Your password has expired, please reset it';

  @override
  String get serverUnavailable => 'The server is currently unavailable, please try again';

  @override
  String get main => 'Main';

  @override
  String get searchHint => 'Where do you want to charge?';

  @override
  String get filter => 'Filter';

  @override
  String get tesla => 'Tesla';

  @override
  String get type2 => 'Type 2';

  @override
  String get chademo => 'CHAdeMO';

  @override
  String get listPlaceholder => 'List View Placeholder';

  @override
  String get invalidCode => 'Invalid verification code';

  @override
  String get otpExpired => 'The OTP code has expired. Please request a new one.';

  @override
  String get incorrectOtp => 'The OTP entered is incorrect.';

  @override
  String get documents => 'Documents';

  @override
  String get viewAndManageDocuments => 'View and manage your documents';

  @override
  String get addDocument => 'Add document';

  @override
  String get comingSoon => 'Coming soon';

  @override
  String get noDocumentsFound => 'No documents found';

  @override
  String get addYourFirstDocument => 'Add your first document to get started';

  @override
  String get document => 'Document';

  @override
  String get expiry => 'Expiry';

  @override
  String get documentStatusValid => 'Valid';

  @override
  String get documentStatusExpiringSoon => 'Expiring Soon';

  @override
  String get documentStatusExpired => 'Expired';

  @override
  String get changeLanguage => 'Change language';

  @override
  String get changeLanguageSubtitle => 'Switch between Arabic and English';

  @override
  String get myDocuments => 'My Documents';

  @override
  String get confirm => 'Confirm';

  @override
  String get account => 'Account';

  @override
  String get notifications => 'Notifications';

  @override
  String get personalInformation => 'Personal Information';

  @override
  String get vehicles => 'Vehicles';

  @override
  String get settings => 'Settings';

  @override
  String copyright(Object brand, Object year) {
    return '© $brand $year';
  }

  @override
  String get switchLanguageToArabic => 'Switch Language To Arabic';

  @override
  String get switchLanguageToEnglish => 'Switch Language To English';

  @override
  String get save => 'Save';

  @override
  String get yourAccount => 'Your Account';

  @override
  String get accountInformation => 'Account Information';

  @override
  String get changeQuestion => 'Change?';

  @override
  String get nationalNumber => 'National Number';

  @override
  String get deleteMyAccount => 'Delete My Account';

  @override
  String get currentPasswordIncorrect => 'Current password is incorrect';

  @override
  String get userNotFound => 'User not found';

  @override
  String get currentPassword => 'Current Password';

  @override
  String get activeUserNotFound => 'No active user found';

  @override
  String get phoneOrEmailRequired => 'Phone or email is required';

  @override
  String get changePasswordTitle => 'Change Password';

  @override
  String get enterCurrentPasswordHint => 'Enter your current password';

  @override
  String get enterNewPasswordHint => 'Enter your new password';

  @override
  String get confirmNewPasswordHint => 'Re-enter your new password to confirm';

  @override
  String get addVehicleCta => 'Add a vehicle';

  @override
  String get vehiclesEmptyHelper => 'Get the best charging results tailored just for you! Add your car details to see charging points that perfectly match your vehicle and enjoy top performance every time.';

  @override
  String get addYourCharger => 'Add Your Charger';

  @override
  String get acChargerType => 'AC Charger Type';

  @override
  String get dcChargerType => 'DC Charger Type';

  @override
  String get addVehicleLicense => 'Add Vehicle License';

  @override
  String get plateCountry => 'Plate Country';

  @override
  String get plateNumber => 'Plate Number';

  @override
  String get fromDate => 'From Date';

  @override
  String get expiryDate => 'Expiry Date';

  @override
  String get carNameEn => 'Vehicle Name (EN)';

  @override
  String get carNameAr => 'Vehicle Name (AR)';

  @override
  String get manufacturingCountry => 'Manufacturing Country';

  @override
  String get carYearHint => 'Year';

  @override
  String get carColorHint => 'Color';

  @override
  String get carAddedSuccessfully => 'Car added successfully';

  @override
  String get searchChargerType => 'Search for charger type...';

  @override
  String get exampleCarNameEn => 'e.g., My Tesla Model 3';

  @override
  String get exampleCarNameAr => 'e.g., تسلا موديل 3';

  @override
  String get exampleManufacturingCountry => 'e.g., Germany';

  @override
  String get examplePlateCountry => 'e.g., Jordan';

  @override
  String get exampleCarYear => 'e.g., 2022';

  @override
  String get exampleCarColor => 'e.g., Black';

  @override
  String get examplePlateNumber => 'e.g., 20-12345';

  @override
  String get exampleFromDate => 'e.g., 01/01/2024';

  @override
  String get exampleExpiryDate => 'e.g., 12/31/2026';

  @override
  String get exampleAcType => 'e.g., Type 2 (Mennekes)';

  @override
  String get exampleDcType => 'e.g., CCS Type 2';

  @override
  String get carModel => 'Car Model';

  @override
  String get carProfile => 'Vehicle Profile';

  @override
  String get documentDetails => 'Document Details';

  @override
  String get documentType => 'Type';

  @override
  String get ownerName => 'Owner Name';

  @override
  String get uploadAttachment => 'Upload attachment';

  @override
  String get attachFile => 'Please attach a file';

  @override
  String get savedSuccessfully => 'Saved successfully';

  @override
  String get noDocumentsYet => 'No documents yet';

  @override
  String get pickDocumentType => 'Select document type';

  @override
  String get defaultVehicleLicense => 'Vehicle License';

  @override
  String get addDocumentCta => 'Add Document';

  @override
  String get ownerNameHint => 'e.g. Ahmed Ali';

  @override
  String get selectExpiryDate => 'Select expiry date';

  @override
  String get attachment => 'Attachment';

  @override
  String get chooseFile => 'Choose file';

  @override
  String get noFileChosen => 'No file chosen';

  @override
  String get noFileSelected => 'No file selected';

  @override
  String get allowedFileTypes => 'PDF, JPG, PNG • Max 10MB';

  @override
  String get documentAddedSuccessfully => 'Document added successfully';

  @override
  String get vehicleProfile => 'Vehicle Profile';

  @override
  String get selectDocumentType => 'Choose a document type';

  @override
  String get expiryDateHint => 'YYYY-MM-DD';

  @override
  String get pickFile => 'Pick file';

  @override
  String get failedToUploadDocument => 'Failed to upload document';

  @override
  String get vehicleLicense => 'Vehicle License';

  @override
  String get version => 'Version';

  @override
  String get loading => 'Loading';

  @override
  String get emailAlreadyExists => 'This email is already registered.';

  @override
  String get fillRequiredFields => 'Please fill in all required fields.';

  @override
  String get atLeastOneCharger => 'Please select at least one charger type.';

  @override
  String get documentNumber => 'Document Number';

  @override
  String get documentNumberHint => 'e.g., The number on the document';

  @override
  String get addYourVehicleNow => 'Add Your Vehicle Now!';

  @override
  String get addVehicleToAccessFeatures => 'To access charging services and manage documents.';

  @override
  String get retry => 'Retry';

  @override
  String get etronNumber => 'Etron Number';

  @override
  String get carDetails => 'Car Details';

  @override
  String get deleteAccountConfirmationMessage => 'Are you sure you want to permanently delete your account? This action cannot be undone.';

  @override
  String get delete => 'Delete';

  @override
  String get accountDeletedSuccessfully => 'Your account has been deleted successfully';
}
