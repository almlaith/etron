import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:etron_flutter/ui/theme/colors.dart';
import 'package:etron_flutter/common/card/group_card.dart';
import 'package:etron_flutter/common/overlays/snackbar.dart';
import 'package:etron_flutter/common/field/input_field.dart';
import 'package:etron_flutter/l10n/app_localizations.dart';
import 'package:etron_flutter/services/common_service.dart';
import 'package:etron_flutter/services/vehicle_service.dart';
import 'package:etron_flutter/models/select_option.dart';
import 'package:etron_flutter/common/validator.dart';

import '../../../models/vehicle_model.dart';

class AddVehicleScreen extends StatefulWidget {
  const AddVehicleScreen({super.key});

  @override
  State<AddVehicleScreen> createState() => _AddVehicleScreenState();
}

class _AddVehicleScreenState extends State<AddVehicleScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _saving = false;
  bool _submitted = false;
  bool _loadingInit = true;
  final _nameEnCtrl = TextEditingController();
  final _nameArCtrl = TextEditingController();
  final _plateCtrl = TextEditingController();
  final _colorCtrl = TextEditingController();
  final _yearCtrl = TextEditingController(text: '');
  final _modelCtrl = TextEditingController();
  List<SelectOption> _countries = [];
  List<ChargerTypeOption> _chargerTypes = [];
  SelectOption? _plateCountry;
  SelectOption? _manCountry;
  ChargerTypeOption? _acTypeSel;
  ChargerTypeOption? _dcTypeSel;
  bool _bootstrapped = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_bootstrapped) return;
    final locale = AppLocalizations.of(context)!.localeName;
    _bootstrap(locale: locale);
    _bootstrapped = true;
  }

  @override
  void dispose() {
    _nameEnCtrl.dispose();
    _nameArCtrl.dispose();
    _plateCtrl.dispose();
    _colorCtrl.dispose();
    _yearCtrl.dispose();
    _modelCtrl.dispose();
    super.dispose();
  }

  Future<void> _bootstrap({String? locale}) async {
    setState(() => _loadingInit = true);
    try {
      final locale = AppLocalizations.of(context)!.localeName;
      final countries = await CommonService.selectCountries(locale: locale);
      final types = await CommonService.selectChargerTypes(locale: locale);
      if (!mounted) return;
      setState(() {
        _countries = countries;
        _chargerTypes = types.cast<ChargerTypeOption>();
        _loadingInit = false;
      });
    } catch (_) {
      if (!mounted) return;
      setState(() => _loadingInit = false);
      final t = AppLocalizations.of(context)!;
      AppSnackbar.error(context, t.unexpectedError);
    }
  }

  Widget _sectionLabel(String text) {
    return Padding(
      padding: const EdgeInsetsDirectional.only(
        top: 12,
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
  }

  Widget _pickerField({
    required String hintText,
    String? placeholder,
    required String selectedText,
    required VoidCallback onTap,
    String? errorText,
  }) {
    final effectiveHint = (selectedText.isEmpty) ? (placeholder ?? hintText) : '';
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
              borderColor: hasError ? Colors.red : AppColors.primary,
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
              style: TextStyle(color: Colors.red[700], fontSize: 12),
            ),
          ),
      ],
    );
  }

  Future<void> _showSelectOptionPicker({
    required String title,
    required List<SelectOption> source,
    required void Function(SelectOption sel) onSelected,
  }) async {
    final t = AppLocalizations.of(context)!;
    final searchCtrl = TextEditingController();
    var filtered = List<SelectOption>.from(source);
    await showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.surface,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (ctx) {
        return StatefulBuilder(
          builder: (ctx, setSheet) {
            return Padding(
              padding: EdgeInsets.only(
                left: 16,
                right: 16,
                top: 16,
                bottom: MediaQuery.of(ctx).viewInsets.bottom + 16,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: searchCtrl,
                    decoration: InputDecoration(
                      hintText: t.searchCountries,
                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(12),
                        child: SvgPicture.asset(
                          'assets/icons/search.svg',
                          width: 20,
                          height: 20,
                          colorFilter: const ColorFilter.mode(
                            AppColors.primary,
                            BlendMode.srcIn,
                          ),
                        ),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      isDense: false,
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 12,
                        horizontal: 12,
                      ),
                    ),
                    onChanged: (v) {
                      final q = v.toLowerCase();
                      setSheet(() {
                        filtered = source
                            .where(
                              (e) =>
                          e.label.toLowerCase().contains(q) ||
                              e.value.toString().contains(q),
                        )
                            .toList();
                      });
                    },
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    height: 420,
                    child: filtered.isEmpty
                        ? Center(child: Text(t.noResultsFound))
                        : ListView.builder(
                      itemCount: filtered.length,
                      itemBuilder: (_, i) {
                        final it = filtered[i];
                        return ListTile(
                          title: Text(it.label),
                          onTap: () {
                            Navigator.pop(ctx);
                            onSelected(it);
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Future<void> _showChargerTypePicker({
    required String title,
    required List<ChargerTypeOption> source,
    required void Function(ChargerTypeOption sel) onSelected,
  }) async {
    final t = AppLocalizations.of(context)!;
    final searchCtrl = TextEditingController();
    var filtered = List<ChargerTypeOption>.from(source);
    await showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.surface,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (ctx) {
        return StatefulBuilder(
          builder: (ctx, setSheet) {
            return Padding(
              padding: EdgeInsets.only(
                left: 16,
                right: 16,
                top: 16,
                bottom: MediaQuery.of(ctx).viewInsets.bottom + 16,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: searchCtrl,
                    decoration: InputDecoration(
                      hintText: t.searchChargerType,
                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(12),
                        child: SvgPicture.asset(
                          'assets/icons/search.svg',
                          width: 20,
                          height: 20,
                          colorFilter: const ColorFilter.mode(
                            AppColors.primary,
                            BlendMode.srcIn,
                          ),
                        ),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      isDense: false,
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 12,
                        horizontal: 12,
                      ),
                    ),
                    onChanged: (v) {
                      final q = v.toLowerCase();
                      setSheet(() {
                        filtered = source
                            .where(
                              (e) =>
                          e.label.toLowerCase().contains(q) ||
                              e.id.toString().contains(q) ||
                              e.type.toLowerCase().contains(q),
                        )
                            .toList();
                      });
                    },
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    height: 420,
                    child: filtered.isEmpty
                        ? Center(child: Text(t.noResultsFound))
                        : ListView.builder(
                      itemCount: filtered.length,
                      itemBuilder: (_, i) {
                        final it = filtered[i];
                        return ListTile(
                          title: Text(it.label),
                          subtitle:
                          it.type.isEmpty ? null : Text(it.type),
                          onTap: () {
                            Navigator.pop(ctx);
                            onSelected(it);
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Future<void> _save() async {
    setState(() => _submitted = true);
    final t = AppLocalizations.of(context)!;

    final isTextFormValid = _formKey.currentState!.validate();
    final isNameValid = _nameEnCtrl.text.trim().isNotEmpty ||
        _nameArCtrl.text.trim().isNotEmpty;
    final isManCountryValid = _manCountry != null;
    final isPlateCountryValid = _plateCountry != null;
    final areChargersValid = _acTypeSel != null || _dcTypeSel != null;

    final isFormValid = isTextFormValid &&
        isNameValid &&
        isManCountryValid &&
        areChargersValid &&
        isPlateCountryValid;

    if (!isFormValid) {
      AppSnackbar.error(context, t.fillRequiredFields);
      setState(() {});
      return;
    }

    setState(() => _saving = true);
    try {
      final now = DateTime.now().toUtc();
      final thru = DateTime(now.year + 2, now.month, now.day).toUtc();

      final req = AddVehicleRequest(
        nameEn: _nameEnCtrl.text.trim(),
        nameAr: _nameArCtrl.text.trim(),
        plateCountryId: _plateCountry!.value,
        plateNumber: _plateCtrl.text.trim(),
        fromDate: now,
        thruDate: thru,
        manufacturingCountryId: _manCountry!.value,
        acChargerTypeId: _acTypeSel?.id,
        dcChargerTypeId: _dcTypeSel?.id,
        carColor:
        _colorCtrl.text.trim().isEmpty ? null : _colorCtrl.text.trim(),
        carManufacturingYear: int.tryParse(_yearCtrl.text.trim()),
        carModel:
        _modelCtrl.text.trim().isEmpty ? null : _modelCtrl.text.trim(),
      );
      final res = await VehicleService.addCar(req);
      if (res.success) {
        AppSnackbar.success(context, t.carAddedSuccessfully);
        if (mounted) Navigator.of(context).maybePop(true);
      } else {
        AppSnackbar.error(
          context,
          (res.message ?? t.unexpectedError).toString(),
        );
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
                    t.addVehicleCta,
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
                  Padding(
                    padding: const EdgeInsets.fromLTRB(12, 6, 12, 6),
                    child: Form(
                      key: _formKey,
                      autovalidateMode: _submitted
                          ? AutovalidateMode.always
                          : AutovalidateMode.disabled,
                      child: Column(
                        children: [
                          _sectionLabel(t.carNameEn),
                          InputField(
                            label: '',
                            controller: _nameEnCtrl,
                            hintText: t.exampleCarNameEn,
                            borderColor: AppColors.primary,
                            fillColor: AppColors.white,
                            validator: (v) {
                              if (_submitted &&
                                  _nameEnCtrl.text.trim().isEmpty &&
                                  _nameArCtrl.text.trim().isEmpty) {
                                return t.requiredField;
                              }
                              return null;
                            },
                          ),
                          _sectionLabel(t.carNameAr),
                          InputField(
                            label: '',
                            controller: _nameArCtrl,
                            hintText: t.exampleCarNameAr,
                            borderColor: AppColors.primary,
                            fillColor: AppColors.white,
                            validator: (v) {
                              if (_submitted &&
                                  _nameEnCtrl.text.trim().isEmpty &&
                                  _nameArCtrl.text.trim().isEmpty) {
                                return t.requiredField;
                              }
                              return null;
                            },
                          ),
                          _sectionLabel(t.manufacturingCountry),
                          _pickerField(
                            hintText: t.manufacturingCountry,
                            placeholder: t.exampleManufacturingCountry,
                            selectedText: _manCountry?.label ?? '',
                            errorText: _submitted && _manCountry == null
                                ? t.requiredField
                                : null,
                            onTap: () => _showSelectOptionPicker(
                              title: t.manufacturingCountry,
                              source: _countries,
                              onSelected: (sel) =>
                                  setState(() => _manCountry = sel),
                            ),
                          ),
                          _sectionLabel(t.carYearHint),
                          InputField(
                            label: '',
                            controller: _yearCtrl,
                            hintText: t.exampleCarYear,
                            keyboardType: TextInputType.number,
                            borderColor: AppColors.primary,
                            fillColor: AppColors.white,
                          ),
                          _sectionLabel(t.carModel),
                          InputField(
                            label: '',
                            controller: _modelCtrl,
                            hintText: t.exampleCarNameEn,
                            borderColor: AppColors.primary,
                            fillColor: AppColors.white,
                          ),
                          _sectionLabel(t.carColorHint),
                          InputField(
                            label: '',
                            controller: _colorCtrl,
                            hintText: t.exampleCarColor,
                            borderColor: AppColors.primary,
                            fillColor: AppColors.white,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              GroupCard(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(12, 6, 12, 12),
                    child: Column(
                      children: [
                        _sectionLabel(t.acChargerType),
                        _pickerField(
                          hintText: t.acChargerType,
                          placeholder: t.exampleAcType,
                          selectedText: _acTypeSel?.label ?? '',
                          errorText: _submitted &&
                              _acTypeSel == null &&
                              _dcTypeSel == null
                              ? t.atLeastOneCharger
                              : null,
                          onTap: () => _showChargerTypePicker(
                            title: t.acChargerType,
                            source: _chargerTypes
                                .where((e) => e.type == 'AC')
                                .toList(),
                            onSelected: (sel) =>
                                setState(() => _acTypeSel = sel),
                          ),
                        ),
                        _sectionLabel(t.dcChargerType),
                        _pickerField(
                          hintText: t.dcChargerType,
                          placeholder: t.exampleDcType,
                          selectedText: _dcTypeSel?.label ?? '',
                          errorText: _submitted &&
                              _acTypeSel == null &&
                              _dcTypeSel == null
                              ? t.atLeastOneCharger
                              : null,
                          onTap: () => _showChargerTypePicker(
                            title: t.dcChargerType,
                            source: _chargerTypes
                                .where(
                                  (e) => e.type == 'DC' || e.type == 'AC/DC',
                            )
                                .toList(),
                            onSelected: (sel) =>
                                setState(() => _dcTypeSel = sel),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              GroupCard(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(12, 6, 12, 12),
                    child: Column(
                      children: [
                        _sectionLabel(t.plateCountry),
                        _pickerField(
                          hintText: t.plateCountry,
                          placeholder: t.examplePlateCountry,
                          selectedText: _plateCountry?.label ?? '',
                          errorText: _submitted && _plateCountry == null
                              ? t.requiredField
                              : null,
                          onTap: () => _showSelectOptionPicker(
                            title: t.plateCountry,
                            source: _countries,
                            onSelected: (sel) =>
                                setState(() => _plateCountry = sel),
                          ),
                        ),
                        _sectionLabel(t.plateNumber),
                        InputField(
                          label: '',
                          controller: _plateCtrl,
                          hintText: t.examplePlateNumber,
                          borderColor: AppColors.primary,
                          fillColor: AppColors.white,
                          autovalidateMode: _submitted
                              ? AutovalidateMode.always
                              : AutovalidateMode.disabled,
                          validator: (v) => Validator.validate(context, v, [
                            Validator.required(),
                          ]),
                        ),
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