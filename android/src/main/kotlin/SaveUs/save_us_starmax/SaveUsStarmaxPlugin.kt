package SaveUs.save_us_starmax

import android.util.Log
import androidx.annotation.NonNull
import com.starmax.bluetoothsdk.MapStarmaxNotify
import com.starmax.bluetoothsdk.StarmaxSend
import com.starmax.bluetoothsdk.data.NotifyType

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

/** SaveUsStarmaxPlugin */
class SaveUsStarmaxPlugin : FlutterPlugin, MethodCallHandler {
    /// The MethodChannel that will the communication between Flutter and native Android
    ///
    /// This local reference serves to register the plugin with the Flutter Engine and unregister it
    /// when the Flutter Engine is detached from the Activity
    private lateinit var channel: MethodChannel

    override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, "save_us_starmax")
        channel.setMethodCallHandler(this)
    }

    override fun onMethodCall(call: MethodCall, result: Result) {
        when (call.method) {
            "notify" -> result.success(notify(call.argument("value")))
            "pair" -> result.success(pair())
            "getPlatformVersion" -> result.success("Android ${android.os.Build.VERSION.RELEASE}")
            else -> result.notImplemented()
        }
        Log.d(this.javaClass.simpleName, "callMethod:: ${call.method}")

    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }

    private fun pair(): ByteArray {
        return StarmaxSend().pair()
    }

    private fun notify(value: ByteArray?): String {
        if (value != null) {
            try {
                val response = MapStarmaxNotify().notify(value)

                if (response.type == NotifyType.CrcFailure) {
                    Log.d(this.javaClass.simpleName, "onCharacteristicChanged :: crc failure")
                    return value.joinToString("") { "%02x".format(it) }
                }
                if (response.type == NotifyType.Failure) {
                    Log.d(this.javaClass.simpleName, "onCharacteristicChanged :: failure")
                    return value.joinToString("") { "%02x".format(it) }
                }
                Log.d(this.javaClass.simpleName, "${response.type} :: ${response.toJson()}")
                return response.toJson()
            } catch (e: Exception) {
                return e.message ?: ""
            }
        }
        return ""
    }
}
