


// class GroupScreen extends StatefulWidget {
//   const GroupScreen({super.key});

//   @override
//   _GroupScreenState createState() => _GroupScreenState();
// }

// class _GroupScreenState extends State<GroupScreen>
//     with SingleTickerProviderStateMixin {
//   late TabController _tabController;
//   List<Group> allGroups = [
//     Group(
//       title: 'Striving as a single parent',
//       description:
//           'Being a single parent isn’t an easy task but still there is enough love to go around for everyone.',
//       members: [
//         Member(profileImageUrl: 'https://example.com/image1.jpg'),
//         Member(profileImageUrl: 'https://example.com/image2.jpg'),
//         // Add more members
//       ],
//     ),
//     // Add more groups
//   ];
//   List<Group> newRooms = [];
//   List<Group> freeRooms = [];
//   List<Group> premiumRooms = [];

//   @override
//   void initState() {
//     super.initState();
//     _tabController = TabController(length: 4, vsync: this);
//     _tabController.addListener(() {
//       setState(() {});
//     });
//   }

//   @override
//   void dispose() {
//     _tabController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: Column(
//           children: [
//             const TopBar(),
//             CategoryTabs(tabController: _tabController),
//             Expanded(
//               child: TabBarView(
//                 controller: _tabController,
//                 children: [
//                   GroupList(groups: allGroups),
//                   GroupList(groups: newRooms),
//                   GroupList(groups: freeRooms),
//                   GroupList(groups: premiumRooms),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class TopBar extends StatelessWidget {
//   const TopBar({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.symmetric(horizontal: 16.0.w),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Image.asset('assets/images/logo.png',
//               height: 40), // Update the path to your logo
//           IconButton(
//             icon: const Icon(Icons.search),
//             onPressed: () {
//               // Handle search action
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }

// class CategoryTabs extends StatelessWidget {
//   final TabController tabController;

//   const CategoryTabs({super.key, required this.tabController});

//   @override
//   Widget build(BuildContext context) {
//     final tabs = ["All", "New Rooms", "Free Rooms", "For Premium Users"];
//     return Padding(
//       padding: EdgeInsets.symmetric(vertical: 8.0.w),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceAround,
//         children: List.generate(tabs.length, (index) {
//           final isSelected = tabController.index == index;
//           return ChoiceChip(
//             label: Text(tabs[index]),
//             selected: isSelected,
//             onSelected: (selected) {
//               tabController.animateTo(index);
//             },
//             backgroundColor: Colors.grey.shade300,
//             selectedColor: Theme.of(context).primaryColor,
//             labelStyle: TextStyle(
//               color: isSelected ? Colors.white : Colors.black,
//             ),
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(20),
//             ),
//           );
//         }),
//       ),
//     );
//   }
// }

// class GroupList extends StatelessWidget {
//   final List<Group> groups;

//   const GroupList({super.key, required this.groups});

//   @override
//   Widget build(BuildContext context) {
//     return ListView.builder(
//       shrinkWrap: true,
//       physics: const NeverScrollableScrollPhysics(),
//       itemCount: groups.length,
//       itemBuilder: (context, index) {
//         final group = groups[index];
//         return GroupCard(group: group);
//       },
//     );
//   }
// }

// class GroupCard extends StatelessWidget {
//   final Group group;

//   const GroupCard({super.key, required this.group});

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.symmetric(vertical: 8.0.w),
//       child: Card(
//         child: Padding(
//           padding: EdgeInsets.all(16.0.w),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 group.title,
//                 style: const TextStyle(fontWeight: FontWeight.bold),
//               ),
//               SizedBox(height: 8.0.h),
//               Text(group.description),
//               SizedBox(height: 8.0.h),
//               Row(
//                 children: [
//                   Stack(
//                     children: group.members.map((member) {
//                       return Padding(
//                         padding: EdgeInsets.only(
//                             left: group.members.indexOf(member) * 20.0),
//                         child: CircleAvatar(
//                           backgroundImage: NetworkImage(member.profileImageUrl),
//                         ),
//                       );
//                     }).toList(),
//                   ),
//                   SizedBox(width: 8.0.h),
//                   Text('${group.members.length}'),
//                 ],
//               ),
//               SizedBox(height: 8.0.h),
//               ElevatedButton(
//                 onPressed: () {
//                   // Handle join conversation
//                 },
//                 child: Text('Join Conversation'),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// class Group {
//   final String title;
//   final String description;
//   final List<Member> members;

//   Group({
//     required this.title,
//     required this.description,
//     required this.members,
//   });
// }

// class Member {
//   final String profileImageUrl;

//   Member({required this.profileImageUrl});
// }
