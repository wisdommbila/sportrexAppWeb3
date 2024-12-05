
class CreateWalletResponse {
  bool? success;
  String? message;
  Data? data;

  CreateWalletResponse({this.success, this.message, this.data});

  CreateWalletResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? seedPhrase;

  Data({this.seedPhrase});

  Data.fromJson(Map<String, dynamic> json) {
    seedPhrase = json['seedPhrase'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['seedPhrase'] = seedPhrase;
    return data;
  }
}