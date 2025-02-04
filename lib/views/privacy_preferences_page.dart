
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/privacy_preferences_controller.dart';

class PrivacyPreferences extends StatelessWidget {
  final PrivacyPreferencesController controller = Get.put(PrivacyPreferencesController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Privacy Preferences")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Obx(() {
              String fullText =
                  "To opt out of the 'sale' or 'sharing' of your personal information, click 'Reject All' below. "
                  "We and selected third parties use cookies to store and access personal data and process personal data "
                  "like unique identifiers based on your consent and legitimate interests...";

              return RichText(
                text: TextSpan(
                  style: TextStyle(fontSize: 14, color: Colors.black),
                  children: [
                    TextSpan(
                      text: controller.isPrivacyTextExpanded.value
                          ? fullText
                          : (fullText.length > 200
                          ? "${fullText.substring(0, 200)}..."
                          : fullText),
                    ),
                    if (fullText.length > 200)
                      TextSpan(
                        text: controller.isPrivacyTextExpanded.value ? " Read Less" : " Read More",
                        style: TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () => controller.togglePrivacyText(),
                      ),
                  ],
                ),
              );
            }),

            SizedBox(height: 10),
            Divider(),

            Expanded(
              child: Obx(() => ListView.separated(
                separatorBuilder: (context, index) => Divider(),
                itemCount: controller.cookies.length,
                itemBuilder: (context, index) {
                  var cookie = controller.cookies[index];
                  return ListTile(
                    dense: true,
                    contentPadding: EdgeInsets.zero,
                    minVerticalPadding: 2,
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          cookie.title,
                          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                        ),
                        cookie.isEnabled != null ? Transform.scale(
                          scale: 0.8,
                          child: Switch(
                            activeColor: Colors.green,
                            value: cookie.isEnabled!,
                            onChanged: (value) => controller.toggleCookie(index),
                          ),
                        ) : Text('Always active', style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w500),),
                      ],
                    ),
                    subtitle: RichText(
                      text: TextSpan(
                        style: TextStyle(color: Colors.black, fontSize: 14),
                        children: [
                          TextSpan(
                            text: cookie.isExpanded
                                ? cookie.description // Full text
                                : (cookie.description.length > 60
                                ? "${cookie.description.substring(0, 60)}..."
                                : cookie.description), // Truncated text
                          ),
                          if (cookie.description.length > 60) // Only show if text is long
                            TextSpan(
                              text: cookie.isExpanded ? " Read Less" : " Read More",
                              style: TextStyle(
                                color: Colors.green, // Highlight the button
                                fontWeight: FontWeight.bold,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () => controller.toggleExpand(index),
                            ),
                        ],
                      ),
                    ),
                  );
                },
              )),
            ),



            Divider(),
            SizedBox(height: 10),

            // Buttons
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: controller.rejectAll,
                  child: Text("Reject All", style: TextStyle(color: Colors.green)),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 40,
                  child: OutlinedButton(
                    onPressed: controller.confirmAll,
                    child: Text("Confirm All", style: TextStyle( color:  Colors.green),),
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: Colors.green),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () => Get.snackbar("Success", "Your preferences have been saved."),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                minimumSize: Size(double.infinity, 40),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text("Confirm my choices", style: TextStyle(color: Colors.white),),
            ),
          ],
        ),
      ),
    );
  }
}
