package save_us_starmax

import android.util.Log

import androidx.annotation.NonNull
import com.starmax.bluetoothsdk.*
import com.starmax.bluetoothsdk.data.*

import org.json.JSONObject

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

import java.util.Calendar

class SaveUsStarmaxPlugin : FlutterPlugin, MethodCallHandler {
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
                return result.success(getStepHistory(calendar))
            }

            "getSleepHistory" -> {
                val calendar = Calendar.getInstance()

                calendar.set(
                    call.argument("year") ?: 0,
                    call.argument("month") ?: 0,
                    call.argument("date") ?: 0,
                    call.argument("hour") ?: 0,
                    call.argument("minute") ?: 0,
                    call.argument("second") ?: 0,
                )
                return result.success(getSleepHistory(calendar))
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
                return result.success(getHeartRateHistory(calendar))
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
                return result.success(getBloodPressureHistory(calendar))
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
                return result.success(getBloodOxygenHistory(calendar))
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
                return result.success(getPressureHistory(calendar))
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
                return result.success(getMetHistory(calendar))
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
                return result.success(getTempHistory(calendar))
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
                return result.success(getBloodSugarHistory(calendar))
            }

            "getValidHistoryDates" -> {
                val historyType: HistoryType = getHistoryType(call.argument("historyType") ?: 0)
                result.success(getValidHistoryDates(historyType))
            }

            "getNotDisturb" -> result.success(getNotDisturb())
            "getLongSit" -> result.success(getLongSit())
            "getDrinkWater" -> result.success(getDrinkWater())

            "setLongSit" -> result.success(
                setLongSit(
                    onOff = call.argument("onOff") ?: false,
                    startHour = call.argument("startHour") ?: 0,
                    startMinute = call.argument("startMinute") ?: 0,
                    endHour = call.argument("endHour") ?: 23,
                    endMinute = call.argument("endMinute") ?: 59,
                    interval = call.argument("interval") ?: 60
                )
            )

            "setDrinkWater" -> result.success(
                setDrinkWater(
                    onOff = call.argument("onOff") ?: false,
                    startHour = call.argument("startHour") ?: 0,
                    startMinute = call.argument("startMinute") ?: 0,
                    endHour = call.argument("endHour") ?: 23,
                    endMinute = call.argument("endMinute") ?: 59,
                    interval = call.argument("interval") ?: 60
                )
            )

            "setNotDisturb" -> result.success(
                setNotDisturb(
                    onOff = call.argument("onOff") ?: false,
                    allDayOnOff = call.argument("allDayOnOff") ?: false,
                    startHour = call.argument("startHour") ?: 0,
                    startMinute = call.argument("startMinute") ?: 0,
                    endHour = call.argument("endHour") ?: 0,
                    endMinute = call.argument("endMinute") ?: 0,
                )
            )

            "setHeartRateControl" -> result.success( // 없음
                setHeartRateControl(
                    startHour = call.argument("startHour") ?: 0,
                    startMinute = call.argument("startMinute") ?: 0,
                    endHour = call.argument("endHour") ?: 23,
                    endMinute = call.argument("endMinute") ?: 59,
                    period = call.argument("period") ?: 15,
                    alarmThreshold = call.argument("alarmThreshold") ?: 60
                )
            )

            "setState" -> result.success(
                setState(
                    timeFormat = call.argument("timeFormat") ?: 1,
                    unitFormat = call.argument("unitFormat") ?: 0,
                    tempFormat = call.argument("tempFormat") ?: 0,
                    language = call.argument("language") ?: 9,
                    backlighting = call.argument("backlighting") ?: 15,
                    screen = call.argument("screen") ?: 70,
                    wristUp = call.argument("wristUp") ?: true
                )
            )

            "setUserInfo" -> result.success(
                setUserInfo(
                    sex = call.argument("sex") ?: 0,
                    age = call.argument("age") ?: 55,
                    height = call.argument("height") ?: 165,
                    weight = call.argument("weight") ?: 60
                )
            )

            "setTime" -> result.success(setTime())
            "reset" -> result.success(reset())
            "pair" -> result.success(pair())

            "getPlatformVersion" -> result.success("Android ${android.os.Build.VERSION.RELEASE}")

            else -> result.notImplemented()
        }
        Log.d(this.javaClass.simpleName, "callMethod:: ${call.method}")
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }

    // HistoryType
    private fun getHistoryType(param: Int): HistoryType {
        return when (param) {
            0 -> HistoryType.Sleep
            1 -> HistoryType.Step
            2 -> HistoryType.HeartRate
            3 -> HistoryType.BloodPressure
            4 -> HistoryType.BloodOxygen
            5 -> HistoryType.Pressure
            6 -> HistoryType.Met
            7 -> HistoryType.Temp
            8 -> HistoryType.Mai
            9 -> HistoryType.BloodSugar
            else -> HistoryType.Sport
        }
    }

    // 14.1.Get Heart Rate Detection Interval and Range
    private fun getHeartRateControl(): ByteArray {
        return StarmaxSend().getHeartRateControl()
    }

    // 12.1.Get Health Data Detection Switch
    private fun getHealthOpen(): ByteArray {
        return StarmaxSend().getHealthOpen()
    }

    // 11.Get Current Device Health Data
    private fun getHealthDetail(): ByteArray {
        return StarmaxSend().getHealthDetail()
    }

    // 7.Get Device Firmware Version Information
    private fun getVersion(): ByteArray {
        return StarmaxSend().getVersion()
    }

    // 6.Get Battery Level
    private fun getPower(): ByteArray {
        return StarmaxSend().getPower()
    }

    // 2.1.Get Device Status
    private fun getState(): ByteArray {
        return StarmaxSend().getState()
    }

    // 25.Synchronize Sports Data
    private fun getSportHistory(): ByteArray {
        return StarmaxSend().getSportHistory()
    }

    // 6.41 Sync sleep records
    // https://doc.runmefitserver.com
    private fun getSleepHistory(calendar: Calendar): ByteArray {
        return StarmaxSend().getSleepHistory(calendar)
    }

    // 26.Synchronize Data of Steps/Sleep
    private fun getStepHistory(calendar: Calendar): ByteArray {
        return StarmaxSend().getStepHistory(calendar)
    }

    // 27.Synchronize Heart Rate Data
    private fun getHeartRateHistory(calendar: Calendar): ByteArray {
        return StarmaxSend().getHeartRateHistory(calendar)
    }

    // 28.Synchronize Blood Pressure Data
    private fun getBloodPressureHistory(calendar: Calendar): ByteArray {
        return StarmaxSend().getBloodPressureHistory(calendar)
    }

    // 29.Synchronize Blood Oxygen Data
    private fun getBloodOxygenHistory(calendar: Calendar): ByteArray {
        return StarmaxSend().getBloodOxygenHistory(calendar)
    }

    // 30.Synchronize Stress Data
    private fun getPressureHistory(calendar: Calendar): ByteArray {
        return StarmaxSend().getPressureHistory(calendar)
    }

    // 31.Synchronize MET Data
    private fun getMetHistory(calendar: Calendar): ByteArray {
        return StarmaxSend().getMetHistory(calendar)
    }

    // 32.Synchronize Temperature Data
    private fun getTempHistory(calendar: Calendar): ByteArray {
        return StarmaxSend().getTempHistory(calendar)
    }

    // 35.Synchronize Blood Glucose Date
    private fun getBloodSugarHistory(calendar: Calendar): ByteArray {
        val bloodSugar = StarmaxSend().getBloodSugarHistory(calendar)
        Log.d(this.javaClass.simpleName, "getBloodSugarHistory:: ${bloodSugar.contentToString()}")
        return bloodSugar
    }

    // 34.Synchronize Valid Date of Historical Data
    private fun getValidHistoryDates(historyType: HistoryType): ByteArray {
        val validHistory = StarmaxSend().getValidHistoryDates(historyType)
        Log.d(this.javaClass.simpleName, "getValidHistoryDates:: ${validHistory.contentToString()}")
        return validHistory
    }

    // 17.1.Get Do Not Disturb Mode
    private fun getNotDisturb(): ByteArray {
        return StarmaxSend().getNotDisturb()
    }

    // 19.1.Get Sedentary Reminder
    private fun getLongSit(): ByteArray {
        return StarmaxSend().getLongSit()
    }

    // 20.1.Get Drink Water Reminder
    private fun getDrinkWater(): ByteArray {
        return StarmaxSend().getDrinkWater()
    }

    // 19.2.Set Sedentary Reminder
    private fun setLongSit(
        onOff: Boolean,
        startHour: Int,
        startMinute: Int,
        endHour: Int,
        endMinute: Int,
        interval: Int
    ): ByteArray {
        return StarmaxSend().setLongSit(
            onOff = onOff,
            startHour = startHour,
            startMinute = startMinute,
            endHour = endHour,
            endMinute = endMinute,
            interval = interval
        )
    }

    // 20.2.Set Drink Water Reminder
    private fun setDrinkWater(
        onOff: Boolean,
        startHour: Int,
        startMinute: Int,
        endHour: Int,
        endMinute: Int,
        interval: Int
    ): ByteArray {
        return StarmaxSend().setDrinkWater(
            onOff = onOff,
            startHour = startHour,
            startMinute = startMinute,
            endHour = endHour,
            endMinute = endMinute,
            interval = interval
        )
    }

    // 17.2.Set Do Not Disturb Mode
    private fun setNotDisturb(
        onOff: Boolean,
        allDayOnOff: Boolean,
        startHour: Int,
        startMinute: Int,
        endHour: Int,
        endMinute: Int
    ): ByteArray {
        return StarmaxSend().setNotDisturb(
            onOff = onOff,
            allDayOnOff = allDayOnOff,
            startHour = startHour,
            startMinute = startMinute,
            endHour = endHour,
            endMinute = endMinute,
        )
    }

    // 14.2.Set Heart Rate Detection Interval and Range
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

    // 2.2.Set Device Status
    private fun setState(
        timeFormat: Int,
        unitFormat: Int,
        tempFormat: Int,
        language: Int,
        backlighting: Int,
        screen: Int,
        wristUp: Boolean
    ): ByteArray {
        return StarmaxSend().setState(
            timeFormat = timeFormat,
            unitFormat = unitFormat,
            tempFormat = tempFormat,
            language = language,
            backlighting = backlighting,
            screen = screen,
            wristUp = wristUp
        )
    }

    // 8.Set Time Zone
    private fun setTime(): ByteArray {
        return StarmaxSend().setTime()
    }

    // 9.Set User Information
    private fun setUserInfo(sex: Int, age: Int, height: Int, weight: Int): ByteArray {
        return StarmaxSend().setUserInfo(sex = sex, age = age, height = height, weight = weight)
    }

    // 13.Reset
    // TODO return value error
    private fun reset(): ByteArray {
        return StarmaxSend().reset()
    }

    // 1.Pairing Command
    private fun pair(): ByteArray {
        return StarmaxSend().pair()
    }

    // Pass the Bluetooth data packet returned by the device to th
    // in the Bluetooth system callback function onCharacteristicChanged()
    private fun notify(value: ByteArray?): String {
        if (value != null) {
            try {
                Log.d(
                    this.javaClass.simpleName,
                    "비교 값 : ${value}"
                )
                val response = starmaxNotify.notify(value)

                Log.d(
                    this.javaClass.simpleName,
                    "${response.type}:: ${value.size} ${value.contentToString()}"
                )
                if (response.type == NotifyType.CrcFailure) {
                    Log.d(this.javaClass.simpleName, "onCharacteristicChanged :: crc failure")
                }
                if (response.type == NotifyType.Failure) {
                    Log.d(this.javaClass.simpleName, "onCharacteristicChanged :: failure")
                }
                // SDK로 보내면 [218 , , , ] 이런식으로 보내면 사람이 읽을수 있게 리턴을 해줌.
                // IOS도 SDK로 호출을 하고 나서 받는 작업 해여함
                return response.toJson()
            } catch (e: Exception) {
                return e.message ?: ""
            }
        }
        return ""
    }

    private val starmaxNotify = MapStarmaxNotify()
}
