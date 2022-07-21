import 'package:flutter/material.dart';
import 'package:travel_app_user/screens/my_profile.dart';
import 'package:travel_app_user/screens/peyment_method_screen.dart';
import 'package:travel_app_user/utils/color_palette.dart';
import 'package:travel_app_user/utils/custom_styles.dart';
import 'package:travel_app_user/widgets/navigationWidget/navigation_bar.dart';

class SettingsScreen extends StatefulWidget {
  static const String id = 'settings-screen';
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  bool _value = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      drawer: const CustomNavigationBar(),
      appBar: AppBar(
        title: const Text("Settings"),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () => scaffoldKey.currentState!.openDrawer(),
        ),
      ),
      body: body(),
    );
  }

  Widget body() {
    return ListView(
      children: [
        ListTile(
          title: Text(
            "Notifications",
            style: CustomStyleClass.onboardingBoyTextStyle
                .copyWith(color: ColorPalette.black),
          ),
          trailing: Switch.adaptive(
            activeColor: Colors.yellow,
            value: _value,
            onChanged: (newValue) => setState(() => _value = newValue),
          ),
        ),
        const Divider(
          thickness: 1,
        ),
        ListTile(
            onTap: () {
              Navigator.pushNamed(context, MyProfileScreen.id);
            },
            title: Text(
              "My Profile",
              style: CustomStyleClass.onboardingBoyTextStyle
                  .copyWith(color: ColorPalette.black),
            ),
            trailing: const Icon(Icons.arrow_forward_ios)),
        const Divider(
          thickness: 1,
        ),
        ListTile(
            onTap: () {
              Navigator.pushNamed(context, PaymentMethodScreen.id);
            },
            title: Text(
              "Payment Method",
              style: CustomStyleClass.onboardingBoyTextStyle
                  .copyWith(color: ColorPalette.black),
            ),
            trailing: const Icon(Icons.arrow_forward_ios)),
        const Divider(
          thickness: 1,
        ),
      ],
    );
  }
}
