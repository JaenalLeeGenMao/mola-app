class Csrf {
  final String csrf; /* _csrf */
  final String token; /* x-csrf-token */
  final String error; /* default null */

  Csrf.fromJson(Map<String, dynamic> json)
      : csrf = json["_csrf"] ?? "",
        token = json["x-csrf-token"] ?? "",
        error = null;

  Map<String, dynamic> toJson() => {"_csrf": csrf, "x-csrf-token": token};

  Csrf.withError(String errorValue)
      : csrf = null,
        token = null,
        error = errorValue;
}
