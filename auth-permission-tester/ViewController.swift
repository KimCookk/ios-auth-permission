//
//  ViewController.swift
//  auth-permission-simulator
//
//  Created by 김태성 on 2023/08/15.
//

/* Info Setting
 Privacy - Location Always and When In Use Usage Description : 11.0 +
 Privacy - Location Always Usage Description : ~ 10.0
 */
import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    let container: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .fillEqually
        stackView.axis = .vertical
        //stackView.spacing = 30
        
        return stackView
    }()
    
    let requestAlwaysLocationAuthButton: UIButton = {
        let button = UIButton()
        button.setTitle("Location Always Auth Request", for: .normal)
        button.backgroundColor = .lightGray
        return button
    }()
    
    let requestWhenInUseLocationAuthButton: UIButton = {
        let button = UIButton()
        button.setTitle("Location When In Use Auth Request", for: .normal)
        button.backgroundColor = .lightGray
        return button
    }()
    
    let checkLocationAuthButton: UIButton = {
        let button = UIButton()
        button.setTitle("Check Auth Request", for: .normal)
        button.backgroundColor = .lightGray
        return button
    }()
    
    let spacer: UIView = {
        let view = UIView()
        
        return view
    }()
    
    var locationManager: CLLocationManager?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager = CLLocationManager()
        locationManager?.delegate = self
        
        configureView()
        configureEvent()
        // Do any additional setup after loading the view.
    }
    
    func configureView() {
        view.backgroundColor = .white
        view.addSubview(container)
        
        container.translatesAutoresizingMaskIntoConstraints = false
        container.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        container.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        container.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        container.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5).isActive = true
        
        requestAlwaysLocationAuthButton.translatesAutoresizingMaskIntoConstraints = false
        container.addArrangedSubview(requestAlwaysLocationAuthButton)
        //container.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5).isActive = true
        requestAlwaysLocationAuthButton.heightAnchor.constraint(equalTo: container.heightAnchor, multiplier: 0.1).isActive = true
        
        requestWhenInUseLocationAuthButton.translatesAutoresizingMaskIntoConstraints = false
        container.addArrangedSubview(requestWhenInUseLocationAuthButton)
        //container.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5).isActive = true
        requestWhenInUseLocationAuthButton.heightAnchor.constraint(equalTo: container.heightAnchor, multiplier: 0.1).isActive = true
        
        checkLocationAuthButton.translatesAutoresizingMaskIntoConstraints = false
        container.addArrangedSubview(checkLocationAuthButton)
        //container.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5).isActive = true
        checkLocationAuthButton.heightAnchor.constraint(equalTo: container.heightAnchor, multiplier: 0.1).isActive = true
        
        spacer.translatesAutoresizingMaskIntoConstraints = false
        container.addArrangedSubview(spacer)
        //container.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5).isActive = true
    }
    
    func configureEvent() {
        requestAlwaysLocationAuthButton.addTarget(self, action: #selector(tappedRequestAlwaysLocationAuthButton), for: .touchUpInside)
        requestWhenInUseLocationAuthButton.addTarget(self, action: #selector(tappedRequestWhenInUseLocationAuthButton), for: .touchUpInside)
        checkLocationAuthButton.addTarget(self, action: #selector(tappedCheckLocationAuthButton), for: .touchUpInside)
    }
    
    @objc func tappedRequestAlwaysLocationAuthButton(sender: UIButton) {
        guard let locationManager = locationManager else {
            print("Location Manager is nil")
            return
        }
        //locationManager.requestWhenInUseAuthorization()
        
        locationManager.requestAlwaysAuthorization()
    }
    
    @objc func tappedRequestWhenInUseLocationAuthButton(sender: UIButton) {
        guard let locationManager = locationManager else {
            print("Location Manager is nil")
            return
        }
        locationManager.requestWhenInUseAuthorization()
        
        //locationManager.requestAlwaysAuthorization()
    }
    
    @objc func tappedCheckLocationAuthButton(sender: UIButton) {
        // 14.0 이후
        //        switch CLLocationManager.authorizationStatus() {
        //               case .authorizedAlways, .authorizedWhenInUse:
        //                   print("GPS: 권한 있음")
        //               case .restricted, .notDetermined:
        //                   print("GPS: 아직 선택하지 않음")
        //               case .denied:
        //                   print("GPS: 권한 없음")
        //               default:
        //                   print("GPS: Default")
        //        }
        
        guard let locationAuthStatus = getStatus() else {
            print("locationAuthStatus is nil")
            return
        }
        
        switch locationAuthStatus {
        case .notDetermined:
            print("권한이 결정되지 않았습니다.")
        case .restricted:
            print("위치 서비스가 제한되어 있는 상태 입니다.")
        case .denied:
            print("위치 서비스가 사용자에 의해 거부되었습니다.")
        case .authorizedAlways:
            print("위치 서비스가 항상 허용되었습니다.")
        case .authorizedWhenInUse:
            print("위치 서비스가 앱 사용하는 동안 허용되었습니다.")
        case .authorized:
            print("위치 서비스 권한이 허용 된 상태입니다.")
        @unknown default:
            fatalError()
        }
    }
    
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        guard let locationAuthStatus = getStatus() else {
            print("locationAuthStatus is nil")
            return
        }
        
        switch locationAuthStatus {
        case .notDetermined:
            print("권한이 결정되지 않았습니다.")
        case .restricted:
            print("위치 서비스가 제한되어 있는 상태 입니다.")
        case .denied:
            print("위치 서비스가 사용자에 의해 거부되었습니다.")
        case .authorizedAlways:
            print("위치 서비스가 항상 허용되었습니다.")
        case .authorizedWhenInUse:
            print("위치 서비스가 앱 사용하는 동안 허용되었습니다.")
        case .authorized:
            print("위치 서비스 권한이 허용 된 상태입니다.")
        @unknown default:
            fatalError()
        }
    }
    
    func getStatus() -> CLAuthorizationStatus? {
        return locationManager?.authorizationStatus
    }

}

