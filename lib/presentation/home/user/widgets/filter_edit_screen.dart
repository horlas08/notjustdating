import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:ofwhich_v2/presentation/core/font.dart';
import 'package:ofwhich_v2/presentation/home/user/widgets/double_sided_slider.dart';

class FilterEditScreen extends StatelessWidget {
  const FilterEditScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> cities = [
      "London",
      "Watford",
      "Brighton",
      "Heathrow",
      "Milton Kenynes",
      "Cambridge",
      "Southanpton",
      "Northampton",
      "Oxford",
    ];
    final List<String> availableLanguages = [
            "English",
            "Dutch",
            "French",
            "German",
          ];

    return Scaffold(
      backgroundColor: const Color.fromRGBO(245, 245, 245, 1),
      body: SingleChildScrollView(
        child: SizedBox(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 60.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Narrow your search",
                        style: TextStyle(
                            fontFamily: Font.inter,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w500)),

                            InkWell(
                              onTap: (){
                                Navigator.pop(context);
                              },
                              child: Container(
                                height: 41.h,
                                width: 41.w,
                                decoration: BoxDecoration( color:  Colors.black.withOpacity(0.05),borderRadius: BorderRadius.all(Radius.circular(20.r))),
                               
                                child: Image.asset("assets/images/pngs/x.png", height: 20.h,width: 20.w,),
                              ),
                            )
                  ],
                ),
                SizedBox(
                  height: 50.h,
                ),
                Text(
                  "Which gender are you looking for?",
                  style: TextStyle(
                      fontSize: 18.sp,
                      fontFamily: Font.inter,
                      fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  height: 19.h,
                ),
                GenderSelectionWidget(
                  onChanged: (val) {},
                ),
                SizedBox(
                  height: 35.h,
                ),
                
                _distanaceWidget(),
                SizedBox(height: 19.h,),
                _cityChipTiles(cities, true),
                SizedBox(height: 35.h,),
                _prefAgeWidget(),
                SizedBox(height: 35.h,),
                 Text(
                  "Preferred height range",
                  style: TextStyle(
                      fontSize: 18.sp,
                      fontFamily: Font.inter,
                      fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  height: 19.h,
                ),
                HeigthSelectionWidget(
                  onChanged: (val) {},
                ),
                 SizedBox(height: 35.h,),
                 Text(
                  "Language",
                  style: TextStyle(
                      fontSize: 18.sp,
                      fontFamily: Font.inter,
                      fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  height: 19.h,
                ),
               LanguageCheckbox(availableLanguages: availableLanguages, onSelectionChanged: (list){}),
                SizedBox(height: 35.h,),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class GenderSelectionWidget extends StatefulWidget {
  final Function(String) onChanged;

  const GenderSelectionWidget({Key? key, required this.onChanged})
      : super(key: key);

  @override
  _GenderSelectionWidgetState createState() => _GenderSelectionWidgetState();
}

class _GenderSelectionWidgetState extends State<GenderSelectionWidget> {
  String _selectedGender = 'male';

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(15.r))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // const Text("Select Gender"),
          RadioListTile<String>(
            title: const Text("Male"),
            value: 'male',
            groupValue: _selectedGender,
            onChanged: (value) {
              setState(() => _selectedGender = value!);
              widget.onChanged(value!);
            },
            controlAffinity: ListTileControlAffinity.trailing,
          ),
          RadioListTile<String>(
            title: const Text("Female"),
            value: 'female',
            groupValue: _selectedGender,
            onChanged: (value) {
              setState(() => _selectedGender = value!);
              widget.onChanged(value!);
            },
            controlAffinity: ListTileControlAffinity.trailing,
          ),
          RadioListTile<String>(
            title: const Text("Gender nonconformaring folks"),
            value: 'Gender nonconformaring folks',
            groupValue: _selectedGender,
            onChanged: (value) {
              setState(() => _selectedGender = value!);
              widget.onChanged(value!);
            },
            controlAffinity: ListTileControlAffinity.trailing,
          ),
        ],
      ),
    );
  }
}

Widget _distanaceWidget() {
  return SizedBox(
    child: Column(
       crossAxisAlignment: CrossAxisAlignment.start,
         
      children: [
        Text(
                  "Location",
                  style: TextStyle(
                      fontSize: 18.sp,
                      fontFamily: Font.inter,
                      fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  height: 19.h,
                ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 19.h),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(15.r))),
          child: Column(
             crossAxisAlignment: CrossAxisAlignment.start,
         
              children: [
              
              Text(
                "Up to 4 miles away",
                style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400,
                    fontFamily: Font.inter),
              ),
              CustomRangeSlider(
                division: 10,
                minValue: 0,
                maxValue: 100,
                startValue: (
                        // parentModel.filterDataModel?.radiusStart ??
                        0)
                    .toDouble(),
                endValue: (
                        //  parentModel.filterDataModel?.radiusEnd ??
                        80)
                    .toDouble(),
                multiplierValue: 1,
                stepSize: 2, //
                // minValue: 0,
                // maxValue: 25,
                // startValue: 5.0,
                // endValue: 25.0,
                // multiplierValue: 5.0,
                // division: 5,
                onChange: (val) {
                  // setState(() {
                  //   distanceRange = val;
                  // });
                },
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _cityChipTiles(List<String> chipLabels, bool selected) {
  return SizedBox(
    width: double.infinity,
   // color: Colors.amber,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Choose Cities",style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
              fontFamily: Font.inter),
        ),
        SizedBox(height: 19.h,),
        Wrap(
          
          alignment:WrapAlignment.start ,
         
          
          spacing: 8.w,
          runSpacing: 8.h,
          children: chipLabels.map((label) {
            //bool selected = controller.isSelected(label);
            return GestureDetector(
              onTap: () {
                selected = !selected;
              },
              child: Container(
                height: 44.h,
                padding: EdgeInsets.symmetric(horizontal: 13.w, vertical: 13.h),
                decoration: BoxDecoration(
                  color: selected ? const Color.fromRGBO(152, 28, 50, 1) : Colors.black.withOpacity(0.06),
                  // border: Border.all(
                  // //  color: Colors.redAccent,
                  // ),
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Text(
                  label,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400,
                    color: selected ? Colors.white : Colors.black,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    ),
  );
}

Widget _prefAgeWidget() {
  return  SizedBox(
    child: Column(
       crossAxisAlignment: CrossAxisAlignment.start,
         
      children: [
        Text(
                  "Preferred age range",
                  style: TextStyle(
                      fontSize: 18.sp,
                      fontFamily: Font.inter,
                      fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  height: 19.h,
                ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 19.h),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(15.r))),
          child: Column(
             crossAxisAlignment: CrossAxisAlignment.start,
         
              children: [
              
              Text(
                "Between 23 to 40",
                style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400,
                    fontFamily: Font.inter),
              ),
              CustomRangeSlider(
                isType1: false,
                division: 10,
                minValue: 0,
                maxValue: 100,
                startValue: (
                        // parentModel.filterDataModel?.radiusStart ??
                        0)
                    .toDouble(),
                endValue: (
                        //  parentModel.filterDataModel?.radiusEnd ??
                        80)
                    .toDouble(),
                multiplierValue: 1,
                stepSize: 2, //
                // minValue: 0,
                // maxValue: 25,
                // startValue: 5.0,
                // endValue: 25.0,
                // multiplierValue: 5.0,
                // division: 5,
                onChange: (val) {
                  // setState(() {
                  //   distanceRange = val;
                  // });
                },
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

class HeigthSelectionWidget extends StatefulWidget {
  final Function(String) onChanged;

  const HeigthSelectionWidget({Key? key, required this.onChanged})
      : super(key: key);

  @override
  _heigthSelectionWidgetState createState() => _heigthSelectionWidgetState();
}

class _heigthSelectionWidgetState extends State<HeigthSelectionWidget> {
  String _selectedGender = 'Don\'t care';

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(15.r))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // const Text("Select Gender"),
          RadioListTile<String>(
            title:  Text('Don\'t care',style: TextStyle(fontSize: 16.sp,fontFamily: Font.inter,fontWeight: FontWeight.w400)),
            value: 'Don\'t care',
            groupValue: _selectedGender,
            onChanged: (value) {
              setState(() => _selectedGender = value!);
              widget.onChanged(value!);
            },
            controlAffinity: ListTileControlAffinity.trailing,
          ),
          RadioListTile<String>(
            title:  Text("Do care",style: TextStyle(fontSize: 16.sp,fontFamily: Font.inter,fontWeight: FontWeight.w400)),
            value: 'Do care',
            groupValue: _selectedGender,
            onChanged: (value) {
              setState(() => _selectedGender = value!);
              widget.onChanged(value!);
            },
            controlAffinity: ListTileControlAffinity.trailing,
          ),
        
        ],
      ),
    );
  }
}


class LanguageCheckbox extends StatefulWidget {
  final List<String> availableLanguages;
  final Function(List<String>) onSelectionChanged;

  const LanguageCheckbox({
    Key? key,
    required this.availableLanguages,
    required this.onSelectionChanged,
  }) : super(key: key);

  @override
  _LanguageCheckboxState createState() => _LanguageCheckboxState();
}

class _LanguageCheckboxState extends State<LanguageCheckbox> {
  
  List<String> _selectedLanguages = [];

  void _onLanguageTapped(String language, bool? isSelected) {
    setState(() {
      if (isSelected == true) {
        _selectedLanguages.add(language);
      } else {
        _selectedLanguages.remove(language);
      }
    });

    widget.onSelectionChanged(_selectedLanguages);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: widget.availableLanguages.map((language) {
        return CheckboxListTile(
          //checkboxShape: const OutlinedBorder(side: BorderSide()),
          side: const BorderSide(color:  Color.fromRGBO(238, 88, 115, 1)),
          title: Text(language,style: TextStyle(fontSize: 16.sp,fontFamily: Font.inter,fontWeight: FontWeight.w400),),
          
          checkColor: const Color.fromRGBO(238, 88, 115, 1),
          activeColor: Colors.transparent,
          value: _selectedLanguages.contains(language),
          onChanged: (bool? value) {
            _onLanguageTapped(language, value);
          },
          controlAffinity: ListTileControlAffinity.leading,
        );
      }).toList(),
    );
  }
}
