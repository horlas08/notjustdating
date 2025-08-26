import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ofwhich_v2/presentation/general_widgets/custom_appbar.dart';
import 'package:touchable_opacity/touchable_opacity.dart';

final _supportMethod = [
  {
    'name': 'Customer Services',
    'content': 'contact us live chat',
    'open': false,
    'icon': 'assets/images/pngs/support/'
  },
  {
    'name': 'Whatsapp',
    'content': '',
    'open': false,
    'icon': 'assets/images/pngs/support/'
  },
  {
    'name': 'Website',
    'content': '',
    'open': false,
    'icon': 'assets/images/pngs/support/'
  },
  {
    'name': 'Facebook',
    'content': '',
    'open': false,
    'icon': 'assets/images/pngs/support/'
  },
  {
    'name': 'X',
    'content': '',
    'open': false,
    'icon': 'assets/images/pngs/support/'
  },
  {
    'name': 'Instagrm',
    'content': '',
    'open': false,
    'icon': 'assets/images/pngs/support/'
  },
];

@RoutePage()
class Support extends HookWidget {
  const Support({super.key});

  @override
  Widget build(BuildContext context) {
    final activeTab = useState<num>(0);
    final supportMethod = useState<List<Map<String, Object>>>(_supportMethod);
    return Scaffold(
      appBar: OfWhichAppBar(
        titleText: 'Support',
        backgroundColor: Colors.white,
      ),
      body: Column(
        children: [
          _searchBar(),
          SizedBox(
            height: 20,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: TouchableOpacity(
                  onTap: () {
                    activeTab.value = 0;
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: activeTab.value == 0
                            ? BorderSide(
                                color: Theme.of(context).primaryColor,
                                width: 2,
                              )
                            : BorderSide.none,
                      ),
                    ),
                    padding: EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 14,
                    ),
                    child: Text(
                      "FAQS",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: activeTab.value == 0
                            ? Theme.of(context).primaryColor
                            : Colors.black87,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: TouchableOpacity(
                  onTap: () {
                    activeTab.value = 1;
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: activeTab.value == 1
                            ? BorderSide(
                                color: Theme.of(context).primaryColor,
                                width: 2,
                              )
                            : BorderSide.none,
                      ),
                    ),
                    padding: EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 14,
                    ),
                    child: Text(
                      "Contact Us",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: activeTab.value == 1
                            ? Theme.of(context).primaryColor
                            : Colors.black87,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 25,
          ),
          if (activeTab.value == 0)
            ...List.generate(
              supportMethod.value.length,
              (index) {
                final item = supportMethod.value[index];
                return _SupportTile(
                  context: context,
                  title: item['name'] as String,
                  content: Text("data"),
                  icon: "${item['icon']}${index}.png",
                );
              },
            )
          else
            Column(
              children: [
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Text("All"),
                    )
                  ],
                )
              ],
            )
        ],
      ),
    );
  }
}

Widget _searchBar() {
  return Container(
    height: 60.h,
    padding: EdgeInsets.symmetric(horizontal: 14.w),
    decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(15.r)),
        border: Border.all(color: const Color.fromRGBO(215, 215, 215, 1))),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.search_outlined,
              size: 24.sp,
            )),
        Expanded(
            child: Text(
          "Search an article",
          style: TextStyle(
            fontSize: 16.sp,
          ),
        ))
      ],
    ),
  );
}

Widget _SupportTile(
    {required BuildContext context,
    required String title,
    required Widget content,
    required String icon,
    isOpen = false}) {
  return TouchableOpacity(
    onTap: () {},
    child: Container(
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(
          15,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Image.asset(icon),
              SizedBox(
                width: 10,
              ),
              Text(
                title,
              )
            ],
          ),
          Icon(
            isOpen
                ? Icons.keyboard_arrow_up_rounded
                : Icons.keyboard_arrow_down_rounded,
            color: Colors.black,
          ),
        ],
      ),
    ),
  );
}
