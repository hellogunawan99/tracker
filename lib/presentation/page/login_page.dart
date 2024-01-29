import 'package:d_info/d_info.dart';
// import 'package:d_info/d_info.dart';
import 'package:d_input/d_input.dart';
import 'package:d_method/d_method.dart';
import 'package:d_view/d_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tracker/presentation/controller/c_user.dart';
import '../../data/source/source_user.dart';
import 'dashboard_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final controllerusername = TextEditingController();
  final controllerPassword = TextEditingController();
  final cUser = Get.put(CUser());

  void login() async {
    bool success = await SourceUser.login(
      controllerusername.text,
      controllerPassword.text,
    );
    if (success) {
      DInfo.dialogSuccess('Login Success');
      DInfo.closeDialog(actionAfterClose: () {
        DMethod.printTitle('Level User', cUser.data.level ?? '');
        if (cUser.data.level == 'Employee' &&
            controllerPassword.text == '80005607') {
          changePassword();
        } else {
          Get.off(() => const DashboardPage());
        }
      });
    } else {
      DInfo.dialogError('Login failed');
      DInfo.closeDialog();
    }
  }

  changePassword() async {
    final controller = TextEditingController();
    bool yes = await Get.dialog(
      AlertDialog(
        title: const Text('Have to Change Password'),
        content: DInput(
          controller: controller,
          title: 'New Password',
          hint: 'nahgsy87',
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(result: false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Get.back(result: true),
            child: const Text('Change'),
          ),
        ],
      ),
      barrierDismissible: false,
    );
    if (yes) {
      bool success = await SourceUser.changePassword(
        cUser.data.idUser.toString(),
        controller.text,
      );
      if (success) {
        DInfo.dialogSuccess('Change Password Success');
        DInfo.closeDialog(actionAfterClose: () {
          Get.off(() => const DashboardPage());
        });
      } else {
        DInfo.dialogError('Change Password Failed');
        DInfo.closeDialog();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: LayoutBuilder(builder: (context, boxConstraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: boxConstraints.maxHeight,
              ),
              child: SizedBox(
                height: 10,
                width: 300,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        DView.spaceHeight(
                          MediaQuery.of(context).size.height * 0.15,
                        ),
                        Text(
                          'Inventory\nMDD',
                          style: Theme.of(context)
                              .textTheme
                              .displaySmall!
                              .copyWith(
                                color: Colors.black,
                              ),
                        ),
                        DView.spaceHeight(8),
                        Container(
                          height: 6,
                          width: 160,
                          decoration: BoxDecoration(
                            color: Colors.lightBlue,
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        DView.spaceHeight(
                          MediaQuery.of(context).size.height * 0.15,
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        input(controllerusername, Icons.person_4, 'username'),
                        DView.spaceHeight(),
                        input(controllerPassword, Icons.lock_open, 'Password',
                            true),
                        DView.spaceHeight(),
                        SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: ElevatedButton(
                            onPressed: () => login(),
                            child: const Text(
                              'LOGIN',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                        DView.spaceHeight(
                          MediaQuery.of(context).size.height * 0.15,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget input(
    TextEditingController controller,
    IconData icon,
    String hint, [
    bool obsecure = false,
  ]) {
    return TextField(
      style: const TextStyle(color: Colors.black87),
      controller: controller,
      decoration: InputDecoration(
        fillColor: Colors.blue[100],
        filled: true,
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(6),
        ),
        prefixIcon: Icon(icon, color: Colors.lightBlue[300]),
        hintText: hint,
      ),
      obscureText: obsecure,
    );
  }
}
