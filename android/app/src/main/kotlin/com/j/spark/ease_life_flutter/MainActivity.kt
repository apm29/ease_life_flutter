package com.j.spark.ease_life_flutter

import android.Manifest
import android.content.pm.PackageManager
import android.os.Bundle
import androidx.core.app.ActivityCompat
import io.flutter.app.FlutterActivity
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugins.GeneratedPluginRegistrant


class MainActivity : FlutterActivity() {

//    private var contactPermissionResult: MethodChannel.Result? = null
//    private val methodCallHandler = MethodChannel.MethodCallHandler { call, result ->
//        when (call.method) {
//            "requestContactPermission" -> {
//                this.contactPermissionResult = result
//                ActivityCompat.requestPermissions(this, arrayOf(Manifest.permission.READ_CONTACTS), 1002)
//                result.success(0)
//            }
//            else -> {
//                result.notImplemented()
//            }
//        }
//    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        GeneratedPluginRegistrant.registerWith(this)
//
//        MethodChannel(flutterView, "spark.zj.mc").setMethodCallHandler(
//                methodCallHandler
//        )
    }

//    override fun onRequestPermissionsResult(requestCode: Int, permissions: Array<out String>, grantResults: IntArray) {
//        super.onRequestPermissionsResult(requestCode, permissions, grantResults)
//        if (requestCode == 1002 && permissions[0] == Manifest.permission.READ_CONTACTS) {
//            val result = grantResults[0]
//            contactPermissionResult?.success(if ((PackageManager.PERMISSION_GRANTED == result)) 1 else 0)
//        } else {
//            contactPermissionResult?.success(0)
//        }
//    }
}
