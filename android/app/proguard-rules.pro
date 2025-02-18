# Не удалять аннотации
-keepattributes *Annotation*

# Не обфусцировать классы Huawei
-keep class com.huawei.** { *; }

# Не удалять классы Google Crypto Tink
-keep class com.google.crypto.tink.** { *; }

# Не удалять классы BouncyCastle
-keep class org.bouncycastle.** { *; }

# Не удалять аннотации javax
-keep class javax.annotation.** { *; }

# Не удалять аннотации Google ErrorProne
-keep class com.google.errorprone.annotations.** { *; }

# Google Crypto Tink
-keep class com.google.crypto.tink.** { *; }

# Joda-Time (работа с датами)
-keep class org.joda.time.** { *; }

# Google API Client
-keep class com.google.api.client.** { *; }

# OkHttp
-keep class okhttp3.** { *; }

-dontwarn org.apache.http.**
-ignorewarnings