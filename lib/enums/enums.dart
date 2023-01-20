// charging mode enum
import 'package:soneilcharging/Pages/home.dart';

enum ChargingMode {
  Immediately,
  Scheduled,
  Disabled,
}

// peektable used for storing column names
Map<String, String> peakColumns = {
  'PeakName': 'Peak Name',
  'ChargingHrs': 'Charging Hours',
  'Price': 'Price (in cents)',
  'Start': 'Start',
  'End': 'End'
};
