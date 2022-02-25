class Order {
  Order(
      {this.orderId, this.status, this.currency, this.amount, this.timeSlotId});
  String? orderId;
  String? status;
  String? currency;
  int? amount;
  String? timeSlotId;
  static const String _orderId = 'orderId';
  static const String _status = 'status';
  static const String _currency = 'currency';
  static const String _amount = 'amount';
  static const String _timeSlotId = 'timeSlotId';
  factory Order.fromMap(Map<String, dynamic> map) {
    return Order(
        orderId: map[_orderId],
        status: map[_status],
        currency: map[_currency],
        amount: map[_amount],
        timeSlotId: map[_timeSlotId]);
  }
}
