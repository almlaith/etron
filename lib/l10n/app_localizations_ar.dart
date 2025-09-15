// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get appTitle => 'إيترون';

  @override
  String get welcomeMessage => 'أهلاً بك في إيترون للبحث عن المحطات';

  @override
  String welcomeUser(Object userName) {
    return 'أهلاً, $userName';
  }

  @override
  String get findStation => 'ابحث عن محطة';

  @override
  String get station => 'محطة';

  @override
  String get status => 'الحالة';

  @override
  String get componentsPreviewTitle => 'إيترون';

  @override
  String get sectionButtons => 'الأزرار';

  @override
  String get primaryButton => 'زر أساسي';

  @override
  String get buttonWithIcon => 'زر مع أيقونة';

  @override
  String get loadingButton => 'جاري التحميل...';

  @override
  String get warningButton => 'زر تحذير';

  @override
  String get sectionCards => 'البطاقات وعناصر القوائم';

  @override
  String get totalBalance => 'الرصيد الكلي';

  @override
  String get profileSettings => 'إعدادات الملف الشخصي';

  @override
  String get updateYourInfo => 'تحديث معلوماتك الشخصية';

  @override
  String get myVehicles => 'مركباتي';

  @override
  String get deleteAccount => 'حذف الحساب';

  @override
  String get sectionInputFields => 'حقول الإدخال';

  @override
  String get invalidInput => 'إدخال غير صالح';

  @override
  String get invalidEmailError => 'الرجاء إدخال بريد إلكتروني صالح';

  @override
  String get sectionDisplay => 'العرض والتخطيط';

  @override
  String get overview => 'نظرة عامة';

  @override
  String get details => 'التفاصيل';

  @override
  String get history => 'السجل';

  @override
  String get emptyStateMessage => 'لا توجد بيانات لعرضها في هذا القسم.';

  @override
  String get sectionOverlays => 'الطبقات العلوية';

  @override
  String get showDialog => 'عرض حوار';

  @override
  String get showSnackbar => 'عرض تنبيه';

  @override
  String get showError => 'عرض خطأ';

  @override
  String get showBottomSheet => 'عرض ورقة سفلية';

  @override
  String get dialogTitle => 'تأكيد';

  @override
  String get dialogMessage => 'هل أنت متأكد أنك تريد المتابعة؟';

  @override
  String get snackbarSuccess => 'تم تحديث الملف الشخصي بنجاح';

  @override
  String get snackbarError => 'فشل الاتصال بالخادم.';

  @override
  String get bottomSheetTitle => 'خيارات الفلترة';

  @override
  String get bottomSheetContent => 'هنا يمكنك وضع مكونات الفلترة مثل أشرطة التمرير ومربعات الاختيار.';

  @override
  String get sideMenuDashboard => 'لوحة المعلومات';

  @override
  String get sideMenuStations => 'المحطات';

  @override
  String get sideMenuUsers => 'المستخدمون';

  @override
  String get sideMenuLogout => 'تسجيل الخروج';

  @override
  String get loginTitle => 'تسجيل الدخول';

  @override
  String get phoneNumber => 'رقم الهاتف';

  @override
  String get password => 'كلمة المرور';

  @override
  String get forgotPassword => 'هل نسيت كلمة المرور؟';

  @override
  String get notAMember => 'لست عضواً؟';

  @override
  String get signUp => 'إنشاء حساب';

  @override
  String get loginButton => 'دخول';

  @override
  String get otpVerificationTitle => 'التحقق من الرمز';

  @override
  String otpSentTo(Object phoneNumber) {
    return 'تم إرسال الرمز إلى $phoneNumber';
  }

  @override
  String get verificationCode => 'رمز التحقق';

  @override
  String get enterVerificationCode => 'أدخل الرمز';

  @override
  String codeExpiresIn(Object time) {
    return 'ينتهي الرمز خلال $time';
  }

  @override
  String get codeExpired => 'انتهت صلاحية الرمز';

  @override
  String get verify => 'تحقق';

  @override
  String get resendCode => 'إعادة إرسال الرمز';

  @override
  String get invalidOtpError => 'يرجى إدخال رمز مكون من 4 أرقام';

  @override
  String get otpSuccessMessage => 'تم التحقق بنجاح';

  @override
  String get otpErrorMessage => ' رمز غير صحيح أو منتهي';

  @override
  String get sendOtpTitle => 'إرسال رمز التحقق';

  @override
  String get enterPhoneForOtp => 'أدخل رقم هاتفك لإرسال رمز التحقق';

  @override
  String get phoneHint => 'رقم الجوال';

  @override
  String get invalidPhoneError => 'يرجى إدخال رقم هاتف صحيح';

  @override
  String get otpSentSuccess => 'تم إرسال رمز التحقق بنجاح';

  @override
  String otpSendError(Object message) {
    return 'خطأ: $message';
  }

  @override
  String get otpSendFailGeneric => 'تعذر إرسال الرمز';

  @override
  String pleaseWait(Object seconds) {
    return 'يرجى الانتظار $seconds ثانية';
  }

  @override
  String get sendCode => 'إرسال الرمز';

  @override
  String get wait => 'انتظر...';

  @override
  String get failedToLoadCountries => 'فشل تحميل قائمة الدول';

  @override
  String get connectionErrorMessage => ' حدث خطأ أثناء الاتصال';

  @override
  String pleaseWaitSeconds(Object seconds) {
    return 'يرجى الانتظار $seconds ثانية';
  }

  @override
  String get sendOtpInstruction => 'أدخل رقم هاتفك لإرسال رمز التحقق';

  @override
  String get invalidPhoneInput => 'يرجى إدخال رقم هاتف صحيح';

  @override
  String get otpResentMessage => 'تم إعادة إرسال رمز التحقق';

  @override
  String get requiredField => 'هذا الحقل مطلوب';

  @override
  String get createAccount => 'إنشاء حساب';

  @override
  String get fullName => 'الاسم الكامل';

  @override
  String get email => 'البريد الإلكتروني';

  @override
  String get confirmPassword => 'تأكيد كلمة المرور';

  @override
  String get ok => 'حسناً';

  @override
  String get invalidEmail => 'يرجى إدخال بريد إلكتروني صحيح';

  @override
  String get passwordComplexError => 'يجب أن تتكون كلمة المرور من 8 خانات على الأقل وتحتوي على حرف كبير ورمز';

  @override
  String get passwordMismatch => 'كلمتا المرور غير متطابقتين';

  @override
  String get invalidPhone => 'يرجى إدخال رقم أردني صحيح يبدأ بـ +9627';

  @override
  String get invalidPassword => 'يجب أن تتكون كلمة المرور من 8 خانات على الأقل';

  @override
  String get welcomeBack => 'مرحبًا بعودتك';

  @override
  String get pleaseSignIn => 'يرجى تسجيل الدخول للمتابعة';

  @override
  String get username => 'اسم المستخدم';

  @override
  String get signIn => 'تسجيل الدخول';

  @override
  String get addStation => 'إضافة محطة';

  @override
  String get notMember => 'لست عضوًا؟ ';

  @override
  String get countryCode => 'رمز الدولة';

  @override
  String get logout => 'تسجيل الخروج';

  @override
  String get logoutFailed => 'فشل تسجيل الخروج';

  @override
  String get unexpectedError => 'خطأ, حاول لاحقًا.';

  @override
  String get otpCode => 'رمز التحقق';

  @override
  String get resetPassword => 'إعادة تعيين كلمة المرور';

  @override
  String get sendOtp => 'إرسال الرمز';

  @override
  String get passwordsDoNotMatch => 'كلمتا المرور غير متطابقتين';

  @override
  String get unknownError => 'حدث خطأ غير متوقع. الرجاء المحاولة مرة أخرى.';

  @override
  String get passwordLengthError => 'يجب أن تتكون كلمة المرور من 8 أحرف على الأقل';

  @override
  String get language => 'اللغة';

  @override
  String get resetPasswordTitle => 'استعادة كلمة المرور';

  @override
  String get newPassword => 'كلمة المرور الجديدة';

  @override
  String get confirmNewPassword => 'تأكيد كلمة المرور الجديدة';

  @override
  String get passwordResetSuccess => 'تم تغيير كلمة المرور بنجاح';

  @override
  String get passwordsNotMatch => 'كلمتا المرور غير متطابقتين';

  @override
  String get otpExpiredOrInvalid => 'انتهت صلاحية رمز التحقق.';

  @override
  String get stations => 'المحطات';

  @override
  String get map => 'خريطة';

  @override
  String get list => 'قائمة';

  @override
  String get loginRequired => 'يرجى تسجيل الدخول';

  @override
  String get loginRequiredMessage => 'تحتاج إلى تسجيل الدخول أولاً لاستخدام خدمات التطبيق.';

  @override
  String get login => 'تسجيل دخول';

  @override
  String get close => 'الغاء';

  @override
  String get searchLocation => 'بحث';

  @override
  String get chargerType => 'نوع الشاحن';

  @override
  String get city => 'المدينة';

  @override
  String get cancel => 'إلغاء';

  @override
  String get invalidPhoneNumber => 'صيغة رقم الهاتف غير صالحة';

  @override
  String get country => 'الدولة';

  @override
  String get searchCountries => 'ابحث عن دولة...';

  @override
  String get noResultsFound => 'لا توجد بيانات لعرضها';

  @override
  String get invalidCountryCode => 'رمز الدولة غير صالح. يرجى اختيار دولة صحيحة.';

  @override
  String get passwordTooShort => 'يجب أن تكون كلمة المرور 8 أحرف على الأقل';

  @override
  String get passwordComplexity => 'يجب أن تحتوي كلمة المرور على أحرف وأرقام';

  @override
  String get loginFailed => 'فشل تسجيل الدخول، يرجى التحقق من البيانات';

  @override
  String get loginUnexpectedError => 'رقم الهاتف أو كلمة المرور غير صحيحة';

  @override
  String get withEtron => 'مع إيترون';

  @override
  String get invalidCredentials => 'رقم الهاتف أو كلمة المرور غير صحيحة';

  @override
  String get phoneNotRegistered => 'رقم الهاتف غير مسجل';

  @override
  String get phoneAlreadyExists => 'رقم الهاتف مسجَّل بالفعل';

  @override
  String get accountCreatedSuccess => 'تم إنشاء الحساب بنجاح!';

  @override
  String get loginSuccess => 'تم تسجيل الدخول بنجاح!';

  @override
  String get signupSuccess => 'تم إنشاء الحساب بنجاح!';

  @override
  String get exploreStationsNearYou => 'استكشف محطات\nالشحن القريبة منك';

  @override
  String get availableNowCompatible => 'متاح الآن ومتوافق مع سيارتك الكهربائية';

  @override
  String get register => 'إنشاء حساب';

  @override
  String get continueAsVisitor => 'الدخول كزائر';

  @override
  String get loginHere => 'تسجيل الدخول هنا';

  @override
  String get welcomeBackBig => 'مرحبًا بك مرة أخرى';

  @override
  String get createNewAccount => 'إنشاء حساب جديد';

  @override
  String get signupSubtitle => 'أنشئ حسابًا لتستكشف جميع الوظائف المتاحة';

  @override
  String get alreadyHaveAccount => 'لديك حساب مسبقًا';

  @override
  String get verifyPhoneNumber => 'التحقق من الهاتف';

  @override
  String get enterRegisteredPhoneForReset => 'أدخل رقم هاتفك المسجل لإعادة تعيين كلمة المرور';

  @override
  String get phoneNumberNotRegistered => 'رقم الهاتف غير مسجل';

  @override
  String get phoneRequired => 'رقم الهاتف مطلوب.';

  @override
  String get accountLocked => 'تم قفل الحساب مؤقتًا، حاول لاحقًا';

  @override
  String tooManyAttempts(Object minutes) {
    return 'تجاوزت عدد محاولات تسجيل الدخول، جرِّب بعد $minutes دقيقة';
  }

  @override
  String get passwordExpired => 'انتهت صلاحية كلمة المرور، يرجى إعادة تعيينها';

  @override
  String get serverUnavailable => 'الخادم غير متاح حاليًا، حاول مجددًا';

  @override
  String get main => 'الرئيسية';

  @override
  String get searchHint => 'أين تريد الشحن؟';

  @override
  String get filter => 'فلتر';

  @override
  String get tesla => 'تسلا';

  @override
  String get type2 => 'النوع 2';

  @override
  String get chademo => 'CHAdeMO';

  @override
  String get listPlaceholder => 'عرض القائمة';

  @override
  String get invalidCode => 'رمز التحقق غير صحيح';

  @override
  String get otpExpired => 'انتهت صلاحية رمز التحقق. يرجى طلب رمز جديد.';

  @override
  String get incorrectOtp => 'رمز التحقق الذي أدخلته غير صحيح.';

  @override
  String get documents => 'المستندات';

  @override
  String get viewAndManageDocuments => 'عرض وإدارة مستنداتك';

  @override
  String get addDocument => 'إضافة مستند';

  @override
  String get comingSoon => 'قريبًا';

  @override
  String get noDocumentsFound => 'لا توجد مستندات';

  @override
  String get addYourFirstDocument => 'أضِف أول مستند للبدء';

  @override
  String get document => 'المستند';

  @override
  String get expiry => 'انتهاء الصلاحية';

  @override
  String get documentStatusValid => 'ساري';

  @override
  String get documentStatusExpiringSoon => 'قارب على الانتهاء';

  @override
  String get documentStatusExpired => 'منتهي';

  @override
  String get changeLanguage => 'تغيير اللغة';

  @override
  String get changeLanguageSubtitle => 'التبديل بين العربية والإنجليزية';

  @override
  String get myDocuments => 'مستنداتي';

  @override
  String get confirm => 'تأكيد';

  @override
  String get account => 'حسابي';

  @override
  String get notifications => 'الإشعارات';

  @override
  String get personalInformation => 'المعلومات الشخصية';

  @override
  String get vehicles => 'المركبات';

  @override
  String get settings => 'الإعدادات';

  @override
  String copyright(Object brand, Object year) {
    return '© $brand $year';
  }

  @override
  String get switchLanguageToArabic => 'التبديل إلى العربية';

  @override
  String get switchLanguageToEnglish => 'التبديل إلى الإنجليزية';

  @override
  String get save => 'حفظ';

  @override
  String get yourAccount => 'حسابك';

  @override
  String get accountInformation => 'معلومات الحساب';

  @override
  String get changeQuestion => 'تغيير؟';

  @override
  String get nationalNumber => 'الرقم الوطني';

  @override
  String get deleteMyAccount => 'حذف حسابي';

  @override
  String get currentPasswordIncorrect => 'كلمة المرور الحالية غير صحيحة';

  @override
  String get userNotFound => 'المستخدم غير موجود';

  @override
  String get currentPassword => 'كلمة المرور الحالية';

  @override
  String get activeUserNotFound => 'لا يوجد مستخدم نشط مطابق';

  @override
  String get phoneOrEmailRequired => 'الهاتف أو البريد الإلكتروني مطلوب';

  @override
  String get changePasswordTitle => 'تغيير كلمة المرور';

  @override
  String get enterCurrentPasswordHint => 'أدخل كلمة المرور الحالية';

  @override
  String get enterNewPasswordHint => 'أدخل كلمة المرور الجديدة';

  @override
  String get confirmNewPasswordHint => 'أعد إدخال كلمة المرور الجديدة للتأكيد';

  @override
  String get addVehicleCta => 'أضف مركبة';

  @override
  String get vehiclesEmptyHelper => 'احصل على أفضل نتائج الشحن المخصصة لك! أضف تفاصيل مركبتك لرؤية نقاط الشحن التي تطابق مركبتك والاستمتاع بأداء مميز دائمًا.';

  @override
  String get addYourCharger => 'أضف منفذ الشحن';

  @override
  String get acChargerType => 'نوع شاحن AC';

  @override
  String get dcChargerType => 'نوع شاحن DC';

  @override
  String get addVehicleLicense => 'أضف رخصة المركبة';

  @override
  String get plateCountry => 'بلد اللوحة';

  @override
  String get plateNumber => 'رقم اللوحة';

  @override
  String get fromDate => 'تاريخ البدء';

  @override
  String get expiryDate => 'تاريخ الانتهاء';

  @override
  String get carNameEn => 'اسم المركبة (إنجليزي)';

  @override
  String get carNameAr => 'اسم المركبة (عربي)';

  @override
  String get manufacturingCountry => 'بلد التصنيع';

  @override
  String get carYearHint => 'السنة';

  @override
  String get carColorHint => 'اللون';

  @override
  String get carAddedSuccessfully => 'تمت إضافة المركبة بنجاح';

  @override
  String get searchChargerType => 'ابحث عن نوع الشاحن...';

  @override
  String get exampleCarNameEn => 'مثال: My Tesla Model 3';

  @override
  String get exampleCarNameAr => 'مثال: تسلا موديل 3';

  @override
  String get exampleManufacturingCountry => 'مثال: ألمانيا';

  @override
  String get examplePlateCountry => 'مثال: الأردن';

  @override
  String get exampleCarYear => 'مثال: 2022';

  @override
  String get exampleCarColor => 'مثال: أسود';

  @override
  String get examplePlateNumber => 'مثال: 20-12345';

  @override
  String get exampleFromDate => 'مثال: 01/01/2024';

  @override
  String get exampleExpiryDate => 'مثال: 31/12/2026';

  @override
  String get exampleAcType => 'مثال: Type 2 (Mennekes)';

  @override
  String get exampleDcType => 'مثال: CCS Type 2';

  @override
  String get carModel => 'موديل السيارة';

  @override
  String get carProfile => 'ملف المركبة';

  @override
  String get documentDetails => 'تفاصيل المستند';

  @override
  String get documentType => 'نوع الحقل';

  @override
  String get ownerName => 'اسم المالك';

  @override
  String get uploadAttachment => 'رفع المرفق';

  @override
  String get attachFile => 'الرجاء إرفاق ملف';

  @override
  String get savedSuccessfully => 'تم الحفظ بنجاح';

  @override
  String get noDocumentsYet => 'لا توجد مستندات بعد';

  @override
  String get pickDocumentType => 'اختر نوع المستند';

  @override
  String get defaultVehicleLicense => 'رخصة سيارة';

  @override
  String get addDocumentCta => 'إضافة مستند';

  @override
  String get ownerNameHint => 'مثال: أحمد علي';

  @override
  String get selectExpiryDate => 'اختر تاريخ الانتهاء';

  @override
  String get attachment => 'المرفق';

  @override
  String get chooseFile => 'اختر ملفًا';

  @override
  String get noFileChosen => 'لم يتم اختيار ملف';

  @override
  String get noFileSelected => 'لم يتم اختيار ملف';

  @override
  String get allowedFileTypes => 'PDF, JPG, PNG • الحد الأقصى 10MB';

  @override
  String get documentAddedSuccessfully => 'تمت إضافة المستند بنجاح';

  @override
  String get vehicleProfile => 'ملف المركبة';

  @override
  String get selectDocumentType => 'اختر نوع المستند';

  @override
  String get expiryDateHint => 'YYYY-MM-DD';

  @override
  String get pickFile => 'اختر ملف';

  @override
  String get failedToUploadDocument => 'فشل رفع المستند';

  @override
  String get vehicleLicense => 'رخصة سيارة';

  @override
  String get version => 'الأصدار';

  @override
  String get loading => 'جاري تحميل';

  @override
  String get emailAlreadyExists => 'هذا البريد الإلكتروني مُسجَّل مسبقًا.';

  @override
  String get fillRequiredFields => 'الرجاء تعبئة جميع الحقول المطلوبة.';

  @override
  String get atLeastOneCharger => 'الرجاء اختيار نوع شاحن واحد على الأقل.';

  @override
  String get documentNumber => 'رقم الوثيقة';

  @override
  String get documentNumberHint => 'مثال: الرقم الموجود على الوثيقة';

  @override
  String get addYourVehicleNow => 'أضف مركبتك الآن!';

  @override
  String get addVehicleToAccessFeatures => 'للوصول لخدمات الشحن وإدارة المستندات.';

  @override
  String get retry => 'إعادة المحاولة';

  @override
  String get etronNumber => 'رقم إيترون';

  @override
  String get carDetails => 'تفاصيل المركبة';

  @override
  String get deleteAccountConfirmationMessage => 'هل أنت متأكد من رغبتك في حذف حسابك بشكل نهائي؟ لا يمكن التراجع عن هذا الإجراء.';

  @override
  String get delete => 'حذف';

  @override
  String get accountDeletedSuccessfully => 'تم حذف حسابك بنجاح';
}
