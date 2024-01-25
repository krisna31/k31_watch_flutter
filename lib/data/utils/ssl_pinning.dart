import 'package:flutter/services.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';

class SSLPinning {
  static Future<http.Client> get myHttpsClient async {
    // load certificate
    final sslCerticate = await rootBundle.load('certificates/certificates.pem');

    // create security context
    SecurityContext securityContext = SecurityContext(withTrustedRoots: false);
    securityContext
        .setTrustedCertificatesBytes(sslCerticate.buffer.asInt8List());

    // create HttpClient
    HttpClient client = HttpClient(context: securityContext);
    client.badCertificateCallback =
        (X509Certificate cert, String host, int port) => false;

    // return IOClient
    return IOClient(client);
  }
}
