import 'package:d_info/d_info.dart';
import 'package:d_view/d_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tracker/presentation/page/employee/employee_page.dart';
import 'package:tracker/presentation/page/login_page.dart';
import '../../config/session.dart';
import '../controller/c_dashboard.dart';
import 'product/product_page.dart';

import '../controller/c_user.dart';
import 'history/history_page.dart';
import 'inout/inout_page.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final cUser = Get.put(CUser());
  final cDashboard = Get.put(CDashboard());

  logout() async {
    bool? yes = await DInfo.dialogConfirmation(
      context,
      'Log out',
      'Yakin keluar?',
    );
    if (yes ?? false) {
      Session.clearUser();
      Get.off(() => const LoginPage());
    }
  }

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        actions: [
          IconButton(
            onPressed: () => logout(),
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: ListView(
        children: [
          profileCard(textTheme),
          const Padding(
            padding: EdgeInsets.all(16),
            // child: DView.textTitle('semua'),
            child: Text(
              'Menu',
              style: TextStyle(
                color: Colors.black,
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          GridView(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisExtent: 110,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
            ),
            children: [
              menuProduct(textTheme),
              menuHistory(textTheme),
              menuIn(textTheme),
              menuOut(textTheme),
              Obx(() {
                if (cUser.data.level == 'Admin') {
                  return menuEmployee(textTheme);
                } else {
                  return const SizedBox();
                }
              }),
            ],
          )
        ],
      ),
    );
  }

  Widget menuProduct(TextTheme textTheme) {
    return GestureDetector(
      onTap: () {
        Get.to(() => const ProductPage())
            ?.then((value) => cDashboard.setProduct());
      },
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.teal[100],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('💾',
                style: textTheme.titleLarge!.copyWith(
                  fontSize: 40,
                )),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Obx(() {
                  return Text(
                    cDashboard.product.toString(),
                    style: textTheme.headlineMedium!.copyWith(
                      color: Color.fromRGBO(40, 2, 116, 1),
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  );
                }),
                DView.spaceWidth(8),
                const Text(
                  'Item',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget menuHistory(TextTheme textTheme) {
    return GestureDetector(
      onTap: () {
        Get.to(() => const HistoryPage())
            ?.then((value) => cDashboard.setHistory());
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.blue[700],
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              '🎥',
              style: textTheme.titleLarge!.copyWith(
                color: Colors.white,
                fontSize: 25,
                fontWeight: FontWeight.w700,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Obx(() {
                  return Text(
                    cDashboard.history.toString(),
                    style: textTheme.headlineMedium!.copyWith(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  );
                }),
                DView.spaceWidth(8),
                const Text(
                  'Act',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget menuIn(TextTheme textTheme) {
    return GestureDetector(
      onTap: () {
        Get.to(() => const InOutPage(type: 'IN'))?.then((value) {
          cDashboard.setIn();
          cDashboard.setHistory();
        });
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.blue[700],
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('IN',
                style: textTheme.titleLarge!.copyWith(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.w700,
                )),
            Row(
              children: [
                Obx(() {
                  return Text(
                    cDashboard.ins.toString(),
                    style: textTheme.headlineMedium!.copyWith(
                      color: Colors.white,
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                    ),
                  );
                }),
                DView.spaceWidth(8),
                const Text(
                  'Item',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget menuOut(TextTheme textTheme) {
    return GestureDetector(
      onTap: () {
        Get.to(() => const InOutPage(type: 'OUT'))?.then((value) {
          cDashboard.setOut();
          cDashboard.setHistory();
        });
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.blue[700],
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('OUT',
                style: textTheme.titleLarge!.copyWith(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.w700,
                )),
            Row(
              children: [
                Obx(() {
                  return Text(
                    cDashboard.outs.toString(),
                    style: textTheme.headlineMedium!.copyWith(
                      color: Colors.white,
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                    ),
                  );
                }),
                DView.spaceWidth(8),
                const Text(
                  'Item',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget menuEmployee(TextTheme textTheme) {
    return GestureDetector(
      onTap: () {
        Get.to(() => const EmployeePage())?.then((value) {
          cDashboard.setEmployee();
        });
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.blue[700],
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Anggota',
              style: textTheme.titleLarge!.copyWith(
                color: Colors.white,
                fontSize: 25,
                fontWeight: FontWeight.w700,
              ),
            ),
            Obx(() {
              return Text(
                cDashboard.employee.toString(),
                style: textTheme.headlineMedium!.copyWith(
                  color: Colors.white,
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                ),
              );
            }),
          ],
        ),
      ),
    );
  }

  Container profileCard(TextTheme textTheme) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.lightBlue,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Obx(() {
            return Text(
              cUser.data.name ?? '',
              style: textTheme.titleMedium!.copyWith(
                  color: Colors.white,
                  fontSize: 23,
                  fontWeight: FontWeight.bold),
            );
          }),
          DView.spaceHeight(4),
          Obx(() {
            return Text(
              cUser.data.username ?? '',
              style: textTheme.bodyMedium!.copyWith(
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
            );
          }),
          DView.spaceHeight(8),
          Obx(() {
            return Text(
              '(${cUser.data.level})',
              style: textTheme.bodySmall,
            );
          }),
        ],
      ),
    );
  }
}
