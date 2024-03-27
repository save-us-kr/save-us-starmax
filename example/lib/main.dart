import 'dart:async';
import 'dart:convert';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
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

class MyApp extends StatefulWidget {
  const MyApp({
    super.key,
    required this.prefs,
  });
  final SharedPreferences prefs;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _saveUsStarmaxPlugin = SaveUsStarmax();

  @override
  void initState() {
    super.initState();
    requestPermissionForAndroid();
    FlutterBluePlus.events.onConnectionStateChanged.listen((cs) {
      final status = cs.connectionState == BluetoothConnectionState.connected;

      if (!status) {
        if (kDebugMode) {
          print('onConnectionStateChanged:: ${cs.device.advName}');
        }
      }
      _connectionState = cs.connectionState;
    });
    FlutterBluePlus.scanResults.listen((results) {
      for (final result in results) {
        if (BluetoothConnectionState.disconnected == _connectionState) {
          if (kDebugMode) {
            print('scanResult:: ${result.device.advName}');
          }
          if (!_devices.any((e) => e.advName == result.device.advName)) {
            setState(() => _devices.add(result.device));
          }
        }
      }
      if (kDebugMode) {
        print('scanResults:: ${results.length}');
      }
    });
    FlutterBluePlus.isScanning.listen(
      (state) {
        if (kDebugMode) {
          print('isScanning:: $state');
        }
      },
    );

    FlutterBluePlus.events.onMtuChanged.listen((mtu) async {
      for (final s in (await mtu.device.discoverServices())
          .where((e) => e.serviceUuid == Guid(_serviceUuid))) {
        for (final c in s.characteristics.where(
            (e) => e.characteristicUuid == Guid(_notifyCharacteristicUUID))) {
          for (final d in c.descriptors) {
            try {
              await d.write([1, 0]);
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
    FlutterBluePlus.events.onCharacteristicReceived.listen((cr) async {
      final str = await SaveUsStarmaxPlatform.instance.notify({
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
                    'month': 3,
                    'date': 21,
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
                    'date': 21,
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
          withMsd: [
            MsdFilter(
              24576,
              data: [66, 75, 45, 66, 76, 69],
            )
          ],
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

  BluetoothConnectionState _connectionState =
      BluetoothConnectionState.disconnected;

  late StreamSubscription<BluetoothConnectionState> _streamConnectionState;

  final String _serviceUuid = dotenv.env['SERVICE']!;
  final String _notifyCharacteristicUUID = dotenv.env['NOTIFYCHARACTERISTIC']!;
  final String _writeCharacteristicsUuid = dotenv.env['WRITECHARACTERISTICS']!;

  final Map<String, Uint8List?> _starmaxMap = {};
  final List<BluetoothDevice> _devices = List.empty(growable: true);
}
