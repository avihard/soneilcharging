// this class holds the value for data coming from API
class chargingHistoryInterface {
  final double chargingTime, chargingPrice;

  final String chargingDate, startTime, endTime;

  chargingHistoryInterface(this.chargingTime, this.chargingPrice,
      this.chargingDate, this.startTime, this.endTime);

  chargingHistoryInterface.fromJson(Map<String, dynamic> json)
      : chargingTime = json['chargingTime'],
        chargingPrice = json['chargingPrice'],
        chargingDate = json['chargingDate'],
        startTime = json['startTime'],
        endTime = json['endTime'];

  Map<String, dynamic> toJson() => {
        'chargingTime': chargingTime,
        'chargingPrice': chargingPrice,
        'chargingDate': chargingDate,
        'startTime': startTime,
        'endTime': endTime
      };
}
