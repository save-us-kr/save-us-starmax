package SaveUs.save_us_starmax

import android.util.Log
import androidx.annotation.NonNull
import com.starmax.bluetoothsdk.MapStarmaxNotify
import com.starmax.bluetoothsdk.StarmaxSend
import com.starmax.bluetoothsdk.data.*
import org.json.JSONObject
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import java.util.Calendar

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
            "getHealthData" -> result.success(getHealthDetail())
            "getPower" -> result.success(getPower())
            "getState" -> result.success(getState())
            "getVersion" -> result.success(getVersion())
            "getHealthOpen" -> result.success(getHealthOpen())
            "getHeartRateControl" -> result.success(getHeartRateControl())

            "getSportHistory" -> result.success(getSportHistory())

            "getStepHistory" -> {
                val calendar = Calendar.getInstance()

                calendar.set(
                    call.argument("year") ?: 0,
                    call.argument("month") ?: 0,
                    call.argument("date") ?: 0,
                    call.argument("hour") ?: 0,
                    call.argument("minute") ?: 0,
                    call.argument("second") ?: 0,
                )
                return result.success(
                    getStepHistory(
                        calendar
                    )
                )
            }

            "getHeartRateHistory" -> {
                val calendar = Calendar.getInstance()

                calendar.set(
                    call.argument("year") ?: 0,
                    call.argument("month") ?: 0,
                    call.argument("date") ?: 0,
                    call.argument("hour") ?: 0,
                    call.argument("minute") ?: 0,
                    call.argument("second") ?: 0,
                )
                return result.success(
                    getHeartRateHistory(
                        calendar
                    )
                )
            }

            "getBloodPressureHistory" -> {
                val calendar = Calendar.getInstance()

                calendar.set(
                    call.argument("year") ?: 0,
                    call.argument("month") ?: 0,
                    call.argument("date") ?: 0,
                    call.argument("hour") ?: 0,
                    call.argument("minute") ?: 0,
                    call.argument("second") ?: 0,
                )
                return result.success(
                    getBloodPressureHistory(
                        calendar
                    )
                )
            }

            "getBloodOxygenHistory" -> {
                val calendar = Calendar.getInstance()

                calendar.set(
                    call.argument("year") ?: 0,
                    call.argument("month") ?: 0,
                    call.argument("date") ?: 0,
                    call.argument("hour") ?: 0,
                    call.argument("minute") ?: 0,
                    call.argument("second") ?: 0,
                )
                return result.success(
                    getBloodOxygenHistory(
                        calendar
                    )
                )
            }

            "getPressureHistory" -> {
                val calendar = Calendar.getInstance()

                calendar.set(
                    call.argument("year") ?: 0,
                    call.argument("month") ?: 0,
                    call.argument("date") ?: 0,
                    call.argument("hour") ?: 0,
                    call.argument("minute") ?: 0,
                    call.argument("second") ?: 0,
                )
                return result.success(
                    getPressureHistory(
                        calendar
                    )
                )
            }

            "getMetHistory" -> {
                val calendar = Calendar.getInstance()

                calendar.set(
                    call.argument("year") ?: 0,
                    call.argument("month") ?: 0,
                    call.argument("date") ?: 0,
                    call.argument("hour") ?: 0,
                    call.argument("minute") ?: 0,
                    call.argument("second") ?: 0,
                )
                return result.success(
                    getMetHistory(
                        calendar
                    )
                )
            }

            "getTempHistory" -> {
                val calendar = Calendar.getInstance()

                calendar.set(
                    call.argument("year") ?: 0,
                    call.argument("month") ?: 0,
                    call.argument("date") ?: 0,
                    call.argument("hour") ?: 0,
                    call.argument("minute") ?: 0,
                    call.argument("second") ?: 0,
                )
                return result.success(
                    getTempHistory(
                        calendar
                    )
                )
            }

            "getBloodSugarHistory" -> {
                val calendar = Calendar.getInstance()

                calendar.set(
                    call.argument("year") ?: 0,
                    call.argument("month") ?: 0,
                    call.argument("date") ?: 0,
                    call.argument("hour") ?: 0,
                    call.argument("minute") ?: 0,
                    call.argument("second") ?: 0,
                )
                return result.success(
                    getBloodSugarHistory(
                        calendar
                    )
                )
            }

            "getValidHistoryDates" -> {
                val historyType: HistoryType = getHistoryType(call.argument("historyType") ?: 0)
                result.success(getValidHistoryDates(historyType))
            }

            "setHeartRateControl" -> result.success(
                setHeartRateControl(
                    startHour = call.argument("startHour") ?: 0,
                    startMinute = call.argument("startMinute") ?: 0,
                    endHour = call.argument("endHour") ?: 23,
                    endMinute = call.argument("endMinute") ?: 59,
                    period = call.argument("period") ?: 15,
                    alarmThreshold = call.argument("alarmThreshold") ?: 60
                )
            )

            "setTime" -> result.success(setTime())
            "pair" -> result.success(pair())
            "getPlatformVersion" -> result.success("Android ${android.os.Build.VERSION.RELEASE}")
            else -> result.notImplemented()
        }
        Log.d(this.javaClass.simpleName, "callMethod:: ${call.method}")
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }

    private fun getHistoryType(param: Int): HistoryType {
        return when (param) {
            0 -> HistoryType.Sport
            1 -> HistoryType.Step
            2 -> HistoryType.HeartRate
            3 -> HistoryType.BloodPressure
            4 -> HistoryType.BloodOxygen
            5 -> HistoryType.Pressure
            6 -> HistoryType.Met
            7 -> HistoryType.Temp
            8 -> HistoryType.Mai
            9 -> HistoryType.BloodSugar
            else -> HistoryType.HeartRate
        }
    }

    private fun getHeartRateControl(): ByteArray {
        return StarmaxSend().getHeartRateControl()
    }

    private fun getHealthOpen(): ByteArray {
        return StarmaxSend().getHealthOpen()
    }

    private fun getHealthDetail(): ByteArray {
        return StarmaxSend().getHealthDetail()
    }

    private fun getVersion(): ByteArray {
        return StarmaxSend().getVersion()
    }

    private fun getPower(): ByteArray {
        return StarmaxSend().getPower()
    }

    private fun getState(): ByteArray {
        return StarmaxSend().getState()
    }

    private fun getSportHistory(): ByteArray {
        return StarmaxSend().getSportHistory()
    }

    private fun getStepHistory(calendar: Calendar): ByteArray {
        Log.d(
            this.javaClass.simpleName, "getStepHistory:: $calendar"
        )
        return StarmaxSend().getStepHistory(calendar)
    }

    private fun getHeartRateHistory(calendar: Calendar): ByteArray {
        Log.d(
            this.javaClass.simpleName, "getHeartRateHistory:: $calendar"
        )
        return StarmaxSend().getHeartRateHistory(calendar)
    }

    private fun getBloodPressureHistory(calendar: Calendar): ByteArray {
        Log.d(
            this.javaClass.simpleName, "getBloodPressureHistory:: $calendar"
        )
        return StarmaxSend().getBloodPressureHistory(calendar)
    }

    private fun getBloodOxygenHistory(calendar: Calendar): ByteArray {
        Log.d(
            this.javaClass.simpleName, "getBloodOxygenHistory:: $calendar"
        )
        return StarmaxSend().getBloodOxygenHistory(calendar)
    }

    private fun getPressureHistory(calendar: Calendar): ByteArray {
        Log.d(
            this.javaClass.simpleName, "getPressureHistory:: $calendar"
        )
        return StarmaxSend().getPressureHistory(calendar)
    }

    private fun getMetHistory(calendar: Calendar): ByteArray {
        Log.d(
            this.javaClass.simpleName, "getMetHistory:: $calendar"
        )
        return StarmaxSend().getMetHistory(calendar)
    }

    private fun getTempHistory(calendar: Calendar): ByteArray {
        Log.d(
            this.javaClass.simpleName, "getTempHistory:: $calendar"
        )
        return StarmaxSend().getTempHistory(calendar)
    }

    private fun getBloodSugarHistory(calendar: Calendar): ByteArray {
        Log.d(
            this.javaClass.simpleName, "getBloodSugarHistory:: $calendar"
        )
        return StarmaxSend().getBloodSugarHistory(calendar)
    }

    private fun getValidHistoryDates(historyType: HistoryType): ByteArray {
        return StarmaxSend().getValidHistoryDates(historyType)
    }

    private fun setHeartRateControl(
        startHour: Int,
        startMinute: Int,
        endHour: Int,
        endMinute: Int,
        period: Int,
        alarmThreshold: Int
    ): ByteArray {
        return StarmaxSend().setHeartRateControl(
            startHour = startHour,
            startMinute = startMinute,
            endHour = endHour,
            endMinute = endMinute,
            period = period,
            alarmThreshold = alarmThreshold
        )
    }

    private fun setTime(): ByteArray {
        return StarmaxSend().setTime()
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
                }
                if (response.type == NotifyType.Failure) {
                    Log.d(this.javaClass.simpleName, "onCharacteristicChanged :: failure")
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
