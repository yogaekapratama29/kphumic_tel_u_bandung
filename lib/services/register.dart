// ignore_for_file: public_member_api_docs, sort_constructors_first
class RegisterRequest {
  final String fullname;
  final String nim;
  final String prodi;
  final String phoneNumber;
  final String email;
  final String password;
  RegisterRequest({
    required this.fullname,
    required this.nim,
    required this.prodi,
    required this.phoneNumber,
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toJson() {
    return {
      'full_name': fullname,
      'nim': nim,
      'prodi': prodi,
      'phone_number': phoneNumber,
      'email': email,
      'password': password,
    };
  }
}

class RegisterResponse {
  final String status;
  final String message;
  RegisterResponse({
    required this.status,
    required this.message,
  });

  factory RegisterResponse.fromJson(Map<String, dynamic> json) {
    return RegisterResponse(status: json['status'], message: json['message']);
  }
}
