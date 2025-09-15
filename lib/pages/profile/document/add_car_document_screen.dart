import 'dart:io';
import 'package:etron_flutter/services/document_service.dart';
import 'package:etron_flutter/common/card/group_card.dart';
import 'package:etron_flutter/common/field/input_field.dart';
import 'package:etron_flutter/common/overlays/snackbar.dart';
import 'package:etron_flutter/l10n/app_localizations.dart';
import 'package:etron_flutter/ui/theme/colors.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import '../../../common/validator.dart';
import '../../../models/document_type_option.dart';

class AddCarDocumentScreen extends StatefulWidget {
  final String carId;

  const AddCarDocumentScreen({super.key, required this.carId});

  @override
  State<AddCarDocumentScreen> createState() => _AddCarDocumentScreenState();
}

class _AddCarDocumentScreenState extends State<AddCarDocumentScreen> {
  final _formKey = GlobalKey<FormState>();
  final _documentNumberCtrl = TextEditingController();
  final _expiryCtrl = TextEditingController();
  DateTime? _expiryDate;

  bool _saving = false;
  bool _submitted = false;
  bool _loadingInit = true;

  List<DocumentTypeOption> _docTypes = [];
  DocumentTypeOption? _docTypeSel;

  File? _pickedFile;
  bool _bootstrapped = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_bootstrapped) return;
    _bootstrapped = true;
    _bootstrap();
  }

  @override
  void dispose() {
    _documentNumberCtrl.dispose();
    _expiryCtrl.dispose();
    super.dispose();
  }

  Future<void> _bootstrap() async {
    final t = AppLocalizations.of(context)!;
    setState(() => _loadingInit = true);
    try {
      final locale = t.localeName;
      final types = await DocumentService.selectDocumentTypes(
        locale: locale,
        targetType: 'CAR',
      );

      DocumentTypeOption? def = types.firstWhere(
        (e) =>
            e.label.toLowerCase().contains('vehicle license') ||
            e.label.contains('رخصة سيارة'),
        orElse: () => types.isNotEmpty
            ? types.first
            : const DocumentTypeOption(
                id: 6,
                label: 'vehicle License',
                level: 2,
              ),
      );

      setState(() {
        _docTypes = types;
        _docTypeSel = def;
        _loadingInit = false;
      });
    } catch (_) {
      setState(() => _loadingInit = false);
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted) return;
        AppSnackbar.error(context, t.unexpectedError);
      });
    }
  }

  Widget _sectionLabel(String text, {bool withTopPadding = true}) => Padding(
    padding: EdgeInsetsDirectional.only(
      top: withTopPadding ? 12 : 4,
      bottom: 8,
      start: 12,
      end: 12,
    ),
    child: Align(
      alignment: AlignmentDirectional.centerStart,
      child: Text(
        text,
        textAlign: TextAlign.start,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w700,
          color: AppColors.textPrimary,
        ),
      ),
    ),
  );

  Widget _pickerField({
    required String hintText,
    String? placeholder,
    required String selectedText,
    required VoidCallback onTap,
    String? errorText,
  }) {
    final effectiveHint = (selectedText.isEmpty)
        ? (placeholder ?? hintText)
        : '';
    final hasError = errorText != null && errorText.isNotEmpty;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: onTap,
          child: IgnorePointer(
            child: InputField(
              label: '',
              controller: TextEditingController(text: selectedText),
              hintText: effectiveHint,
              borderColor: hasError ? AppColors.error : AppColors.primary,
              fillColor: AppColors.white,
              suffixIcon: const Icon(
                Icons.arrow_drop_down,
                color: Colors.black,
              ),
            ),
          ),
        ),
        if (hasError)
          Padding(
            padding: const EdgeInsets.only(left: 16.0, top: 8.0),
            child: Text(
              errorText,
              style: TextStyle(color: AppColors.error, fontSize: 12),
            ),
          ),
      ],
    );
  }

  Widget _filePickerField({String? errorText}) {
    final t = AppLocalizations.of(context)!;
    final hasError = errorText != null && errorText.isNotEmpty;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: InkWell(
                onTap: _pickFile,
                child: IgnorePointer(
                  child: InputField(
                    label: '',
                    controller: TextEditingController(
                      text:
                          _pickedFile?.path
                              .split(Platform.pathSeparator)
                              .last ??
                          '',
                    ),
                    hintText: t.noFileSelected,
                    borderColor: hasError ? AppColors.error : AppColors.primary,
                    fillColor: AppColors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8),
            ElevatedButton(
              onPressed: _pickFile,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                elevation: 0,
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 14,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(t.pickFile),
            ),
          ],
        ),
        if (hasError)
          Padding(
            padding: const EdgeInsets.only(left: 16.0, top: 8.0),
            child: Text(
              errorText,
              style: TextStyle(color: AppColors.error, fontSize: 12),
            ),
          ),
      ],
    );
  }

  Future<void> _pickDocumentType() async {
    final t = AppLocalizations.of(context)!;
    await showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.surface,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (ctx) {
        return SafeArea(
          top: false,
          child: DraggableScrollableSheet(
            initialChildSize: 0.7,
            minChildSize: 0.5,
            maxChildSize: 0.95,
            expand: false,
            builder: (context, controller) {
              return Column(
                children: [
                  const SizedBox(height: 12),
                  Text(
                    t.documentType,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Expanded(
                    child: ListView.builder(
                      controller: controller,
                      itemCount: _docTypes.length,
                      itemBuilder: (_, i) {
                        final it = _docTypes[i];
                        return ListTile(
                          title: Text(it.label),
                          onTap: () {
                            Navigator.pop(ctx);
                            setState(() => _docTypeSel = it);
                          },
                        );
                      },
                    ),
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }

  Future<void> _pickFile() async {
    final res = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      withReadStream: false,
      type: FileType.any,
    );
    if (res != null && res.files.isNotEmpty && res.files.first.path != null) {
      setState(() => _pickedFile = File(res.files.first.path!));
    }
  }

  Future<void> _pickExpiryDate() async {
    final t = AppLocalizations.of(context)!;
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: _expiryDate ?? now,
      firstDate: DateTime(now.year - 1),
      lastDate: DateTime(now.year + 10),
      helpText: t.expiryDate,
    );
    if (picked != null) {
      setState(() {
        _expiryDate = picked;
        _expiryCtrl.text =
            "${picked.year.toString().padLeft(4, '0')}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}";
      });
    }
  }

  Future<void> _save() async {
    if (_saving) return;

    final t = AppLocalizations.of(context)!;
    setState(() => _submitted = true);

    final isTextFormValid = _formKey.currentState!.validate();
    final isDocTypeSelected = _docTypeSel != null;
    final isExpiryDateSelected = _expiryDate != null;
    final isFilePicked = _pickedFile != null;

    final isFormValid =
        isTextFormValid &&
        isDocTypeSelected &&
        isExpiryDateSelected &&
        isFilePicked;

    if (!isFormValid) {
      AppSnackbar.error(context, t.fillRequiredFields);
      setState(() {});
      return;
    }

    setState(() => _saving = true);

    try {
      final start = DateTime.now().toUtc();
      final startStr =
          "${start.year.toString().padLeft(4, '0')}-${start.month.toString().padLeft(2, '0')}-${start.day.toString().padLeft(2, '0')}";

      final res = await DocumentService.uploadCarDocument(
        carId: widget.carId,
        documentTypeId: _docTypeSel!.id,
        documentNumber: _documentNumberCtrl.text.trim(),
        startDate: startStr,
        endDate: _expiryCtrl.text.trim(),
        file: _pickedFile!,
      );

      if (res.success) {
        AppSnackbar.success(context, t.documentAddedSuccessfully);
        if (!mounted) return;
        Navigator.of(context).maybePop(true);
      } else {
        final msg =
            (res.message ?? res.data?['body'] ?? t.failedToUploadDocument)
                .toString();
        AppSnackbar.error(context, msg);
      }
    } catch (_) {
      AppSnackbar.error(context, t.unexpectedError);
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;

    if (_loadingInit) {
      return const Scaffold(
        backgroundColor: Color(0xFFF3F4F6),
        body: SafeArea(child: Center(child: CircularProgressIndicator())),
      );
    }

    return Scaffold(
      backgroundColor: const Color(0xFFF3F4F6),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  IconButton(
                    onPressed: () => Navigator.of(context).maybePop(),
                    icon: const Icon(
                      Icons.arrow_back_ios_new,
                      color: AppColors.textPrimary,
                    ),
                    splashRadius: 22,
                  ),
                  const Spacer(),
                  TextButton(
                    onPressed: _saving ? null : _save,
                    child: Text(
                      t.save,
                      style: TextStyle(
                        color: _saving
                            ? AppColors.textSecondary
                            : AppColors.primary,
                        fontWeight: FontWeight.w900,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),

              Padding(
                padding: const EdgeInsetsDirectional.only(start: 16),
                child: Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: Text(
                    t.addDocumentCta,
                    textAlign: TextAlign.start,
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w900,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 18),

              GroupCard(
                children: [
                  _sectionLabel(t.documentType, withTopPadding: false),
                  _pickerField(
                    hintText: t.documentType,
                    placeholder: t.selectDocumentType,
                    selectedText: _docTypeSel?.label ?? '',
                    onTap: _pickDocumentType,
                    errorText: _submitted && _docTypeSel == null
                        ? t.requiredField
                        : null,
                  ),
                  _sectionLabel(t.documentNumber),
                  Form(
                    key: _formKey,
                    autovalidateMode: _submitted
                        ? AutovalidateMode.always
                        : AutovalidateMode.disabled,
                    child: Column(
                      children: [
                        InputField(
                          label: '',
                          controller: _documentNumberCtrl,
                          hintText: t.documentNumberHint,
                          borderColor: AppColors.primary,
                          fillColor: AppColors.white,
                          validator: (v) => Validator.validate(context, v, [
                            Validator.required(),
                          ]),
                        ),
                        _sectionLabel(t.expiryDate),
                        InkWell(
                          onTap: _pickExpiryDate,
                          child: IgnorePointer(
                            child: InputField(
                              label: '',
                              controller: _expiryCtrl,
                              hintText: t.expiryDateHint,
                              borderColor: AppColors.primary,
                              fillColor: AppColors.white,
                              suffixIcon: const Icon(
                                Icons.date_range,
                                color: Colors.black,
                              ),
                              validator: (v) => Validator.validate(context, v, [
                                Validator.required(),
                              ]),
                            ),
                          ),
                        ),
                        _sectionLabel(t.attachment),
                        _filePickerField(
                          errorText: _submitted && _pickedFile == null
                              ? t.requiredField
                              : null,
                        ),
                        const SizedBox(height: 8),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
