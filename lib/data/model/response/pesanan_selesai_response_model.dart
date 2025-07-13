class UploadBuktiResponse {
  final String message;
  final int statusCode;
  final UploadBuktiData data;

  UploadBuktiResponse({
    required this.message,
    required this.statusCode,
    required this.data,
  });

  factory UploadBuktiResponse.fromJson(Map<String, dynamic> json) {
    return UploadBuktiResponse(
      message: json['message'],
      statusCode: json['status_code'],
      data: UploadBuktiData.fromJson(json['data']),
    );
  }
}

class UploadBuktiData {
  final int id;
  final String fotoBuktiSelesai;
  final String status;

  UploadBuktiData({
    required this.id,
    required this.fotoBuktiSelesai,
    required this.status,
  });

  factory UploadBuktiData.fromJson(Map<String, dynamic> json) {
    return UploadBuktiData(
      id: json['id'],
      fotoBuktiSelesai: json['foto_bukti_selesai'],
      status: json['status'],
    );
  }
}
