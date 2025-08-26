# --- QuickBlox / Smack required classes ---

# Keep all Smack core classes
-keep class org.jivesoftware.smack.** { *; }
-dontwarn org.jivesoftware.smack.**

# Keep all Smack extensions
-keep class org.jivesoftware.smackx.** { *; }
-dontwarn org.jivesoftware.smackx.**

# Keep QuickBlox SDK classes
-keep class com.quickblox.** { *; }
-dontwarn com.quickblox.**

# Optional: prevent stripping of reflection-based code
-keepattributes *Annotation*
-dontwarn com.stripe.android.pushProvisioning.PushProvisioningActivity$g
-dontwarn com.stripe.android.pushProvisioning.PushProvisioningActivityStarter$Args
-dontwarn com.stripe.android.pushProvisioning.PushProvisioningActivityStarter$Error
-dontwarn com.stripe.android.pushProvisioning.PushProvisioningActivityStarter
-dontwarn com.stripe.android.pushProvisioning.PushProvisioningEphemeralKeyProvider
# Keep Stripe classes
-keep class com.stripe.** { *; }