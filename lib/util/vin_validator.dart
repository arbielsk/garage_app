bool validateVin(String vin) {
  return RegExp(r"^[a-zA-Z0-9]{17}$").hasMatch(vin);
}
