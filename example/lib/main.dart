import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:save_us_starmax/save_us_starmax.dart';
import 'package:save_us_starmax/save_us_starmax_platform_interface.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(
    fileName: '.env',
  );

  runApp(MyApp(
    prefs: await SharedPreferences.getInstance(),
  ));


}

Future<void> requestPermissions() async {
  if (Platform.isIOS) {
    await [
      Permission.bluetooth,
      Permission.locationWhenInUse,
    ].request();
  } else if (Platform.isAndroid) {
    await [
      Permission.bluetooth,
      Permission.location,
    ].request();
  }
}



class MyApp extends StatefulWidget {
  const MyApp({
    super.key,
    this.prefs,
  });
  final SharedPreferences? prefs;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _saveUsStarmaxPlugin = SaveUsStarmax();
  static const platform = MethodChannel('save_us_starmax');

  @override
  void initState() {
    super.initState();
    requestPermissions();
    // requestPermissionForAndroid();
    FlutterBluePlus.events.onConnectionStateChanged.listen((cs) {
      final status = cs.connectionState == BluetoothConnectionState.connected;

      if (!status) {
        if (kDebugMode) {
          print('onConnectionStateChanged:: ${cs.device.advName}');
        }
      }
      _connectionState = cs.connectionState;

      if (_connectionState == BluetoothConnectionState.connected) {
        _sendDeviceInfoToNative(cs.device);
      }
    });

    FlutterBluePlus.scanResults.listen((results) {
      for (final result in results) {
        if (BluetoothConnectionState.disconnected == _connectionState) {
          if (kDebugMode) {
            // print('scanResult:: ${result.device.advName}');
          }
          if (!_devices.any((e) => e.advName == result.device.advName)) {
            setState(() => _devices.add(result.device));
          }
        }
      }
      if (kDebugMode) {
        // print('scanResults:: ${results.length}');
      }
    });

    FlutterBluePlus.isScanning.listen(
          (state) {
        if (kDebugMode) {
          print('isScanning:: $state');
        }
      },
    );

    // 페어링 하고 난 후 여기로 옴.
    FlutterBluePlus.events.onMtuChanged.listen((mtu) async {
      print("Flutter onMtuChanged" + mtu.toString());
      for (final s in (await mtu.device.discoverServices())
          .where((e) => e.serviceUuid == Guid(_serviceUuid))) {
        for (final c in s.characteristics.where(
                (e) => e.characteristicUuid == Guid(_notifyCharacteristicUUID))) {
          for (final d in c.descriptors) {
            try {
              // Ios 에서는 주석을 해야 됨
              if(Platform.isAndroid){
                await d.write([1, 0]);
              }
            } catch (error) {
              if (error is FlutterBluePlusException) {
                switch (error.code) {
                  case 133:
                    break;
                }
                if (kDebugMode) {
                  print('onMtuChanged:: $error');
                }
              } else {
                rethrow;
              }
            }
          }
          if (await c.setNotifyValue(true)) {
            if (kDebugMode) {
              print(
                'authenticatedSignedWrites: ${c.properties.authenticatedSignedWrites}',
              );
            }
            return;
          }
        }
      }
    });

    FlutterBluePlus.events.onDiscoveredServices.listen((ds) async {
      if (kDebugMode) {
        print('onDiscoveredServices:: ${ds.services.length}');
      }
    });

    // 여기서 받아서 파싱 시작.
    FlutterBluePlus.events.onCharacteristicReceived.listen((cr) async {
      print("Notify 접근");
      final str = await _saveUsStarmaxPlugin.notify({
        'value': Uint8List.fromList(cr.value),
      });


      if (str != null && str.isNotEmpty) {
        final json = jsonDecode(str);

        String title = json['type'];

        switch (json['type']) {
          case 'Pair':
            break;

          case 'HealthDetail':
            break;

          case 'Power':
            break;

          case 'StepHistory':
            break;

          case 'BloodSugarHistory':
            break;

          case 'TempHistory':
            break;

          case 'MetHistory':
            break;

          case 'PressureHistory':
            break;

          case 'BloodOxygenHistory':
            break;

          case 'BloodPressureHistory':
            break;

          case 'HeartRateHistory':
            break;

          case 'SportHistory':
            break;

          case 'ValidHistoryDates':
            break;

          case 'GetHealthOpen':
            break;

          case 'GetState':
            break;

          case 'GetHeartRate':
            break;

          case 'Version':
            break;

          case 'SetUserInfo':
            break;

          case 'SetHeartRate':
            break;

          case 'SetState':
            break;

          case 'SetTime':
            break;

          case 'Reset':
            break;

          case 'GetNotDisturb':
            break;

          case 'SetNotDisturb':
            break;

          default:
            if (kDebugMode) {
              print('onCharacteristicReceived:: $json');

            }
            return;
        }
        if (kDebugMode) {
          print('$title:: ${json['json']}');
        }
      }
    });

    FlutterBluePlus.events.onCharacteristicWritten.listen((cw) async {
      if (kDebugMode) {
        print('onCharacteristicWritten:: ${cw.characteristic}');
      }
    });

    FlutterBluePlus.events.onDescriptorWritten.listen((dw) async {
      if (dw.descriptor.descriptorUuid ==
          Guid('00002902-0000-1000-8000-00805f9b34fb')) {
        for (final s in dw.descriptor.device.servicesList
            .where((e) => e.serviceUuid == Guid(_serviceUuid))) {
          for (final c in s.characteristics.where(
                  (e) => Guid(_writeCharacteristicsUuid) == e.characteristicUuid)) {
            try {
              final value = await SaveUsStarmaxPlatform.instance.pairing();

              if (value != null) {
                await c.write(value);

                return;
              }
            } catch (error) {
              if (kDebugMode) {
                print('pairing:: $error');
              }
            }
          }
        }
      }
    });
    _startScan();
  }

  Future<void> _sendDeviceInfoToNative(BluetoothDevice device) async {
    try {
      await platform.invokeMethod('deviceConnected', {
        'deviceId': device.id.id,
        'deviceName': device.name,
      });
    } on PlatformException catch (e) {
      if (kDebugMode) {
        print("Failed to send device info: '${e.message}'.");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin Starmax'),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [


              TextButton(
                onPressed: () async {
                  final starmaxArr = await _saveUsStarmaxPlugin.getVersion();

                  if (starmaxArr != null) {
                    _request(_devices[_index], starmaxArr);
                  }
                  setState(() => _starmaxMap['Version'] = starmaxArr);
                },
                child: RichText(
                  text: TextSpan(
                    text: 'Version',
                    style: _textStyle(),
                    children: [TextSpan(text: ' ${_starmaxMap['Version']}')],
                  ),
                ),
              ),

/*              TextButton(
                onPressed: () async {
                  final healthData = await _saveUsStarmaxPlugin.getHealthData();
                  if (healthData != null) {
                    _request(_devices[_index], healthData);
                  }
                  setState(() => _starmaxMap['HealthData'] = healthData);
                },
                child: RichText(
                  text: TextSpan(
                    text: 'HealthData',
                    style: _textStyle(),
                    children: [TextSpan(text: ' ${_starmaxMap['HealthData']}')],
                  ),
                ),
              ),*/

              TextButton(
                onPressed: () async {
                  final powerData = await _saveUsStarmaxPlugin.getPower();
                  if (powerData != null) {
                    _request(_devices[_index], powerData);
                  }
                  setState(() => _starmaxMap['PowerData'] = powerData);
                },
                child: RichText(
                  text: TextSpan(
                    text: 'PowerData',
                    style: _textStyle(),
                    children: [TextSpan(text: ' ${_starmaxMap['PowerData']}')],
                  ),
                ),
              ),

/*              TextButton(
                onPressed: () async {
                  final sportHistoryData = await _saveUsStarmaxPlugin.getSportHistory();
                  if (sportHistoryData != null) {
                    _request(_devices[_index], sportHistoryData);
                  }
                  setState(() => _starmaxMap['SportHistory'] = sportHistoryData);
                },
                child: RichText(
                  text: TextSpan(
                    text: 'SportHistory',
                    style: _textStyle(),
                    children: [TextSpan(text: ' ${_starmaxMap['SportHistory']}')],
                  ),
                ),
              ),*/

/*              TextButton(
                onPressed: () async {
                  final stepHistoryData = await _saveUsStarmaxPlugin.getStepHistory({
                    'year': 2024,
                    'month': 7,
                    'date': 8,
                    'hour': 0,
                    'minute': 0,
                    'second': 0,
                  });
                  if (stepHistoryData != null) {
                    _request(_devices[_index], stepHistoryData);
                  }
                  setState(() => _starmaxMap['StepHistory'] = stepHistoryData);
                },
                child: RichText(
                  text: TextSpan(
                    text: 'StepHistory',
                    style: _textStyle(),
                    children: [TextSpan(text: ' ${_starmaxMap['StepHistory']}')],
                  ),
                ),
              ),*/

/*              TextButton(
                onPressed: () async {
                  final bloodPressureHistoryData = await _saveUsStarmaxPlugin.getBloodPressureHistory({
                    'year': 2024,
                    'month': 7,
                    'date': 8,
                    'hour': 0,
                    'minute': 0,
                    'second': 0,
                  });
                  if (bloodPressureHistoryData != null) {
                    _request(_devices[_index], bloodPressureHistoryData);
                  }
                  setState(() => _starmaxMap['BloodPressureHistory'] = bloodPressureHistoryData);
                },
                child: RichText(
                  text: TextSpan(
                    text: 'BloodPressureHistory',
                    style: _textStyle(),
                    children: [TextSpan(text: ' ${_starmaxMap['BloodPressureHistory']}')],
                  ),
                ),
              ),*/

/*              TextButton(
                onPressed: () async {
                  final bloodOxygenHistoryData = await _saveUsStarmaxPlugin.getBloodOxygenHistory({
                    'year': 2024,
                    'month': 7,
                    'date': 8,
                    'hour': 0,
                    'minute': 0,
                    'second': 0,
                  });
                  if (bloodOxygenHistoryData != null) {
                    _request(_devices[_index], bloodOxygenHistoryData);
                  }
                  setState(() => _starmaxMap['BloodOxygenHistory'] = bloodOxygenHistoryData);
                },
                child: RichText(
                  text: TextSpan(
                    text: 'BloodOxygenHistory',
                    style: _textStyle(),
                    children: [TextSpan(text: ' ${_starmaxMap['BloodOxygenHistory']}')],
                  ),
                ),
              ),*/

/*              TextButton(
                onPressed: () async {
                  final pressureHistoryData = await _saveUsStarmaxPlugin.getPressureHistory({
                    'year': 2024,
                    'month': 7,
                    'date': 8,
                    'hour': 0,
                    'minute': 0,
                    'second': 0,
                  });
                  if (pressureHistoryData != null) {
                    _request(_devices[_index], pressureHistoryData);
                  }
                  setState(() => _starmaxMap['PressureHistory'] = pressureHistoryData);
                },
                child: RichText(
                  text: TextSpan(
                    text: 'PressureHistory',
                    style: _textStyle(),
                    children: [TextSpan(text: ' ${_starmaxMap['PressureHistory']}')],
                  ),
                ),
              ),*/


           /*   TextButton(
                onPressed: () async {
                  final metHistoryData = await _saveUsStarmaxPlugin.getMetHistory({
                    'year': 2024,
                    'month': 7,
                    'date': 8,
                    'hour': 0,
                    'minute': 0,
                    'second': 0,
                  });
                  if (metHistoryData != null) {
                    _request(_devices[_index], metHistoryData);
                  }
                  setState(() => _starmaxMap['MetHistory'] = metHistoryData);
                },
                child: RichText(
                  text: TextSpan(
                    text: 'MetHistory',
                    style: _textStyle(),
                    children: [TextSpan(text: ' ${_starmaxMap['MetHistory']}')],
                  ),
                ),
              ),*/

       /*       TextButton(
                onPressed: () async {
                  final tempHistoryData = await _saveUsStarmaxPlugin.getTempHistory({
                    'year': 2024,
                    'month': 7,
                    'date': 8,
                    'hour': 0,
                    'minute': 0,
                    'second': 0,
                  });
                  if (tempHistoryData != null) {
                    _request(_devices[_index], tempHistoryData);
                  }
                  setState(() => _starmaxMap['TempHistory'] = tempHistoryData);
                },
                child: RichText(
                  text: TextSpan(
                    text: 'TempHistory',
                    style: _textStyle(),
                    children: [TextSpan(text: ' ${_starmaxMap['TempHistory']}')],
                  ),
                ),
              )*/

         /*     TextButton(
                onPressed: () async {
                  final longSitData = await _saveUsStarmaxPlugin.getLongSit();
                  if (longSitData != null) {
                    _request(_devices[_index], longSitData);
                  }
                  setState(() => _starmaxMap['LongSitData'] = longSitData);
                },
                child: RichText(
                  text: TextSpan(
                    text: 'LongSitData',
                    style: _textStyle(),
                    children: [TextSpan(text: ' ${_starmaxMap['LongSitData']}')],
                  ),
                ),
              ),*/

/*              TextButton(
                onPressed: () async {
                  final drinkWaterData = await _saveUsStarmaxPlugin.getDrinkWater();
                  if (drinkWaterData != null) {
                    _request(_devices[_index], drinkWaterData);
                  }
                  setState(() => _starmaxMap['DrinkWaterData'] = drinkWaterData);
                },
                child: RichText(
                  text: TextSpan(
                    text: 'DrinkWaterData',
                    style: _textStyle(),
                    children: [TextSpan(text: ' ${_starmaxMap['DrinkWaterData']}')],
                  ),
                ),
              ),*/

/*              TextButton(
                onPressed: () async {
                  final result = await _saveUsStarmaxPlugin.setLongSit({
                    'onOff': true,
                    'startHour': 9,
                    'startMinute': 30,
                    'endHour': 21,
                    'endMinute': 30,
                    'interval': 15,
                  });
                  if (result != null) {
                    setState(() => _starmaxMap['SetLongSit'] = result);
                  }
                },
                child: RichText(
                  text: TextSpan(
                    text: 'SetLongSit',
                    style: _textStyle(),
                    children: [TextSpan(text: ' ${_starmaxMap['SetLongSit']}')],
                  ),
                ),
              ),*/

 /*             TextButton(
                onPressed: () async {
                  final result = await _saveUsStarmaxPlugin.setDrinkWater({
                    'onOff': true,
                    'startHour': 9,
                    'startMinute': 30,
                    'endHour': 21,
                    'endMinute': 30,
                    'interval': 15,
                  });
                  if (result != null) {
                    setState(() => _starmaxMap['SetDrinkWater'] = result);
                  }
                },
                child: RichText(
                  text: TextSpan(
                    text: 'SetDrinkWater',
                    style: _textStyle(),
                    children: [TextSpan(text: ' ${_starmaxMap['SetDrinkWater']}')],
                  ),
                ),
              ),*/

 /*             TextButton(
                onPressed: () async {
                  final result = await _saveUsStarmaxPlugin.setNotDisturb({
                    'onOff': true,
                    'allDayOnOff': false,
                    'startHour': 9,
                    'startMinute': 30,
                    'endHour': 21,
                    'endMinute': 30,
                  });
                  if (result != null) {
                    setState(() => _starmaxMap['SetNotDisturb'] = result);
                  }
                },
                child: RichText(
                  text: TextSpan(
                    text: 'SetNotDisturb',
                    style: _textStyle(),
                    children: [TextSpan(text: ' ${_starmaxMap['SetNotDisturb']}')],
                  ),
                ),
              ),*/

/*              TextButton(
                onPressed: () async {
                  final userInfo = await _saveUsStarmaxPlugin.setUserInfo({
                    'sex': 0,
                    'age': 20,
                    'height': 170,
                    'weight': 60,
                  });
                  if (userInfo != null) {
                    _request(_devices[_index], userInfo);
                  }
                  setState(() => _starmaxMap['UserInfo'] = userInfo);
                },
                child: RichText(
                  text: TextSpan(
                    text: 'UserInfo',
                    style: _textStyle(),
                    children: [TextSpan(text: ' ${_starmaxMap['UserInfo']}')],
                  ),
                ),
              ),*/

           /*   TextButton(
                onPressed: () async {
                  final stateData = await _saveUsStarmaxPlugin.setState({
                    'timeFormat': 1,
                    'unitFormat': 0,
                    'tempFormat': 0,
                    'language': 9,
                    'backlighting': 15,
                    'screen': 70,
                    'wristUp': true
                  });
                  if (stateData != null) {
                    _request(_devices[_index], stateData);
                  }
                  setState(() => _starmaxMap['StateData'] = stateData);
                },
                child: RichText(
                  text: TextSpan(
                    text: 'StateData',
                    style: _textStyle(),
                    children: [TextSpan(text: ' ${_starmaxMap['StateData']}')],
                  ),
                ),
              ),*/

/*              TextButton(
                onPressed: () async {
                  final setTimeResult = await _saveUsStarmaxPlugin.setTime();
                  if (setTimeResult != null) {
                    print('setTime result: $setTimeResult');
                    // _request(_devices[_index], setTimeResult); // 필요한 경우 요청 수행
                  }
                  setState(() => _starmaxMap['SetTime'] = setTimeResult);
                },
                child: RichText(
                  text: TextSpan(
                    text: 'SetTime',
                    style: _textStyle(),
                    children: [TextSpan(text: ' ${_starmaxMap['SetTime']}')],
                  ),
                ),
              ),*/

/*              TextButton(
                onPressed: () async {
                  final resetResult = await _saveUsStarmaxPlugin.reset();
                  if (resetResult != null) {
                    print('Reset result: $resetResult');
                    // _request(_devices[_index], resetResult); // 필요한 경우 요청 수행
                  }
                  setState(() => _starmaxMap['Reset'] = resetResult);
                },
                child: RichText(
                  text: TextSpan(
                    text: 'Reset',
                    style: _textStyle(),
                    children: [TextSpan(text: ' ${_starmaxMap['Reset']}')],
                  ),
                ),
              ),*/

/*              TextButton(
                onPressed: () async {
                  final pairResult = await _saveUsStarmaxPlugin.pairing();
                  if (pairResult != null) {
                    print('Pair result: $pairResult');
                    // _request(_devices[_index], pairResult); // 필요한 경우 요청 수행
                  }
                  setState(() => _starmaxMap['Pair'] = pairResult);
                },
                child: RichText(
                  text: TextSpan(
                    text: 'Pair',
                    style: _textStyle(),
                    children: [TextSpan(text: ' ${_starmaxMap['Pair']}')],
                  ),
                ),
              ),*/




              TextButton(
                onPressed: () async {
                  final starmaxArr =
                  await _saveUsStarmaxPlugin.getValidHistoryDates(
                    /* HistoryType : kotlin.Enum<com.starmax.bluetoothsdk.data.HistoryType>
                      Sport = 0,
                      Step = 1,
                      HeartRate = 2,
                      BloodPressure = 3,
                      BloodOxygen = 4,
                      Pressure = 5,
                      Met = 6,
                      Temp = 7,
                      Mai = 8,
                      BloodSugar = 9
                    */
                    {'historyType': 9},
                  );
                  if (starmaxArr != null) {
                    _request(_devices[_index], starmaxArr);
                  }
                  setState(() => _starmaxMap['ValidHistoryDates'] = starmaxArr);
                },
                child: RichText(
                  text: TextSpan(
                    text: 'ValidHistoryDates',
                    style: _textStyle(),
                    children: [
                      TextSpan(text: ' ${_starmaxMap['ValidHistoryDates']}')
                    ],
                  ),
                ),
              ),
              TextButton(
                onPressed: () async {
                  final starmaxArr =
                  await _saveUsStarmaxPlugin.getHeartRateHistory({
                    'year': 2024,
                    'month': 7,
                    'date': 8,
                    'hour': 0,
                    'minute': 0,
                    'second': 0,
                  });
                  if (starmaxArr != null) {
                    await _request(_devices[_index], starmaxArr);
                  }
                  setState(() => _starmaxMap['HeartRateHistory'] = starmaxArr);
                },
                child: RichText(
                  text: TextSpan(
                    text: 'HeartRateHistory',
                    style: _textStyle(),
                    children: [
                      TextSpan(text: ' ${_starmaxMap['HeartRateHistory']}')
                    ],
                  ),
                ),
              ),
              TextButton(
                onPressed: () async {
                  final starmaxArr =
                  await _saveUsStarmaxPlugin.getBloodSugarHistory({
                    'year': 2024,
                    'month': 2,
                    'date': 27,
                    'hour': 0,
                    'minute': 0,
                    'second': 0,
                  });
                  if (starmaxArr != null) {
                    await _request(_devices[_index], starmaxArr);
                  }
                  setState(() => _starmaxMap['BloodSugarHistory'] = starmaxArr);
                },
                child: RichText(
                  text: TextSpan(
                    text: 'BloodSugarHistory',
                    style: _textStyle(),
                    children: [
                      TextSpan(text: ' ${_starmaxMap['BloodSugarHistory']}')
                    ],
                  ),
                ),
              ),
              TextButton(
                onPressed: () async {
                  final starmaxArr = await _saveUsStarmaxPlugin.getState();

                  if (starmaxArr != null) {
                    _request(_devices[_index], starmaxArr);
                  }
                  setState(() => _starmaxMap['State'] = starmaxArr);
                },
                child: RichText(
                  text: TextSpan(
                    text: 'State',
                    style: _textStyle(),
                    children: [TextSpan(text: ' ${_starmaxMap['State']}')],
                  ),
                ),
              ),
              TextButton(
                onPressed: () async {
                  final starmaxArr = await _saveUsStarmaxPlugin.getNotDisturb();

                  if (starmaxArr != null) {
                    _request(_devices[_index], starmaxArr);
                  }
                  setState(() => _starmaxMap['getNotDisturb'] = starmaxArr);
                },
                child: RichText(
                  text: TextSpan(
                    text: 'getNotDisturb',
                    style: _textStyle(),
                    children: [
                      TextSpan(text: ' ${_starmaxMap['getNotDisturb']}')
                    ],
                  ),
                ),
              ),
              TextButton(
                onPressed: () async {
                  final starmaxArr = await _saveUsStarmaxPlugin.setNotDisturb({
                    'onOff': false,
                    'allDayOnOff': false,
                    'startHour': 0,
                    'startMinute': 0,
                    'endHour': 23,
                    'endMinute': 59
                  });
                  if (starmaxArr != null) {
                    _request(_devices[_index], starmaxArr);
                  }
                  setState(() => _starmaxMap['setNotDisturb'] = starmaxArr);
                },
                child: RichText(
                  text: TextSpan(
                    text: 'setNotDisturb',
                    style: _textStyle(),
                    children: [
                      TextSpan(text: ' ${_starmaxMap['setNotDisturb']}')
                    ],
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    return TextButton(
                      onPressed: () async {
                        await _connect(_devices[index]);
                        _index = index;
                      },
                      child: Text(_devices[index].advName),
                    );
                  },
                  itemCount: _devices.length,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  _textStyle() {
    return const TextStyle(color: Color(0xFF696969));
  }

  Future _request(BluetoothDevice device, Uint8List value) async {
      for (final s in (await device.discoverServices())
          .where((e) => e.serviceUuid == Guid(_serviceUuid))) {
        for (final c in s.characteristics.where(
                (e) => Guid(_writeCharacteristicsUuid) == e.characteristicUuid)) {
          try {
            await c.write(value);
          } catch (error) {
            if (kDebugMode) {
              print('$value:: $error');
            }
          }
        }
      }
  }

  Future _startScan() async {
    while (SaveUsStarmaxPlatform.instance.hashCode > 0) {
      if (BluetoothConnectionState.disconnected == _connectionState) {
        await FlutterBluePlus.startScan(
          // withMsd: [
          //   MsdFilter(
          //     24576,
          //     data: [66, 75, 45, 66, 76, 69],
          //   )
          // ],
          timeout: const Duration(seconds: 7),
        );
      }
      await Future.delayed(const Duration(seconds: 9));
    }
  }

  Future _stopScan() async {
    await FlutterBluePlus.stopScan();
  }

  Future _connect(BluetoothDevice device) async {
    _streamConnectionState = device.connectionState.listen(
          (BluetoothConnectionState state) async {
        if (state == BluetoothConnectionState.disconnected) {
          if (kDebugMode) {
            print(
              "${device.disconnectReason?.code} ${device.disconnectReason?.description}",
            );
          }
        }
        _connectionState = state;
      },
    );
    device.cancelWhenDisconnected(
      _streamConnectionState,
      delayed: true,
      next: true,
    );
    while (BluetoothConnectionState.disconnected == _connectionState) {
      try {
        await device.connect();

        if (kDebugMode) {
          print('Connected to the device successfully');
        }
        await _stopScan();
      } catch (error) {
        if (kDebugMode) {
          print('Error occurred during connection: $error');
        }
        if (error is FlutterBluePlusException) {
          switch (error.code) {
            case 133:
              if (kDebugMode) {
                print('Retrying connection...');
              }
              break;

            case 6:
              if (kDebugMode) {
                print('Device is disconnected.');
              }
              break;
          }
        } else {
          if (kDebugMode) {
            print('\x1B[31mconnecting: $error\x1B[0m');
          }
          rethrow;
        }
      } finally {
        await Future.delayed(const Duration(milliseconds: 512));
      }
    }
  }


  Future requestPermissionForAndroid() async {
    final androidInfo = await DeviceInfoPlugin().androidInfo;

    if (kDebugMode) {
      print('androidInfo:: $androidInfo');
    }
    switch (androidInfo.version.sdkInt) {
      case > 30:
        if (!await Permission.bluetoothScan.isGranted) {
          final bluetoothScanGrant =
          await Permission.bluetoothScan.request().isGranted;

          if (kDebugMode) {
            print('bluetoothScanGrant:: $bluetoothScanGrant');
          }
        }
        if (!await Permission.bluetoothConnect.isGranted) {
          final bluetoothConnectGrant =
          await Permission.bluetoothConnect.request().isGranted;

          if (kDebugMode) {
            print('bluetoothConnectGrant:: $bluetoothConnectGrant');
          }
        }
        break;

      default:
        if (!await Permission.bluetooth.isGranted) {
          final bluetoothGrant = await Permission.bluetooth.request().isGranted;

          if (kDebugMode) {
            print('bluetoothGrant:: $bluetoothGrant');
          }
        }
        if (!await Permission.location.isGranted) {
          final locationGrant = await Permission.location.request().isGranted;

          if (kDebugMode) {
            print('locationGrant:: $locationGrant');
          }
        }
        break;
    }
  }

  int _index = 0;

  BluetoothConnectionState _connectionState = BluetoothConnectionState.disconnected;

  late StreamSubscription<BluetoothConnectionState> _streamConnectionState;

  final String _serviceUuid = dotenv.env['SERVICE']!;
  final String _notifyCharacteristicUUID = dotenv.env['NOTIFYCHARACTERISTIC']!;
  final String _writeCharacteristicsUuid = dotenv.env['WRITECHARACTERISTICS']!;

  final Map<String, Uint8List?> _starmaxMap = {};
  final List<BluetoothDevice> _devices = List.empty(growable: true);
}