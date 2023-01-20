import 'package:intl/intl.dart';

class globalVars {
  static final globalVars _instance = globalVars._internal();

  late var _currentBatteryLevel = 0;
  late var _targetBatteryLevel = 0;
  late double _currentLevel = 10.0;
  late double _voltLevel = 110.00;
  late var _batteryCapacity = 0;
  late bool _isEcoCharging = true;
  late String _chargingTime =
      DateFormat("hh:mm:ss").format(DateTime(2022, 11, 14, 12, 9));

  late bool _isChargerAdded = false;
  // passes the instantiation to the _instance object
  factory globalVars() => _instance;

  //initialize variables in here
  globalVars._internal() {}

  //short getter for my variable
  int get currentBatteryLevel => _currentBatteryLevel;

  //short setter for my variable
  void setCurrentBatteryLevel(int value) {
    _currentBatteryLevel = value;
  }

  //short getter for my variable
  int get targetBatteryLevel => _targetBatteryLevel;

  //short setter for my variable
  void setTargetBatteryLevel(int value) {
    _targetBatteryLevel = value;
  }

  //short getter for my variable
  double get currentLevel => _currentLevel;

  //short setter for my variable
  void setCurrentLevel(double value) {
    _currentLevel = value;
  }

  //short getter for my variable
  double get voltLevel => _voltLevel;

  //short setter for my variable
  void setVoltLevel(double value) {
    _voltLevel = value;
  }

  //short getter for my variable
  int get batteryCapacity => _batteryCapacity;

  //short setter for my variable
  void setBatteryCapacity(int value) {
    _batteryCapacity = value;
  }

  //short getter for time
  String get chargingStartTime => _chargingTime;

  //short setter for time
  void setChargingStartTime(String value) {
    _chargingTime = value;
  }

  //short getter for ecoCharging
  bool get ecoCharging => _isEcoCharging;

  //short setter for ecoCharging
  void setEcoCharging(bool value) {
    _isEcoCharging = value;
  }

  //short getter for isChargerAdded
  bool get isCharger => _isChargerAdded;

  //short setter for isChargerAdded
  void setIsCharger(bool value) {
    _isChargerAdded = value;
  }

  Map<String, dynamic> createJson() {
    Map<String, dynamic> deviceInfo = {
      "batteryCapacity": _batteryCapacity,
      "currentBatteryLevel": _currentBatteryLevel,
      "targetBatteryLevel": _targetBatteryLevel,
      "currentLevel": _currentLevel,
      "voltLevel": _voltLevel,
      "chargingStartTime": _chargingTime,
      "isEcoCharging": _isEcoCharging
    };

    return deviceInfo;
  }
}
