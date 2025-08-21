import 'package:flutter/material.dart';
import 'package:country_picker/country_picker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ofwhich_v2/presentation/core/font.dart';

class CountryStatePickerModal extends StatefulWidget {
  final Function(String country, String? state) onSelected;

  const CountryStatePickerModal({Key? key, required this.onSelected})
      : super(key: key);

  @override
  State<CountryStatePickerModal> createState() =>
      _CountryStatePickerModalState();
}

class _CountryStatePickerModalState extends State<CountryStatePickerModal> {
  String? selectedCountry;
  String? selectedState;

  List<String> states = []; // States for the chosen country

  void pickCountry() {
    showCountryPicker(
      context: context,
      showPhoneCode: false,
      onSelect: (Country country) {
        setState(() {
          selectedCountry = country.name;
          selectedState = null; // reset state
          states = getStatesForCountry(country.name); // you define this
        });
      },
    );
  }

  void pickState() {
    if (states.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please select a country first")),
      );
      return;
    }

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (_) {
        return ListView(
          children: states
              .map(
                (state) => ListTile(
                  title: Text(state),
                  onTap: () {
                    setState(() {
                      selectedState = state;
                    });
                    Navigator.pop(context);
                  },
                ),
              )
              .toList(),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.5,
      minChildSize: 0.4,
      maxChildSize: 0.9,
      builder: (context, scrollController) {
        return Container(
          padding: const EdgeInsets.all(16),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
          ),
          child: ListView(
            controller: scrollController,
            children: [
              Text(
                "Select a location",
                style: TextStyle(fontSize: 26.sp, fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 8.h),
              Text(
                "Select countries and state you’d like for your date",
                style: TextStyle(color: Colors.black, fontSize: 16.sp),
              ),
              SizedBox(height: 20.h),

              Text(
                "Country*",
                style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400,
                    fontFamily: Font.inter),
              ),
              SizedBox(height: 10.h),
              // Country Dropdown-like Button
              _buildDropdownButton(
                label: selectedCountry ?? "",
                onPressed: pickCountry,
              ),
              SizedBox(height: 12.h),

              Text(
                "City*",
                style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400,
                    fontFamily: Font.inter),
              ),
              SizedBox(height: 10.h),
              // State Dropdown-like Button
              _buildDropdownButton(
                label: selectedState ?? "",
                onPressed: pickState,
              ),
              const SizedBox(height: 24),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromRGBO(236, 88, 115, 1),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () {
                    if (selectedCountry != null) {
                      widget.onSelected(selectedCountry!, selectedState);
                      Navigator.pop(context);
                    }
                  },
                  child: const Text(
                    "Set Location",
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  /// Dropdown-like button widget
  Widget _buildDropdownButton({
    required String label,
    required VoidCallback onPressed,
  }) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
        side: BorderSide(color: Colors.grey.shade400),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        backgroundColor: Colors.white,
      ),
      onPressed: onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label,
              style: const TextStyle(color: Colors.black, fontSize: 16)),
          const Icon(Icons.arrow_drop_down, color: Colors.grey),
        ],
      ),
    );
  }

  /// Replace with your own map of states for countries
  List<String> getStatesForCountry(String country) {
    if (country == "Nigeria") {
      return [
        "Lagos",
        "Abuja",
        "Kano",
        "Rivers",
        "Oyo",
      ];
    }
    if (country == "United States") {
      return [
        "California",
        "Texas",
        "New York",
        "Florida",
      ];
    }
    if (country == "United Kingdom") {
      return [
        "London",
        "Manchester",
        "Birmingham",
        "Liverpool",
      ];
    }
    return [];
  }
}
