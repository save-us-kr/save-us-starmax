//
//  ScanDeviceViewController.swift
//  Runner
//
//  Created by 주승현 on 6/12/24.
//

import Foundation
import UIKit

class ScanDeviceViewController: UIViewController {
    var devices = [ZHJBTDevice]()
    lazy var tableView : UITableView = {
        let table = UITableView.init(frame: view.frame, style: .plain)
        table.tableFooterView = UIView()
        //table.plainDefaultHeaderSpace(10)
        table.delegate = self
        table.dataSource = self
        return table
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        print("Scan device")
        self.view.addSubview(tableView)
        if ZHJBLEManagerProvider.shared.btManager?.state == .poweredOn {
            self.scanDevice(seconds: 5.0)
        }
        bluetoothPrepare()
     
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    
    //开始准备搜索(Start preparing to scan the device)
    func bluetoothPrepare() {
        ZHJBLEManagerProvider.shared.bluetoothProviderManagerStateDidUpdate {[weak self] (state) in
            guard let `self` = self else { return }
            print(state)
            if state == .poweredOn {
                delay(by: 1.0) {
                    self.scanDevice(seconds: 5.0)
                }
            }
        }
    }
    // 搜索设备
    func scanDevice(seconds: Double) {
        ZHJBLEManagerProvider.shared.scan(seconds: seconds) {[weak self] (devices) in
            guard let `self` = self else { return }
            self.devices = devices
            self.tableView.reloadData()
        }
    }
    
    //停止搜索设备(Stop scan)
    func stopScan() {
        ZHJBLEManagerProvider.shared.stopScan()
    }


}
extension ScanDeviceViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return devices.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell.init(style: .value1, reuseIdentifier: "cell")
        let deivce = devices[indexPath.row]
        cell.textLabel?.text = deivce.name
        cell.detailTextLabel?.text = deivce.mac == "" ? "可连接" : "\(deivce.rssi) dBm"
        cell.accessoryType = .none
        cell.textLabel?.textColor = .gray
        cell.textLabel?.numberOfLines = 2
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let deivce = devices[indexPath.row]
        ZHJBLEManagerProvider.shared.connectDevice(device: deivce) { (p) in
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0, execute: {
                self.navigationController?.popViewController(animated: true)
            })
        } fail: { (p, err) in
            print("Connect failed")
        } timeout: {
            print("Connect timeout")        }
    }
    
}
