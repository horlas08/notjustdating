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
