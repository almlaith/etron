import 'dart:io';
import 'package:etron_flutter/services/document_service.dart';
import 'package:etron_flutter/common/card/group_card.dart';
import 'package:etron_flutter/common/field/input_field.dart';
import 'package:etron_flutter/common/overlays/snackbar.dart';
import 'package:etron_flutter/l10n/app_localizations.dart';
import 'package:etron_flutter/models/car_document.dart';
import 'package:etron_flutter/ui/theme/colors.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../common/validator.dart';

class DocumentDetailsScreen extends StatefulWidget {
  final String carId;
  final String groupId;
  final String documentTypeName;
  final List<CarDocument> versionsOfGroup;

  const DocumentDetailsScreen({
    super.key,
    required this.carId,
    required this.groupId,
    required this.documentTypeName,
    required this.versionsOfGroup,
  });

  @override
  State<DocumentDetailsScreen> createState() => _DocumentDetailsScreenState();
}

class _DocumentDetailsScreenState extends State<DocumentDetailsScreen> {
   final _formKey = GlobalKey<FormState>();
  bool _submitted = false;

  bool _uploading = false;
  final _numberCtrl = TextEditingController();
  final _expiryCtrl = TextEditingController();
  DateTime? _expiryDate;
  File? _pickedFile;

  List<CarDocument> get _versions {
    final list = [...widget.versionsOfGroup]
      ..sort((a, b) => b.actualVersion.compareTo(a.actualVersion));
    return list;
  }

  @override
  void dispose() {
    _numberCtrl.dispose();
    _expiryCtrl.dispose();
    super.dispose();
  }

  Future<void> _pickFile() async {
    final res = await FilePicker.platform.pickFiles(allowMultiple: false, type: FileType.any);
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

  Future<void> _uploadNewVersion() async {
    final t = AppLocalizations.of(context)!;
    setState(() => _submitted = true);

    final isTextFormValid = _formKey.currentState?.validate() ?? false;
    final isFilePicked = _pickedFile != null;

    if (!isTextFormValid || !isFilePicked) {
      AppSnackbar.error(context, t.fillRequiredFields);
       setState(() {});
      return;
    }

    setState(() => _uploading = true);
    try {
      final ok = await DocumentService.uploadCarDocumentVersion(
        carId: widget.carId,
        groupId: widget.groupId,
        documentNumber: _numberCtrl.text.trim(),
        endDate: _expiryCtrl.text.trim(),
        file: _pickedFile!,
      );

      if (!mounted) return;
      if (ok) {
        AppSnackbar.success(context, t.documentAddedSuccessfully);
        Navigator.of(context).maybePop(true);
      } else {
        AppSnackbar.error(context, t.failedToUploadDocument);
      }
    } catch (_) {
      if (!mounted) return;
      AppSnackbar.error(context, t.unexpectedError);
    } finally {
      if (mounted) setState(() => _uploading = false);
    }
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
              child: InputField(
                label: '',
                controller: TextEditingController(
                  text: _pickedFile?.path.split(Platform.pathSeparator).last ?? '',
                ),
                hintText: t.noFileSelected,
                borderColor: hasError ? AppColors.error : Colors.transparent,
                fillColor: AppColors.white,
              ),
            ),
            const SizedBox(width: 8),
            ElevatedButton(
              onPressed: _pickFile,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                elevation: 0,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
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

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: const Color(0xFFF3F4F6),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
               Row(children: [
                IconButton(
                  onPressed: () => Navigator.of(context).maybePop(),
                  icon: const Icon(Icons.arrow_back_ios_new, color: AppColors.textPrimary),
                  splashRadius: 22,
                ),
                const Spacer(),
              ]),
              Padding(
                padding: const EdgeInsetsDirectional.only(start: 16),
                child: Text(
                  widget.documentTypeName,
                  style: const TextStyle(fontSize: 28, fontWeight: FontWeight.w900, color: AppColors.primary),
                ),
              ),
              const SizedBox(height: 12),

              GroupCard(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(12, 12, 12, 4),
                    child: Text(t.documents,
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
                  ),
                  const Divider(height: 1, color: AppColors.divider),
                  if (_versions.isEmpty)
                    Padding(
                      padding: const EdgeInsets.all(12),
                      child: Text(t.noDocumentsYet, style: const TextStyle(color: AppColors.textSecondary)),
                    )
                  else
                    ..._versions.map((d) {
                      final url = DocumentService.buildAttachmentDownloadUrl(d.documentId);
                      return ListTile(
                        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
                        title: Text('${d.name}  (${d.versionLabel})', style: const TextStyle(fontWeight: FontWeight.w700)),
                        subtitle: Text('${t.expiryDate}: ${d.prettyDate(d.endDate)} • ${t.documentNumber}: ${d.documentNumber ?? '-'}'),
                        trailing: IconButton(
                          icon: const Icon(Icons.download),
                          onPressed: () async {
                            final uri = Uri.parse(url);
                            if (await canLaunchUrl(uri)) {
                              await launchUrl(uri, mode: LaunchMode.externalApplication);
                            } else {
                              if (!mounted) return;
                              AppSnackbar.error(context, t.unexpectedError);
                            }
                          },
                        ),
                      );
                    }).toList(),
                  const SizedBox(height: 4),
                ],
              ),
              const SizedBox(height: 16),
              GroupCard(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(12, 12, 12, 8),
                    child: Text(t.version,
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
                  ),
                  const Divider(height: 1, color: AppColors.divider),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(12, 8, 12, 12),
                     child: Form(
                      key: _formKey,
                      autovalidateMode: _submitted
                          ? AutovalidateMode.always
                          : AutovalidateMode.disabled,
                      child: Column(
                        children: [
                          InputField(
                            label: '',
                            controller: _numberCtrl,
                            hintText: t.documentNumberHint,
                            borderColor: Colors.transparent,
                            fillColor: AppColors.white,
                            validator: (v) => Validator.validate(context, v, [
                              Validator.required(),
                            ]),
                          ),
                          const SizedBox(height: 10),
                          InkWell(
                            onTap: _pickExpiryDate,
                            child: IgnorePointer(
                              child: InputField(
                                label: '',
                                controller: _expiryCtrl,
                                hintText: t.expiryDateHint,
                                borderColor: Colors.transparent,
                                fillColor: AppColors.white,
                                suffixIcon: const Icon(Icons.date_range, color: Colors.black),
                                validator: (v) => Validator.validate(context, v, [
                                  Validator.required(),
                                ]),
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          _filePickerField(
                            errorText: _submitted && _pickedFile == null
                                ? t.requiredField
                                : null,
                          ),
                          const SizedBox(height: 14),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: _uploading ? null : _uploadNewVersion,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.primary,
                                foregroundColor: Colors.white,
                                elevation: 0,
                                padding: const EdgeInsets.symmetric(vertical: 14),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                              ),
                              child: Text(_uploading ? t.loading : t.save),
                            ),
                          ),
                        ],
                      ),
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