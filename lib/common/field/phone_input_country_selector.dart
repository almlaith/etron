import 'package:etron_flutter/services/gateway_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../models/country_model.dart';
import '../../../l10n/app_localizations.dart';
import '../../../ui/theme/colors.dart';
import '../../../api/api_service.dart';
import 'input_field.dart';

class PhoneInputWithCountrySelector extends StatefulWidget {
  final CountryModel? selectedCountry;
  final ValueChanged<CountryModel> onCountryChanged;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final String label;
  final String? hintText;
  final Color? borderColor;
  final Color? fillColor;
  final AutovalidateMode? autovalidateMode;

  const PhoneInputWithCountrySelector({
    super.key,
    required this.selectedCountry,
    required this.onCountryChanged,
    required this.controller,
    this.validator,
    this.hintText,
    required this.label,
    this.borderColor,
    this.fillColor,
    this.autovalidateMode,
  });

  @override
  State<PhoneInputWithCountrySelector> createState() =>
      _PhoneInputWithCountrySelectorState();
}

class _PhoneInputWithCountrySelectorState
    extends State<PhoneInputWithCountrySelector> {
  List<CountryModel> _countries = [];
  List<CountryModel> _filtered = [];
  bool _loading = false;
  final _searchCtrl = TextEditingController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _loadDefaultCountry();
  }

  Future<void> _loadDefaultCountry() async {
    final locale = Localizations.localeOf(context).languageCode;
    await _fetchCountries(locale);
    if (widget.selectedCountry == null && _countries.isNotEmpty) {
      final jordan = _countries.firstWhere(
            (c) => c.countryCode.toUpperCase() == 'JO',
        orElse: () => _countries.first,
      );
      widget.onCountryChanged(jordan);
    }
  }

  Future<void> _fetchCountries(String locale, [String query = '']) async {
    setState(() => _loading = true);
    final rows = await GatewayService.fetchCountries(locale: locale, query: query);
    _countries = rows.map((e) => CountryModel.fromJson(e)).toList();
    _filtered = List.from(_countries);
    setState(() => _loading = false);
  }

  void _showPicker() async {
    final locale = Localizations.localeOf(context).languageCode;
    await _fetchCountries(locale);
    if (!mounted) return;
    _searchCtrl.clear();

    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      isScrollControlled: true,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModal) {
            return Padding(
              padding: const EdgeInsets.all(16),
              child: _loading
                  ? const Center(child: CircularProgressIndicator())
                  : Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: _searchCtrl,
                    decoration: InputDecoration(
                      hintText:
                      AppLocalizations.of(context)!.searchCountries,
                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(12),
                        child: SvgPicture.asset(
                          'assets/icons/search.svg',
                          width: 20,
                          height: 20,
                          color: AppColors.primary,
                        ),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onChanged: (val) {
                      final q = val.toLowerCase();
                      setModal(() {
                        _filtered = _countries.where((c) {
                          return c.title.toLowerCase().contains(q) ||
                              c.countryCode
                                  .toLowerCase()
                                  .contains(q) ||
                              (c.dialCode ?? '')
                                  .toLowerCase()
                                  .contains(q);
                        }).toList();
                      });
                    },
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    height: 400,
                    child: _filtered.isEmpty
                        ? Center(
                      child: Text(
                        AppLocalizations.of(context)!
                            .noResultsFound,
                      ),
                    )
                        : ListView.builder(
                      itemCount: _filtered.length,
                      itemBuilder: (_, i) {
                        final country = _filtered[i];
                        return ListTile(
                          title: Text(
                            '${country.title} (${country.countryCode})',
                          ),
                          onTap: () {
                            widget.onCountryChanged(country);
                            Navigator.pop(context);
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

  @override
  Widget build(BuildContext context) {
    final sel = widget.selectedCountry;

    return InputField(
      label: widget.label,
      hintText: widget.hintText,
      controller: widget.controller,
      keyboardType: TextInputType.phone,
      validator: widget.validator,
      fillColor: widget.fillColor,
      borderColor: widget.borderColor,
      autovalidateMode: widget.autovalidateMode,
      prefixIcon: GestureDetector(
        onTap: _showPicker,
        child: Container(
          margin: const EdgeInsets.only(left: 8),
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (_loading)
                const SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              else if (sel != null)
                Text(
                  sel.countryCode,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
              const Icon(Icons.arrow_drop_down),
            ],
          ),
        ),
      ),
    );
  }
}
