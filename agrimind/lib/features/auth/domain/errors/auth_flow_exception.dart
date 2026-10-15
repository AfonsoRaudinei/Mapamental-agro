class AuthFlowCancelledException implements Exception {
  const AuthFlowCancelledException();
}

abstract final class AuthCancellationCodes {
  static const values = {
    'canceled',
    'cancelled',
    'user-cancelled',
    'web-context-canceled',
    'web-context-cancelled',
    'canceled-popup-request',
    'cancelled-popup-request',
    'popup-closed-by-user',
  };

  static bool contains(String? code) => values.contains(code?.toLowerCase());
}
