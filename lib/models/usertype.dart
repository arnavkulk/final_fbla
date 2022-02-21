enum UserType {
  STUDENT,
  TEACHER,
  ADMIN,
}

extension UserTypeUtils on UserType {
  String get value {
    switch (this) {
      case UserType.STUDENT:
        return "STUDENT";
      case UserType.TEACHER:
        return "TEACHER";
      case UserType.ADMIN:
        return "ADMIN";
      default:
        return "";
    }
  }

  static String asString(UserType type) {
    return type.value;
  }

  static UserType fromString(String userType) {
    switch (userType) {
      case "STUDENT":
        return UserType.STUDENT;
      case "TEACHER":
        return UserType.TEACHER;
      case "ADMIN":
        return UserType.ADMIN;
      default:
        return UserType.STUDENT;
    }
  }
}
