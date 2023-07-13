//package com.example.xman;
//
//import io.flutter.plugin.common.PluginRegistry;
//import io.flutter.plugins.firebasemessaging.FirebaseMessagingPlugin;
//
//public final class FirebaseCloudMessagingPluginRegistrant{
//    public static void registerWith(PluginRegistry registry) {
//        if (alreadyRegisteredWith(registry)) {
//            return;
//        }
//        FirebaseMessagingPlugin.registerWith(registry.registrarFor("io.flutter.plugins.firebasemessaging.FirebaseMessagingPlugin"));
//    }
//
//    private static boolean alreadyRegisteredWith(PluginRegistry registry) {
//        final String key = FirebaseCloudMessagingPluginRegistrant.class.getCanonicalName();
//        if (registry.hasPlugin(key)) {
//            return true;
//        }
//        registry.registrarFor(key);
//        return false;
//    }
//}
//
//
//
//
////import io.flutter.plugin.common.PluginRegistry
////        import io.flutter.plugins.firebasemessaging.FirebaseMessagingPlugin
////
////class FirebaseCloudMessagingPluginRegistrant {
////    companion object {
////        fun registerWith(registry: PluginRegistry) {
////            if (alreadyRegisteredWith(registry)) {
////                return;
////            }
////            FirebaseMessagingPlugin.registerWith(registry.registrarFor("io.flutter.plugins.firebasemessaging.FirebaseMessagingPlugin"))
////        }
////
////        fun alreadyRegisteredWith(registry: PluginRegistry): Boolean {
////            val key = FirebaseCloudMessagingPluginRegistrant::class.java.name
////            if (registry.hasPlugin(key)) {
////                return true
////            }
////            registry.registrarFor(key)
////            return false
////        }
////    }
////}