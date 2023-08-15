class SecuritySetting {
  bool secureAppActive;
  bool useBiometriLock;
  String? pin;

  SecuritySetting({
    this.secureAppActive = false,
    this.useBiometriLock = false,
    this.pin,
  });

  SecuritySetting copyWith({
    bool? secureAppActive,
    bool? useBiometriLock,
    String? pin,
  }) {
    return SecuritySetting(
      secureAppActive: secureAppActive ?? this.secureAppActive,
      useBiometriLock: useBiometriLock ?? this.useBiometriLock,
      pin: pin ?? this.pin,
    );
  }

  bool get pinHaveBeenSet => pin != null;
  bool get pinIsValid => pin == null ? false : pin!.length >= 4;

  void toggleSecureActive() {
    secureAppActive = !secureAppActive;
    print(secureAppActive);
  }

  toggleUseBiometrik() {
    useBiometriLock = !useBiometriLock;
  }
}
