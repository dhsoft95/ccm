import 'package:carousel_slider/carousel_slider.dart';
import 'package:ccm/Screens/Tabs/proEdit.dart';
import 'package:flutter/material.dart';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:iconly/iconly.dart';
import 'package:ionicons/ionicons.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../Pages/contacts.dart';
import 'messages.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int _currentIndex = 0;
  final List<String> images = [
    'assets/samia.jpg',
    'assets/samia.jpg',
    'assets/CCM-4-1536x1046-1.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: const Color(0xff18423e),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xff009b65), Color(0xff1d2f36)],
          ),
        ),
        child: Column(
          children: <Widget>[
            Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height *
                  0.3, // 30% of the screen height
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    const Color(0xfffcea97),
                    const Color(0xff1d2f36).withOpacity(0.4)
                  ],
                ),
                borderRadius: const BorderRadius.only(
                  bottomRight: Radius.circular(30.0),
                  bottomLeft: Radius.circular(30.0),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.all(MediaQuery.of(context).size.width *
                    0.04), // 4% of the screen width
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                              top: MediaQuery.of(context).size.height *
                                  0.018), // 1.8% of the screen height
                          child: IconButton(
                            icon: Icon(
                              Icons.arrow_back,
                              color: const Color(0xff0f674f),
                              size: MediaQuery.of(context).size.width *
                                  0.04, // 4% of the screen width
                            ),
                            onPressed: () {
                              // Handle back button press
                            },
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              top: MediaQuery.of(context).size.height *
                                  0.025), // 2.5% of the screen height
                          child: IconButton(
                            icon: Icon(
                              Icons.exit_to_app,
                              color: const Color(0xff0f674f),
                              size: MediaQuery.of(context).size.width *
                                  0.05, // 5% of the screen width
                            ),
                            onPressed: () {
                              // Handle logout button press
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                        height: MediaQuery.of(context).size.height *
                            0.016), // 1.6% of the screen height
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Welcome,',
                              style: TextStyle(
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.056,
                                // 5.6% of the screen width
                                color: const Color(0xff0f674f),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              'David John!,',
                              style: TextStyle(
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.056,
                                // 5.6% of the screen width
                                color: const Color(0xff0f674f),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                                height: MediaQuery.of(context).size.height *
                                    0.008), // 0.8% of the screen height
                            Text(
                              'Aug 29, 2023',
                              style: TextStyle(
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.032,
                                // 3.2% of the screen width
                                color: const Color(0xff0f674f),
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                            Container(
                              height: 2,
                              // Reduced the height to make it a thinner line
                              color: Colors.black,
                              margin: EdgeInsets.symmetric(
                                  vertical: MediaQuery.of(context).size.height *
                                      0.01), // 1% of the screen height
                            ),
                            SizedBox(
                                height: MediaQuery.of(context).size.height *
                                    0.015), // 1.5% of the screen height
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  'Total',
                                  style: TextStyle(
                                    fontSize:
                                        MediaQuery.of(context).size.width *
                                            0.04,
                                    // 4% of the screen width
                                    color: const Color(0xff0f674f),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  ' 3000',
                                  style: TextStyle(
                                    fontSize:
                                        MediaQuery.of(context).size.width *
                                            0.04,
                                    // 4% of the screen width
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                            width: MediaQuery.of(context).size.width *
                                0.01), // 2% of the screen width
                        CircleAvatar(
                          radius: MediaQuery.of(context).size.width *
                              0.1, // 10% of the screen width
                          backgroundColor: const Color(0xff0f674f),
                          child: CircleAvatar(
                            radius: MediaQuery.of(context).size.width *
                                0.096, // 9.6% of the screen width
                            backgroundImage:
                                const AssetImage('assets/dhsoft.jpg'),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
                height: MediaQuery.of(context).size.height *
                    0.02), // 2% of the screen height
            Padding(
              padding: const EdgeInsets.only(
                left: 22.0,
                right: 22.0,
              ),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                  gradient: const LinearGradient(
                    colors: [Color(0xfffcea97), Color(0xfffcea97)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 6.0,
                      offset: const Offset(0, 1),
                    ),
                  ],
                ),
                height: 110,
                child: Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: () {
                          // Action to perform when the first icon is clicked
                          // Add your desired functionality here
                        },
                        child: CustomCardTwo(
                          colors: [Color(0xff0f674f), Color(0xff0f674f)],
                          icon: Ionicons.at_outline,
                          title: 'All Members',
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          // Action to perform when the second icon is clicked
                          // Add your desired functionality here
                        },
                        child: CustomCardTwo(
                          colors: [Color(0xff0f674f), Color(0xff0f674f)],
                          icon: Symbols.sms_sharp,
                          title: 'Topup SMS',
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => ContactPickerDemo()));
                        },
                        child: CustomCardTwo(
                          colors: [Color(0xff0f674f), Color(0xff0f674f)],
                          icon: Icons.add,
                          title: 'Add Member',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 19.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                  gradient: const LinearGradient(
                    colors: [Color(0xfffcea97), Color(0xfffcea97)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 6.0,
                      offset: const Offset(0, 1),
                    ),
                  ],
                ),
                height: 110,
                child: const Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        CustomCard(
                            title: 'Success',
                            colors: [Color(0xff0f674f), Color(0xff0f674f)],
                            icon: Icons.check_circle_outline,
                            badgeCount: 10),
                        CustomCard(
                            title: 'Pending',
                            colors: [Color(0xff0f674f), Color(0xff0f674f)],
                            icon: Icons.access_time,
                            badgeCount: 5),
                        CustomCard(
                            title: 'Failed',
                            colors: [Color(0xff0f674f), Color(0xff0f674f)],
                            icon: Icons.error_outline,
                            badgeCount: 2),
                      ]),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 6.0,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: RecentItemTile(
                title: 'Recent Item 2',
                subtitle: 'Description of Recent Item 2',
                icon: Icons.access_time,
                onPressed: () {
                  // Handle the tap action for this item
                },
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 6.0,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: CarouselSlider(
                options: CarouselOptions(
                  height: MediaQuery.of(context).size.height * 0.09,
                  // 18% of the screen height
                  enlargeCenterPage: true,
                  autoPlay: true,
                  aspectRatio: 16 / 9,
                  autoPlayCurve: Curves.decelerate,
                  enableInfiniteScroll: true,
                  autoPlayAnimationDuration: const Duration(milliseconds: 800),
                  viewportFraction: 0.8,
                ),
                items: images.map((imagePath) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Container(
                        width: MediaQuery.of(context).size.width,
                        margin: const EdgeInsets.symmetric(horizontal: 5.0),
                        decoration: BoxDecoration(
                          color: Colors.amber,
                          borderRadius: BorderRadius.circular(8.0),
                          image: DecorationImage(
                            image: AssetImage(imagePath),
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    },
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Builder(
        builder: (context) => FloatingActionButton(
          shape: const CircleBorder(),
          onPressed: () {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const Messages()));
          },
          backgroundColor: const Color(0xff0f674f),
          child:
              const Icon(IconlyBold.send, size: 28, color: Color(0xfffcea97)),
        ),
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterDocked,
      bottomNavigationBar: AnimatedBottomNavigationBar(
        icons: const [Icons.home, Symbols.user_attributes_rounded],
        activeIndex: _currentIndex,
        gapLocation: GapLocation.none,
        inactiveColor: const Color(0xff009b65),
        backgroundColor: const Color(0xfffcea97),
        notchSmoothness: NotchSmoothness.defaultEdge,
        leftCornerRadius: 18,
        rightCornerRadius: 18,
        onTap: (index) {
          setState(() => _currentIndex = index);

          // Handle navigation based on the index
          if (index == 1) {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const ProfileScreen()));
          }
        },
      ),
    );
  }
}

class DashboardCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final List<Color> gradientColors;

  const DashboardCard({
    super.key,
    required this.title,
    required this.icon,
    required this.gradientColors,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: InkResponse(
        onTap: () {
          // Handle card tap
        },
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: gradientColors,
            ),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Icon(
                  icon,
                  size: 48,
                  color: Colors.white,
                ),
                const SizedBox(height: 12),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CustomCard extends StatelessWidget {
  final String title;
  final List<Color> colors;
  final IconData icon;
  final int badgeCount;

  const CustomCard(
      {super.key,
      required this.title,
      required this.colors,
      required this.icon,
      required this.badgeCount});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: colors,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: const Color(0xfffcea97),
            size: 30,
          ),
          const SizedBox(height: 8),
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 10,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              color: const Color(0xfffcea97),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              badgeCount.toString(),
              style: TextStyle(
                color: colors.last,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CustomCardTwo extends StatelessWidget {
  final List<Color> colors;
  final IconData icon;
  final String title;

  const CustomCardTwo(
      {super.key,
      required this.colors,
      required this.icon,
      required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: colors,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: const Color(0xfffcea97),
            size: 30,
          ),
          const SizedBox(height: 8),
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 10,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

class RecentItemList extends StatelessWidget {
  final List<Map<String, dynamic>> recentItems;

  const RecentItemList({super.key, required this.recentItems});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: recentItems.length,
      itemBuilder: (context, index) {
        return RecentItemTile(
          title: recentItems[index]['title'],
          subtitle: recentItems[index]['subtitle'],
          icon: recentItems[index]['icon'],
          onPressed: () {
            // Handle the tap action for this item
          },
        );
      },
    );
  }
}

class RecentItemTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final VoidCallback onPressed;

  const RecentItemTile({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(10),
        decoration: const BoxDecoration(
          color: Colors.blue,
          shape: BoxShape.circle,
        ),
        child: Icon(
          icon,
          color: Colors.white,
          size: 30,
        ),
      ),
      title: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: TextStyle(color: Colors.white.withOpacity(0.7)),
      ),
      onTap: onPressed,
    );
  }
}
