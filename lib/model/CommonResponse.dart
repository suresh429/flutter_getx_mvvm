/// status : "success"
/// statusCode : 200
/// message : "request successfully unfavourite"
/// data : {}

class CommonResponse {
  CommonResponse({
    String? status,
    num? statusCode,
    String? message,
    dynamic data,
  }) {
    _status = status;
    _statusCode = statusCode;
    _message = message;
    _data = data;
  }

  CommonResponse.fromJson(dynamic json) {
    _status = json['status'];
    _statusCode = json['statusCode'];
    _message = json['message'];
    _data = json['data'];
  }

  String? _status;
  num? _statusCode;
  String? _message;
  dynamic _data;

  CommonResponse copyWith({
    String? status,
    num? statusCode,
    String? message,
    dynamic data,
  }) =>
      CommonResponse(
        status: status ?? _status,
        statusCode: statusCode ?? _statusCode,
        message: message ?? _message,
        data: data ?? _data,
      );

  String? get status => _status;

  num? get statusCode => _statusCode;

  String? get message => _message;

  dynamic get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['statusCode'] = _statusCode;
    map['message'] = _message;
    map['data'] = _data;
    return map;
  }
}
