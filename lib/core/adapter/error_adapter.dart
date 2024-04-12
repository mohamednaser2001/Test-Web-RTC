

class ErrorAdapter {
  Map<String, dynamic> errors;

  ErrorAdapter({required this.errors});

  String adaptErrors(){
    String e='';
    errors.forEach((key, value) {
      e+= '${value[0]}\n';
    });

    return e.trim();
  }
}