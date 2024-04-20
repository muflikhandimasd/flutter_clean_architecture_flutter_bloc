abstract class Failure {
  final String message;
  final int code;

  const Failure({
    required this.message,
    required this.code,
  });
}

class ServerFailure extends Failure {
  const ServerFailure({required super.message, required super.code});
}

class CacheFailure extends Failure {
  const CacheFailure({ super.message = messageInternal,  super.code = statusInternal});
}

class NoInternetFailure extends Failure {
  const NoInternetFailure(
      {super.message = messageInternet, super.code = statusInternet});
}

const messageInternal = 'Silakan Hubungi Customer Service';
const statusInternal = 500;

const messageInternet = 'Silakan Cek Koneksi Internet Anda';
const statusInternet = 799;
