String? Function(String?) get passwordValidator => (String? password) =>
    (password?.length ?? 0) < 8 ? "Password too short" : null;

String? Function(String?) get mandatoryValidator =>
    (String? val) => val?.isEmpty ?? true ? 'This Field is mandatory' : null;

String? Function(String?) get emailValidator => (String? email) => RegExp(
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$',
    ).hasMatch(email ?? "")
        ? null
        : 'Enter a valid email';

String? Function(String?) get numberValidator =>
    (String? number) => number?.isEmpty ?? true
        ? "This field is mandatory"
        : RegExp(r"^[0-9]*$").hasMatch(number ?? "")
            ? null
            : "Enter a valid number";
