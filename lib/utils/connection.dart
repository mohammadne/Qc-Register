import 'dart:io';

Future<bool> internetConnection() async {
  var result;
  try {
    result = await InternetAddress.lookup('google.com');
  } catch (_) {
    print('no connected');
    return false;
  }
  if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
    print('connected');
    return true;
  } else {
    return false;
  }
}
