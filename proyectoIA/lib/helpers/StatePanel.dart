class StatePanel {
  String message;
  int code;
  dynamic data;
  StatePanel();

  factory StatePanel.loading() = StateLoading;
  factory StatePanel.sendOrder() = StateSendOrder;
  factory StatePanel.promo(String message, dynamic data, int code) = StatePromo;
  factory StatePanel.error(String message, int code) = StateError;
  factory StatePanel.success(String message, dynamic data, int code) =
      StateSuccess;
  factory StatePanel.none() = StateNone;
}

class StateNone extends StatePanel {}

class StatePromo extends StatePanel {
  StatePromo(String message, dynamic data, int code) {
    this.message = message;
    this.data = data;
    this.code = code;
  }
}

class StateLoading extends StatePanel {}

class StateSendOrder extends StatePanel {}

class StateSuccess extends StatePanel {
  StateSuccess(String message, dynamic data, int code) {
    this.message = message;
    this.data = data;
    this.code = code;
  }
}

class StateError extends StatePanel {
  StateError(String message, int code) {
    this.message = message;
    this.code = code;
  }
}
