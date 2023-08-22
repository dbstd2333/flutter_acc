import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/home_controller.dart';
import '../../index/views/index_view.dart';
import '../../filterlist/views/filterlist_view.dart';
import '../../user/views/user_view.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MyHomePage();
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int currentPageIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const <Widget>[
        IndexView(),
        FilterlistView(),
        UserView(),
      ][currentPageIndex],
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        selectedIndex: currentPageIndex,
        destinations: const <Widget>[
          NavigationDestination(
            selectedIcon: Icon(Icons.list_alt_rounded),
            icon: Icon(Icons.list_alt_outlined),
            label: '主页',
          ),
          NavigationDestination(
            icon: Icon(Icons.filter_list_outlined),
            selectedIcon: Icon(Icons.filter_list),
            label: '详情',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.person_2),
            icon: Icon(Icons.person_2_outlined),
            label: '用户',
          ),
        ],
      ),
    );
  }
}

class PageWidget extends StatelessWidget {
  final String title;

  PageWidget({required this.title});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(title, style: TextStyle(fontSize: 24)),
    );
  }
}
