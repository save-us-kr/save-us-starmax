import Flutter
import UIKit
import RunmefitSDK
import CoreBluetooth

public class SwiftSaveUsStarmaxPlugin: NSObject, FlutterPlugin, CBCentralManagerDelegate, CBPeripheralDelegate {
    private var centralManager: CBCentralManager!
    private var connectedPeripheral: CBPeripheral?
    private var writeCharacteristic: CBCharacteristic?
    private var notifyCharacteristic: CBCharacteristic?
    private var starmaxNotify: STBlueToothData!
    private var methodChannel: FlutterMethodChannel!
    private let Nof_Revice_Data_Key = "Nof_Revice_Data_Key"
    public var type = ""

    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "save_us_starmax", binaryMessenger: registrar.messenger())
        let instance = SwiftSaveUsStarmaxPlugin()
        instance.methodChannel = channel
        registrar.addMethodCallDelegate(instance, channel: channel)
        instance.initialize()
    }

    private func initialize() {
        print("initialize 진입")
        self.centralManager = CBCentralManager(delegate: self, queue: DispatchQueue.main)
        NotificationCenter.default.addObserver(self, selector: #selector(nofReviceData(_:)), name: NSNotification.Name(rawValue: Nof_Revice_Data_Key), object: nil)
        self.starmaxNotify = STBlueToothData.sharedInstance()
        print("STBlueToothData initialized: \(self.starmaxNotify != nil)")
    }
    
    @objc private func nofReviceData(_ notification: Notification) {
        guard let userInfo = notification.userInfo,
              let responseObject = notification.object as? Data else {
            return
        }

        let revType = userInfo[ST_RevType_Key] as? Int ?? 0
        let errorType = userInfo[ST_ErrorType_Key] as? Int ?? 0
        let args: [String: Any] = [
            "revType": revType,
            "errorType": errorType,
            "responseObject": FlutterStandardTypedData(bytes: responseObject)
        ]

        methodChannel.invokeMethod("onCharacteristicReceived", arguments: args)
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch call.method {
        case "getPlatformVersion":
            type = "getPlatformVersion"
            result("iOS " + UIDevice.current.systemVersion)
        case "getVersion":
            type = "getVersion"
            result(getVersion())
        case "getHeartRateControl":
            type = "getHeartRateControl"
            result(getHeartRateControl())
        case "getValidHistoryDates":
            type = "getValidHistoryDates"
            if let args = call.arguments as? [String: Any],
               let historyType = args["historyType"] as? Int {
                result(getValidHistoryDates(historyType: historyType))
            } else {
                result(FlutterError(code: "INVALID_ARGUMENT", message: "Invalid argument for getValidHistoryDates", details: nil))
            }
        case "getHeartRateHistory":
            type = "getHeartRateHistory"
            if let args = call.arguments as? [String: Any],
               let year = args["year"] as? Int,
               let month = args["month"] as? Int,
               let date = args["date"] as? Int,
               let hour = args["hour"] as? Int,
               let minute = args["minute"] as? Int,
               let second = args["second"] as? Int {
                result(getHeartRateHistory(year: year, month: month, date: date, hour: hour, minute: minute, second: second))
            } else {
                result(FlutterError(code: "INVALID_ARGUMENT", message: "Invalid argument for getHeartRateHistory", details: nil))
            }
        case "getBloodSugarHistory":
            type = "getBloodSugarHistory"
            if let args = call.arguments as? [String: Any],
               let year = args["year"] as? Int,
               let month = args["month"] as? Int,
               let date = args["date"] as? Int,
               let hour = args["hour"] as? Int,
               let minute = args["minute"] as? Int,
               let second = args["second"] as? Int {
                result(getBloodSugarHistory(year: year, month: month, date: date, hour: hour, minute: minute, second: second))
            } else {
                result(FlutterError(code: "INVALID_ARGUMENT", message: "Invalid argument for getBloodSugarHistory", details: nil))
            }
        case "getState":
            type = "getState"
            result(getState())
        case "getNotDisturb":
            type = "getNotDisturb"
            result(getNotDisturb())
        case "setNotDisturb":
            type = "setNotDisturb"
            if let args = call.arguments as? [String: Any],
               let onOff = args["onOff"] as? Bool,
               let allDayOnOff = args["allDayOnOff"] as? Bool,
               let startHour = args["startHour"] as? Int,
               let startMinute = args["startMinute"] as? Int,
               let endHour = args["endHour"] as? Int,
               let endMinute = args["endMinute"] as? Int {
                result(setNotDisturb(onOff: onOff, allDayOnOff: allDayOnOff, startHour: startHour, startMinute: startMinute, endHour: endHour, endMinute: endMinute))
            } else {
                result(FlutterError(code: "INVALID_ARGUMENT", message: "Invalid argument for setNotDisturb", details: nil))
            }
        case "notify":
            if let args = call.arguments as? [String: Any],
               let value = args["value"] as? FlutterStandardTypedData {
                notify(value: value.data, result: result)
            } else {
                result("{\"error\": \"Invalid argument for notify\"}")
            }
        case "getHealthData":
            type = "getHealthData"
            result(getHealthDetail())
        case "getPower":
            type = "getPower"
            result(getPower())
        case "getSportHistory":
            type = "getSportHistory"
            result(getSportHistory())
        case "getStepHistory":
            type = "getStepHistory"
            if let args = call.arguments as? [String: Any],
               let year = args["year"] as? Int,
               let month = args["month"] as? Int,
               let date = args["date"] as? Int,
               let hour = args["hour"] as? Int,
               let minute = args["minute"] as? Int,
               let second = args["second"] as? Int {
                result(getStepHistory(year: year, month: month, date: date, hour: hour, minute: minute, second: second))
            } else {
                result(FlutterError(code: "INVALID_ARGUMENT", message: "Invalid argument for getStepHistory", details: nil))
            }
        case "getBloodPressureHistory":
            type = "getBloodPressureHistory"
            if let args = call.arguments as? [String: Any],
               let year = args["year"] as? Int,
               let month = args["month"] as? Int,
               let date = args["date"] as? Int,
               let hour = args["hour"] as? Int,
               let minute = args["minute"] as? Int,
               let second = args["second"] as? Int {
                result(getBloodPressureHistory(year: year, month: month, date: date, hour: hour, minute: minute, second: second))
            } else {
                result(FlutterError(code: "INVALID_ARGUMENT", message: "Invalid argument for getBloodPressureHistory", details: nil))
            }
        case "getBloodOxygenHistory":
            type = "getBloodOxygenHistory"
            if let args = call.arguments as? [String: Any],
               let year = args["year"] as? Int,
               let month = args["month"] as? Int,
               let date = args["date"] as? Int,
               let hour = args["hour"] as? Int,
               let minute = args["minute"] as? Int,
               let second = args["second"] as? Int {
                result(getBloodOxygenHistory(year: year, month: month, date: date, hour: hour, minute: minute, second: second))
            } else {
                result(FlutterError(code: "INVALID_ARGUMENT", message: "Invalid argument for getBloodOxygenHistory", details: nil))
            }
        case "getPressureHistory":
            type = "getPressureHistory"
            if let args = call.arguments as? [String: Any],
               let year = args["year"] as? Int,
               let month = args["month"] as? Int,
               let date = args["date"] as? Int,
               let hour = args["hour"] as? Int,
               let minute = args["minute"] as? Int,
               let second = args["second"] as? Int {
                result(getPressureHistory(year: year, month: month, date: date, hour: hour, minute: minute, second: second))
            } else {
                result(FlutterError(code: "INVALID_ARGUMENT", message: "Invalid argument for getPressureHistory", details: nil))
            }
        case "getMetHistory":
            type = "getMetHistory"
            if let args = call.arguments as? [String: Any],
               let year = args["year"] as? Int,
               let month = args["month"] as? Int,
               let date = args["date"] as? Int,
               let hour = args["hour"] as? Int,
               let minute = args["minute"] as? Int,
               let second = args["second"] as? Int {
                result(getMetHistory(year: year, month: month, date: date, hour: hour, minute: minute, second: second))
            } else {
                result(FlutterError(code: "INVALID_ARGUMENT", message: "Invalid argument for getMetHistory", details: nil))
            }
        case "getTempHistory":
            type = "getTempHistory"
            if let args = call.arguments as? [String: Any],
               let year = args["year"] as? Int,
               let month = args["month"] as? Int,
               let date = args["date"] as? Int,
               let hour = args["hour"] as? Int,
               let minute = args["minute"] as? Int,
               let second = args["second"] as? Int {
                result(getTempHistory(year: year, month: month, date: date, hour: hour, minute: minute, second: second))
            } else {
                result(FlutterError(code: "INVALID_ARGUMENT", message: "Invalid argument for getTempHistory", details: nil))
            }
        case "getLongSit":
            type = "getLongSit"
            result(getLongSit())
        case "getDrinkWater":
            type = "getDrinkWater"
            result(getDrinkWater())
        case "setLongSit":
            type = "setLongSit"
            if let args = call.arguments as? [String: Any],
               let onOff = args["onOff"] as? Bool,
               let startHour = args["startHour"] as? Int,
               let startMinute = args["startMinute"] as? Int,
               let endHour = args["endHour"] as? Int,
               let endMinute = args["endMinute"] as? Int,
               let interval = args["interval"] as? Int {
                result(setLongSit(onOff: onOff, startHour: startHour, startMinute: startMinute, endHour: endHour, endMinute: endMinute, interval: interval))
            } else {
                result(FlutterError(code: "INVALID_ARGUMENT", message: "Invalid argument for setLongSit", details: nil))
            }
        case "setDrinkWater":
            type = "setDrinkWater"
            if let args = call.arguments as? [String: Any],
               let onOff = args["onOff"] as? Bool,
               let startHour = args["startHour"] as? Int,
               let startMinute = args["startMinute"] as? Int,
               let endHour = args["endHour"] as? Int,
               let endMinute = args["endMinute"] as? Int,
               let interval = args["interval"] as? Int {
                result(setDrinkWater(onOff: onOff, startHour: startHour, startMinute: startMinute, endHour: endHour, endMinute: endMinute, interval: interval))
            } else {
                result(FlutterError(code: "INVALID_ARGUMENT", message: "Invalid argument for setDrinkWater", details: nil))
            }
        case "setUserInfo":
            type = "setUserInfo"
            if let args = call.arguments as? [String: Any],
               let sex = args["sex"] as? Int,
               let age = args["age"] as? Int,
               let height = args["height"] as? Int,
               let weight = args["weight"] as? Int {
                result(setUserInfo(sex: sex, age: age, height: height, weight: weight))
            } else {
                result(FlutterError(code: "INVALID_ARGUMENT", message: "Invalid argument for setUserInfo", details: nil))
            }
        case "setState":
            type = "setState"
            if let args = call.arguments as? [String: Any],
               let timeFormat = args["timeFormat"] as? Int,
               let unitFormat = args["unitFormat"] as? Int,
               let tempFormat = args["tempFormat"] as? Int,
               let language = args["language"] as? Int,
               let backlighting = args["backlighting"] as? Int,
               let screen = args["screen"] as? Int,
               let wristUp = args["wristUp"] as? Bool {
                result(setState(timeFormat: timeFormat, unitFormat: unitFormat, tempFormat: tempFormat, language: language, backlighting: backlighting, screen: screen, wristUp: wristUp))
            } else {
                result(FlutterError(code: "INVALID_ARGUMENT", message: "Invalid argument for setState", details: nil))
            }
        case "setTime":
            type = "setTime"
            result(setTime())
        case "reset":
            type = "reset"
            result(reset())
        case "pair":
            type = "pair"
            result(pair())
        case "deviceConnected":
            if let args = call.arguments as? [String: Any],
               let deviceId = args["deviceId"] as? String,
               let deviceName = args["deviceName"] as? String {
                connectToDevice(deviceId: deviceId, deviceName: deviceName)
                result(nil)
            } else {
                result(FlutterError(code: "INVALID_ARGUMENT", message: "Invalid argument for deviceConnected", details: nil))
            }
        default:
            type = "NoFunction"
            result(FlutterMethodNotImplemented)
        }
    }

    private func connectToDevice(deviceId: String, deviceName: String) {
        let peripherals = centralManager.retrievePeripherals(withIdentifiers: [UUID(uuidString: deviceId)!])
        guard let peripheral = peripherals.first else {
            print("Peripheral not found")
            return
        }
        connectedPeripheral = peripheral
        centralManager.connect(peripheral, options: nil)
    }

    private func pair() -> FlutterStandardTypedData? {
        let data = STBlueToothSender.writeDevicePair()
        return FlutterStandardTypedData(bytes: data)
    }

    private func reset() -> FlutterStandardTypedData? {
        let data = STBlueToothSender.writeFactorySetting()
        return FlutterStandardTypedData(bytes: data)
    }

    private func setTime() -> FlutterStandardTypedData? {
        let data = STBlueToothSender.writeDeviceDateTime()
        return FlutterStandardTypedData(bytes: data)
    }

    private func setState(timeFormat: Int, unitFormat: Int, tempFormat: Int, language: Int, backlighting: Int, screen: Int, wristUp: Bool) -> FlutterStandardTypedData? {
        let model = STDeviceState()

        model.timeMode = timeFormat == 1 ? STlTimeModeHour24 : STlTimeModeHour12
        model.unit = unitFormat == 0 ? STUnitMetric : STUnitImperial
        model.temperatureUnit = tempFormat == 0 ? STlTemperatureUnitCelsius : STlTemperatureUnitFahrenheit
        model.language = STlLanguage(rawValue: UInt(language))
        model.brightDuration = backlighting
        model.brightness = screen
        model.trunWrist = wristUp

        let data = STBlueToothSender.write(model)
        return FlutterStandardTypedData(bytes: data)
    }

    private func setUserInfo(sex: Int, age: Int, height: Int, weight: Int) -> FlutterStandardTypedData? {
        let model = STlUserInfo()
        model.sex = sex
        model.age = age
        model.height = height
        model.weight = weight * 10

        let data = STBlueToothSender.write(model)
        return FlutterStandardTypedData(bytes: data)
    }

    private func setDrinkWater(onOff: Bool, startHour: Int, startMinute: Int, endHour: Int, endMinute: Int, interval: Int) -> FlutterStandardTypedData? {
        let model = STAlarmInterval()

        let intervalTime = STIntervalTime()
        intervalTime.startHour = startHour
        intervalTime.startMins = startMinute
        intervalTime.endHour = endHour
        intervalTime.endMins = endMinute

        model.intervalTime = intervalTime
        model.isOpen = onOff
        model.interval = interval

        let data = STBlueToothSender.writeDrinkWater(model)
        return FlutterStandardTypedData(bytes: data)
    }

    private func setLongSit(onOff: Bool, startHour: Int, startMinute: Int, endHour: Int, endMinute: Int, interval: Int) -> FlutterStandardTypedData? {
        let model = STAlarmInterval()

        let intervalTime = STIntervalTime()
        intervalTime.startHour = startHour
        intervalTime.startMins = startMinute
        intervalTime.endHour = endHour
        intervalTime.endMins = endMinute

        model.intervalTime = intervalTime
        model.isOpen = onOff
        model.interval = interval

        let data = STBlueToothSender.writeSedentaryAlarmInterval(model)
        return FlutterStandardTypedData(bytes: data)
    }

    private func getDrinkWater() -> FlutterStandardTypedData? {
        let data = STBlueToothSender.readDrinkWaterAlarmInterval()
        return FlutterStandardTypedData(bytes: data)
    }

    private func getLongSit() -> FlutterStandardTypedData? {
        let data = STBlueToothSender.readSedentaryAlarmInterval()
        return FlutterStandardTypedData(bytes: data)
    }

    private func getTempHistory(year: Int, month: Int, date: Int, hour: Int, minute: Int, second: Int) -> FlutterStandardTypedData? {
        let dateStr = String(format: "%04d%02d%02d", year, month, date)
        let data = STBlueToothSender.readTemperatureHistory(withDate: dateStr)
        return FlutterStandardTypedData(bytes: data)
    }

    private func getMetHistory(year: Int, month: Int, date: Int, hour: Int, minute: Int, second: Int) -> FlutterStandardTypedData? {
        let dateStr = String(format: "%04d%02d%02d", year, month, date)
        let data = STBlueToothSender.readMetsHistory(withDate: dateStr)
        return FlutterStandardTypedData(bytes: data)
    }

    private func getPressureHistory(year: Int, month: Int, date: Int, hour: Int, minute: Int, second: Int) -> FlutterStandardTypedData? {
        let dateStr = String(format: "%04d%02d%02d", year, month, date)
        let data = STBlueToothSender.readPhysicalPressureHistory(withDate: dateStr)
        return FlutterStandardTypedData(bytes: data)
    }

    private func getBloodOxygenHistory(year: Int, month: Int, date: Int, hour: Int, minute: Int, second: Int) -> FlutterStandardTypedData? {
        let dateStr = String(format: "%04d%02d%02d", year, month, date)
        let data = STBlueToothSender.readBloodOxygenHistory(withDate: dateStr)
        return FlutterStandardTypedData(bytes: data)
    }

    private func getBloodPressureHistory(year: Int, month: Int, date: Int, hour: Int, minute: Int, second: Int) -> FlutterStandardTypedData? {
        let dateStr = String(format: "%04d%02d%02d", year, month, date)
        let data = STBlueToothSender.readBloodPressureHistory(withDate: dateStr)
        return FlutterStandardTypedData(bytes: data)
    }

    private func getStepHistory(year: Int, month: Int, date: Int, hour: Int, minute: Int, second: Int) -> FlutterStandardTypedData? {
        let dateStr = String(format: "%04d%02d%02d", year, month, date)
        let data = STBlueToothSender.readStepAndSleepHistory(withDate: dateStr)
        return FlutterStandardTypedData(bytes: data)
    }

    private func getSportHistory() -> FlutterStandardTypedData? {
        var resultData: FlutterStandardTypedData?
        let semaphore = DispatchSemaphore(value: 0)

        let dummyError = NSError(domain: "", code: 0, userInfo: nil)

        guard let peripheral = connectedPeripheral,
              let writeChar = writeCharacteristic,
              let notifyChar = notifyCharacteristic else {
            print("Error: connectedPeripheral, writeCharacteristic or notifyCharacteristic is nil")
            return nil
        }

        STBlueToothData.sharedInstance().notifyRunmefit(
            peripheral,
            writeCharacter: writeChar,
            characteristic: notifyChar,
            error: dummyError
        ) { (error, revType, errorType, responseObject) in
            if error == nil && revType == REV_History_Sport, let data = responseObject as? Data {
                resultData = FlutterStandardTypedData(bytes: data)
            }
            semaphore.signal()
        }

        _ = semaphore.wait(timeout: .now() + 5)
        return resultData
    }

    private func getPower() -> FlutterStandardTypedData? {
        let data = STBlueToothSender.readDeviceBattery()
        return FlutterStandardTypedData(bytes: data)
    }

    private func getVersion() -> FlutterStandardTypedData? {
        let version = STBlueToothSender.readDeviceVersion()
        return FlutterStandardTypedData(bytes: version)
    }

    private func getValidHistoryDates(historyType: Int) -> FlutterStandardTypedData? {
        let cmd: STHistoryCmd
        switch historyType {
        case 0:
            cmd = ST_History_Sport
        case 1:
            cmd = ST_History_Step
        case 2:
            cmd = ST_History_HR
        case 3:
            cmd = ST_History_BP
        case 4:
            cmd = ST_History_BQ
        case 5:
            cmd = ST_History_Pressure
        case 6:
            cmd = ST_History_Met
        case 7:
            cmd = ST_History_Temp
        case 8:
            cmd = ST_History_Mai
        case 9:
            cmd = ST_History_Sugar
        default:
            return nil
        }

        let data = STBlueToothSender.readHistoryValidDate(cmd)
        return FlutterStandardTypedData(bytes: data)
    }

    private func getHeartRateHistory(year: Int, month: Int, date: Int, hour: Int, minute: Int, second: Int) -> FlutterStandardTypedData? {
        let dateStr = String(format: "%04d%02d%02d%02d%02d%02d", year, month, date, hour, minute, second)
        let data = STBlueToothSender.readHeartRateHistory(withDate: dateStr)
        return FlutterStandardTypedData(bytes: data)
    }

    private func getBloodSugarHistory(year: Int, month: Int, date: Int, hour: Int, minute: Int, second: Int) -> FlutterStandardTypedData? {
        let dateStr = String(format: "%04d%02d%02d%02d%02d%02d", year, month, date, hour, minute, second)
        let data = STBlueToothSender.readSugarHistory(withDate: dateStr)
        return FlutterStandardTypedData(bytes: data)
    }

    private func getState() -> FlutterStandardTypedData? {
        let data = STBlueToothSender.readDeviceState()
        return FlutterStandardTypedData(bytes: data)
    }

    private func getNotDisturb() -> FlutterStandardTypedData? {
        let data = STBlueToothSender.readNoDisturb()
        return FlutterStandardTypedData(bytes: data)
    }

    private func setNotDisturb(onOff: Bool, allDayOnOff: Bool, startHour: Int, startMinute: Int, endHour: Int, endMinute: Int) -> FlutterStandardTypedData? {
        let model = STNoDisturb()
        let intervalTime = STIntervalTime()
        intervalTime.startHour = startHour
        intervalTime.startMins = startMinute
        intervalTime.endHour = endHour
        intervalTime.endMins = endMinute

        model.intervalTime = intervalTime
        model.isOpen = onOff
        model.isAllDay = allDayOnOff

        let data = STBlueToothSender.write(model)
        return FlutterStandardTypedData(bytes: data)
    }

    private func getHeartRateControl() -> FlutterStandardTypedData? {
        let data = STBlueToothSender.readConfigMeasureHR()
        return FlutterStandardTypedData(bytes: data)
    }

    private func getHealthDetail() -> FlutterStandardTypedData? {
        let data = STBlueToothSender.readHealthSwitch()
        return FlutterStandardTypedData(bytes: data)
    }

    private func notify(value: Data, result: @escaping FlutterResult) {
        guard let connectedPeripheral = connectedPeripheral,
              let writeCharacteristic = writeCharacteristic,
              let notifyCharacteristic = notifyCharacteristic else {
            let errorDesc = "Peripheral or characteristics not found: " +
                            "Peripheral is \(connectedPeripheral == nil ? "nil" : "set"), " +
                            "Write Characteristic is \(writeCharacteristic == nil ? "nil" : "set"), " +
                            "Notify Characteristic is \(notifyCharacteristic == nil ? "nil" : "set")"
            print(errorDesc)
            result("{\"error\": \"\(errorDesc)\"}")
            return
        }

        let complete: (Error?, REV_TYPE, ERROR_TYPE, Any?) -> Void = { error, revType, errorType, responseObject in
            if let error = error as NSError? {
                result("{\"error\": \"Notification failed: \(error.localizedDescription)\"}")
            } else if let data = responseObject as? Data {
                let readableData = self.convertToReadableData(data: data)
                let responseDict = [
                    "type": "\(self.type)",
                    "data": readableData
                ]
                if let jsonData = try? JSONSerialization.data(withJSONObject: responseDict, options: []),
                   let jsonString = String(data: jsonData, encoding: .utf8) {
                    result(jsonString)
                } else {
                    result("{\"error\": \"Failed to serialize response\"}")
                }
            }
        }

        let dummyError = NSError(domain: "", code: 0, userInfo: nil)
        starmaxNotify.notifyRunmefit(
            connectedPeripheral,
            writeCharacter: writeCharacteristic,
            characteristic: notifyCharacteristic,
            error: dummyError,
            complete: complete
        )
    }

    // Converts Data to a human-readable string of hex codes
    private func convertToReadableData(data: Data) -> String {
        return data.map { String(format: "%02x", $0) }.joined(separator: " ")
    }

    // CBCentralManagerDelegate methods
    public func centralManagerDidUpdateState(_ central: CBCentralManager) {
        // Handle central manager state updates
    }

    public func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        peripheral.delegate = self
        peripheral.discoverServices(nil)
        connectedPeripheral = peripheral
    }

    public func centralManager(_ central: CBCentralManager, didDisconnectPeripheral peripheral: CBPeripheral, error: Error?) {
        if connectedPeripheral == peripheral {
            connectedPeripheral = nil
            writeCharacteristic = nil
            notifyCharacteristic = nil
        }
    }

    public func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String: Any], rssi RSSI: NSNumber) {
        // Handle device discovery
    }

    // CBPeripheralDelegate methods
    public func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
        if let services = peripheral.services {
            for service in services {
                peripheral.discoverCharacteristics(nil, for: service)
            }
        }
    }

    public func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?) {
        if let characteristics = service.characteristics {
            for characteristic in characteristics {
                if characteristic.properties.contains(.write) {
                    writeCharacteristic = characteristic
                }
                if characteristic.properties.contains(.notify) {
                    notifyCharacteristic = characteristic
                    peripheral.setNotifyValue(true, for: notifyCharacteristic!)
                }
            }
        }
    }

    public func peripheral(_ peripheral: CBPeripheral, didUpdateValueFor characteristic: CBCharacteristic, error: Error?) {
        if let value = characteristic.value {
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: Nof_Revice_Data_Key), object: value, userInfo: [
                ST_RevType_Key: characteristic.uuid.uuidString,
                ST_ErrorType_Key: error != nil ? 1 : 0
            ])
        }
    }
}
