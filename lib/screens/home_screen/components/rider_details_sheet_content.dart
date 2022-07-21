import 'package:flutter/material.dart';
import 'package:travel_app_user/utils/color_palette.dart';
import 'package:travel_app_user/utils/custom_styles.dart';
import 'package:travel_app_user/utils/custom_validations.dart';
import 'package:travel_app_user/utils/size_config.dart';
import 'package:travel_app_user/widgets/custom_buttons.dart';
import 'package:travel_app_user/widgets/custom_textFields.dart';

class RiderDetailsSheetContent extends StatefulWidget {
  const RiderDetailsSheetContent({Key? key}) : super(key: key);

  @override
  State<RiderDetailsSheetContent> createState() => _RiderDetailsSheetContentState();
}

class _RiderDetailsSheetContentState extends State<RiderDetailsSheetContent> {
  final _formKey = GlobalKey<FormState>();

  void _submit() {
    final form = _formKey.currentState;

    if (form!.validate()) {
      form.save();
      Navigator.of(context).pop(true);
    } else {
      // print("CheckBox Submit ");
      //  errorSnack(context, "Please Select the CheckBox");

    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: SizeConfig.fullHeight / 1.3,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Rider Details",
                    style: CustomStyleClass.onboardingBoyTextStyle.copyWith(
                        color: ColorPalette.black, fontWeight: FontWeight.bold),
                  ),
                  InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const ImageIcon(AssetImage("images/close_ic.png")))
                ],
              ),
              SizedBox(
                height: SizeConfig.heightMultiplier * 30,
              ),
              CustomTextField(
                  labelText: "Age",
                  hintText: "Age",
                  valueText: "",
                  validator: CustomValidationClass.nameValidator,
                  fieldType: FieldType.number),
              SizedBox(
                height: SizeConfig.heightMultiplier * 30,
              ),
              CustomTextField(
                  labelText: "Medical Conditions",
                  hintText: "Medical Conditions",
                  valueText: "",
                  validator: CustomValidationClass.nameValidator,
                  fieldType: FieldType.name),
              SizedBox(
                height: SizeConfig.heightMultiplier * 30,
              ),
              CustomTextField(
                  labelText: "Special Notes",
                  hintText: "Special Notes",
                  valueText: "",
                  fieldType: FieldType.message),
              Expanded(
                child: SizedBox(
                  height: SizeConfig.heightMultiplier * 80,
                ),
              ),
              CustomButtonsClass.blackButton(
                height: 72,
                onPressed: _submit,
                rightMargin: 0,
                leftMargin: 0,
                title: 'SEARCH',
                titleStyle: CustomStyleClass.onboardingSkipButtonStyle,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
