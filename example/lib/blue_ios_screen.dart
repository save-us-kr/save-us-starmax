import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

class BluetoothScreen extends StatefulWidget {
  @override
  _BluetoothScreenState createState() => _BluetoothScreenState();
}

class _BluetoothScreenState extends State<BluetoothScreen> {
  FlutterBluePlus flutterBlue = FlutterBluePlus();
  List<DiscoveredDevice> connectedDevices = [];
  List<DiscoveredDevice> scannedDevices = [];
  DiscoveredDevice? selectedDevice;
  BluetoothConnectionState _connectionState = BluetoothConnectionState.disconnected;
  late StreamSubscription<BluetoothConnectionState> _streamConnectionState;
  bool isConnecting = false;
  bool isDisconnecting = false;

  @override
  void initState() {
    super.initState();
    startScanForDevices();
    checkConnectedDevices();
  }

  void startScanForDevices() {
    Timer.periodic(Duration(seconds: 2), (Timer timer) {
      FlutterBluePlus.startScan(timeout: Duration(seconds: 2));
      print("Scanning for devices...");
    });

    FlutterBluePlus.scanResults.listen((results) {
      for (ScanResult result in results) {
        bool found = scannedDevices.any((device) => device.name == result.device.name);
        if (!found) {
          setState(() {
            scannedDevices.add(DiscoveredDevice(
              name: result.device.name,
              rssi: result.rssi,
              device: result.device,
            ));
          });
        } else {
          setState(() {
            scannedDevices.firstWhere((device) => device.name == result.device.name).rssi = result.rssi;
          });
        }
      }
    });
  }

  void checkConnectedDevices() async {
    List<BluetoothDevice> devices = await FlutterBluePlus.connectedDevices;
    devices.forEach((device) {
      setState(() {
        connectedDevices.add(DiscoveredDevice(
          name: device.name,
          rssi: 0, // 연결된 기기의 RSSI 값은 0으로 설정
          device: device,
        ));
      });
    });
  }

  void connectToDevice(String name) async {
    setState(() {
      isConnecting = true;
    });

    try {
      List<BluetoothDevice> connectedDevices = await FlutterBluePlus.connectedDevices;
      BluetoothDevice? device;

      try {
        device = connectedDevices.firstWhere((device) => device.name == name);
      } catch (e) {
        device = scannedDevices.firstWhere((device) => device.name == name).device;
      }

      if (device != null) {
        await device.connect();
        setState(() {
          selectedDevice = DiscoveredDevice(
            name: device!.name,
            rssi: 0, // 연결된 기기의 RSSI 값은 0으로 설정
            device: device,
          );
        });
        _streamConnectionState = device.state.listen((state) {
          setState(() {
            _connectionState = state;
          });
          if (state == BluetoothDeviceState.disconnected) {
            print("Device disconnected: ${device!.id}");
          }
        });
      }
    } catch (e) {
      print("Connection failed: $e");
    } finally {
      setState(() {
        isConnecting = false;
      });
    }
  }

  Future<void> disconnectFromDevice() async {
    setState(() {
      isDisconnecting = true;
    });

    if (selectedDevice != null) {
      await selectedDevice!.device.disconnect();
      setState(() {
        selectedDevice = null;
      });
      _streamConnectionState?.cancel();
    }

    setState(() {
      isDisconnecting = false;
    });
  }

  void reconnectToDevice() async {
    if (selectedDevice != null) {
      await selectedDevice!.device.connect();
    }
  }

  @override
  void dispose() {
    _streamConnectionState?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Bluetooth Device Selection'),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (connectedDevices.isNotEmpty) ...[
              Text(
                'Connected Devices:',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: connectedDevices.map((device) {
                  return ListTile(
                    title: Text(device.name),
                    subtitle: Text('RSSI: ${device.rssi}'),
                  );
                }).toList(),
              ),
              Divider(),
            ],
            Text(
              'Scanned Devices:',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 4),
            Expanded(
              child: ListView.builder(
                itemCount: scannedDevices.length,
                itemBuilder: (context, index) {
                  DiscoveredDevice device = scannedDevices[index];
                  return ListTile(
                    title: Text(device.name),
                    subtitle: Text('RSSI: ${device.rssi}'),
                    onTap: () => connectToDevice(device.name),
                  );
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // 연결 버튼
                ElevatedButton(
                  onPressed: selectedDevice != null ? null : () => connectToDevice(selectedDevice!.name),
                  child: Text('Connect'),
                ),
                // 연결 해제 버튼
                ElevatedButton(
                  onPressed: selectedDevice == null ? null : disconnectFromDevice,
                  child: Text('Disconnect'),
                ),
                // 재연결 버튼
                ElevatedButton(
                  onPressed: selectedDevice == null ? null : reconnectToDevice,
                  child: Text('Reconnect'),
                ),
              ],
            ),
            if (isConnecting || isDisconnecting) CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}

class DiscoveredDevice {
  final String name;
  int rssi;
  final BluetoothDevice device;

  DiscoveredDevice({
    required this.name,
    required this.rssi,
    required this.device,
  });
}
