import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:travel_app_user/screens/otp_verification_screen.dart';
import 'package:travel_app_user/utils/custom_styles.dart';
import 'package:travel_app_user/utils/custom_validations.dart';
import 'package:travel_app_user/utils/size_config.dart';
import 'package:travel_app_user/widgets/custom_buttons.dart';
import 'package:travel_app_user/widgets/custom_textFields.dart';

class ForgotPasswordScreen extends StatefulWidget {
  static const String id = 'forgotPassword-screen';
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  String? mobile;
  final _formKey = GlobalKey<FormState>();
  GlobalKey<ScaffoldState>? globalKey;

  void _submit() {
    final form = _formKey.currentState;

    if (form!.validate()) {
      form.save();
      EasyLoading.show(status: "Sending OTP ...");
      Future.delayed(const Duration(milliseconds: 2000), () {
        EasyLoading.showSuccess("OTP Sent Successfully.",
           );
        Navigator.pushNamed(context, OtpVerificationScreen.id);
      });
    } else {
     /// print("CheckBox Submit ");
      //  errorSnack(context, "Please Select the CheckBox");

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: globalKey,
      appBar: AppBar(
        title: const Text("Forgot Password"),
        elevation: 0,
      ),
      body: _body(),
    );
  }

  Widget _body() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            SizedBox(
              height: SizeConfig.heightMultiplier * 20,
            ),
            Text(
                "Enter your Mobile Number we will send OTP on your mobile number",
                style: CustomStyleClass.onboardingBoyTextStyle),
            SizedBox(
              height: SizeConfig.heightMultiplier * 50,
            ),
            CustomTextField(
                labelText: "Mobile Number",
                hintText: "Enter Mobile Number",
                valueText: mobile,
                validator: CustomValidationClass.phoneValidator,
                fieldType: FieldType.mobile),
            SizedBox(
              height: SizeConfig.heightMultiplier * 70,
            ),
            CustomButtonsClass.blackButton(
              leftMargin: 0,
              rightMargin: 0,
              height: 72,
              title: "SEND OTP",
              titleStyle: CustomStyleClass.onboardingSkipButtonStyle,
              onPressed: _submit,
            )
          ],
        ),
      ),
    );
  }
}
