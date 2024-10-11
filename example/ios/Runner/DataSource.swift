//
//  DataSource.swift
//  Runner
//
//  Created by 주승현 on 6/12/24.
//

import Foundation
import UIKit
import TrusangBluetooth
// Cell Type
enum CellType {
    case `switch`
    case `default`
}

// Function list
enum FunctionType {
    ///当前计步（Current step）
    case currentStep
    ///当前心率血压血氧（Current heart rate, blood pressure ,blood oxygen）
    case currentHR_BP_BO
    ///当前体温（Current temperature）
    case currentTemperature
    ///历史计步睡眠(Step and Sleep history record)
    case historyStepAndSleep
    ///历史心率血压血氧（ Heart rate, blood pressure ,blood oxygen history record）
    case historyHR_BP_BO
    ///历史体温（ Temperature history record）
    case historyTemperature
    ///历史运动模式 (Exercise history record）
    case historySportMode
    ///设备基本信息（Device base infomation）
    case deviceInfo
    ///设备配置(Device Configuration)
    case deviceConfig
    ///电量 (Battery Power)
    case batteryPower
    ///同步时间(Synchronised time)
    case syncTime
    ///同步语言(Synchronised language)
    case syncLanguage
    ///读取闹钟(Read alarmClock)
    case readAlarmClock
    ///读取久坐提醒(Read sedentary)
    case readSedentary
    ///查找设备(Find device)
    case findDevice
    ///恢复出厂设置(Reset)
    case reset
    ///翻腕亮屏(Trun wrist)
    case trunWrist
    ///心率自动检测(Heart rate auto measure)
    case heartAutoMeasure
    ///体温自动检测(Temperature auto measure)
    case temperatureAutoMeasure
    ///发送配对码 (Send pair code)
    case sendPairCode
    ///关闭设备配对码界面 (End pair Code UI)
    case endPairCode
    ///发送自定义消息(Send custom message)
    case sendMessage
    ///开始拍照(Take photo)
    case takePhoto
    ///取消拍照(Cancel photo)
    case takePhotoCancel
    ///社交APP消息通知(Social app message notification reminder)
    case notice
    ///消息通知总开关(Social app message notification reminde master switch)
    case messageSwitch
    ///静息卡路里开关(RMR Switch)
    case RMRSwitch
}

struct DeviceFunction {
    var functionType: FunctionType = .batteryPower
    var funcName = "unknow"
    var cellType: CellType = .default
}

class DataSource: NSObject {

    var dataSource: [DeviceFunction] = [DeviceFunction]()
    override init() {
        
    }
    
    let cmds: [FunctionType] = [.deviceInfo, .deviceConfig, .batteryPower, .syncTime, .syncLanguage, .currentStep, .currentHR_BP_BO, .currentTemperature, .historyStepAndSleep, .historyHR_BP_BO, .historyTemperature,  .historySportMode, .readAlarmClock, .readSedentary, .findDevice, .takePhoto, .takePhotoCancel, .sendPairCode, .endPairCode, .sendMessage, .messageSwitch, .trunWrist, .temperatureAutoMeasure, .RMRSwitch, .reset]
    let funcNames = ["读取设备基本信息(Read basic device information)", "读取设备配置(Read device configuration)", "读取设备电量(Read battery power)", "同步时间(Synchronised time)", "同步语言(Synchronised language)", "当前步数(Current Step)", "当前心率(Current heart rate)", "当前体温(Current temperature)", "历史计步睡眠(Step and Sleep history record)", "历史心率血压（Heart rate, blood pressure history record）", "历史体温（temperature history record）", "历史运动模式数据(Exercise history record）" ,"读取闹钟(Read alarmClock)", "读取久坐提醒(Read sedentary)", "查找设备(Find device)", "开始拍照(Take photo)", "取消拍照(Cancel photo)" ,"发送配对码(Send pair code)", "关闭配对码(End pair Code UI)", "发送自定义消息(Send custom message)", "消息通知开关(Social app message notification reminder)", "翻腕亮屏(Trun wrist)","体温自动检测（Temperature auto measure）", "静息卡路里开关（RMR switch）" , "恢复出厂设置(Reset)"]
    let cellTypes: [CellType] = []
    
    // Load datasource
    func loadDataSource() -> [DeviceFunction] {
        for i in 0..<cmds.count {
            let deviceFunction = DeviceFunction.init(functionType: cmds[i], funcName: funcNames[i], cellType: .default)
            dataSource.append(deviceFunction)
        }
        return dataSource
    }
}
