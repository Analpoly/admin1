// import 'package:admin1/communitychat.dart';
// import 'package:admin1/contextpg.dart';
// import 'package:admin1/offerspg.dart';
// import 'package:flutter/material.dart';

// class Homepage extends StatelessWidget {
//   const Homepage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Home')),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             ElevatedButton(
//                 onPressed: () {
//                   Navigator.push(context,
//                       MaterialPageRoute(builder: (context) => OffersPage()));
//                 },
//                 child: Text("Offers")),
//             SizedBox(
//               height: 15,
//             ),
//             ElevatedButton(
//                 onPressed: () {
//                   Navigator.push(context,
//                       MaterialPageRoute(builder: (context) => Contextpg()));
//                 },
//                 child: Text("context")),
//             ElevatedButton(
//                 onPressed: () {
//                   Navigator.push(context,
//                       MaterialPageRoute(builder: (context) =>AdminChatScreen()));
//                 },
//                 child: Text('community chat'))
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:admin1/communitychat.dart';
import 'package:admin1/contextpg.dart';
import 'package:admin1/offerspg.dart';
import 'package:flutter/material.dart';

class  Homepage extends StatefulWidget {

  @override
  State< Homepage> createState() => _TabsState();
}

class _TabsState extends State< Homepage> with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TabBarView(
        controller: tabController,
        children: [Contextpg(), OffersPage(), AdminChatScreen()],
      ),
      bottomNavigationBar: TabBar(
        controller: tabController,
        tabs: [
          Tab(icon: Icon(Icons.home), text: 'HOME'),
          Tab(icon: Icon(Icons.local_offer), text: 'OFFERS'),
          Tab(icon: Icon(Icons.people), text: 'COMMUNITY'),
        ],
      ),
    );
  }
}
