# Stripe PushProvisioning - prevent R8 from removing required classes
#-keep class com.stripe.android.pushProvisioning.** { *; }
#-keepclassmembers class com.stripe.android.pushProvisioning.** { *; }
#-keepnames class com.stripe.android.pushProvisioning.** { *; }


-keep class com.stripe.android.** { *; }
-keep class com.reactnativestripesdk.** { *; }
-dontwarn com.stripe.android.**
-dontwarn com.reactnativestripesdk.**
