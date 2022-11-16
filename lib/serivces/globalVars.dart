import 'package:intl/intl.dart';

class globalVars {
  static final globalVars _instance = globalVars._internal();

  late var _currentBatteryLevel;
  late var _targetBatteryLevel;
  late var _currentLevel;
  late var _voltLevel;
  late var _batteryCapacity;
  late bool _isEcoCharging = true;
  late String _chargingTime =
      DateFormat("hh:mm:ss").format(DateTime(2022, 11, 14, 12, 9));
  // passes the instantiation to the _instance object
  factory globalVars() => _instance;

  //initialize variables in here
  globalVars._internal() {
    _currentBatteryLevel = 0;
    _currentLevel = 0;
  }

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
  int get currentLevel => _currentLevel;

  //short setter for my variable
  void setCurrentLevel(int value) {
    _currentLevel = value;
  }

  //short getter for my variable
  int get voltLevel => _voltLevel;

  //short setter for my variable
  void setVoltLevel(int value) {
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
