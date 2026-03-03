import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:good_job/common/colors.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../common/common_widgets.dart';
import '../../../../common/text_styles.dart';
import '../../../data/constants/image_constants.dart';
import '../../../data/constants/string_constants.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({Key? key}) : super(key: key);

  // Custom widget to style the country code picker to match the TextField aesthetics
  Widget countryCodeInput(BuildContext context) {
    return Container(
      // Ensure the height matches the commonTextFieldForLoginSignUP
      height: 60.px,
      width: 70.px,
      margin: EdgeInsets.only(right: 10.px),
      padding: EdgeInsets
          .zero, // Padding should be handled internally by the picker if possible
      decoration: BoxDecoration(
        // Matching the styling of the commonTextField (which often relies on 'isCard' for this look)
        borderRadius: BorderRadius.circular(15.px),
        color: Colors.white, // Assuming the text field background is white
        border: Border.all(
            color: Colors.black,
            width: 1.px), // Use a slight black border for definition
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 5.0,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: CommonWidgets.countryCodePicker(
        onChanged: (value) => controller.clickOnCountryCode(value: value),
        initialSelection: controller.countryDailCode.value,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Get the total screen height
    final screenHeight = MediaQuery.of(context).size.height;

    // Set the image height to 70% of the screen height
    final imageHeight = screenHeight * 0.70;

    // Set the remaining content height (30%)
    // We will use this space flexibly for padding and content.
    // We use a fixed height for the image area to ensure the 70/30 split logic works.

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Obx(() {
        controller.count.value;
        return SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // --- Logo/Image Section (70% Height) ---
                // We wrap the image in a SizedBox to enforce the 70% height constraint.
                SizedBox(
                  height: imageHeight,
                  width: double.infinity,
                  child: Center(
                    child: CommonWidgets.appIcons(
                      assetName: ImageConstants.imgSplash,
                      height: imageHeight *
                          0.8, // Use 80% of the 70% height for the image itself
                      width: MediaQuery.of(context).size.width * 0.7,
                    ),
                  ),
                ),

                // --- Input/Form Section (Remaining 30% Height) ---
                // We use Padding only here to separate the form content from the screen edges
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.px),
                  child: Column(
                    children: [
                      // Adding a small gap from the large image
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          StringConstants.loginWithPhoneNumber,
                          style: MyTextStyle.titleStyle24bb,
                        ),
                      ),
                      SizedBox(height: 20.px),

                      // --- Phone Input Section ---
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Country Code Input (Styled to match the text field)
                          countryCodeInput(context),

                          // Phone Number Text Field
                          Flexible(
                            child: CommonWidgets.commonTextFieldForLoginSignUP(
                              controller: controller.phoneController,
                              isCard: true,
                              hintText: StringConstants.phoneNumber,
                              hintStyle: MyTextStyle.titleStyle14b,
                              style: MyTextStyle.titleStyle14bb,
                              keyboardType: TextInputType.number,
                              borderRadius: 15.px,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 30.px),

                      // --- Login Button ---
                      CommonWidgets.commonElevatedButton(
                          onPressed: () {
                            controller.clickOnLoginButton();
                          },
                          child: Text(
                            StringConstants.next,
                            style: MyTextStyle.titleStyle16bw,
                          ),
                          showLoading: controller.showLoading.value),

                      // Space to handle keyboard overlay if the form section is taller than 30%
                      SizedBox(
                          height:
                              MediaQuery.of(context).viewInsets.bottom + 20.px),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
