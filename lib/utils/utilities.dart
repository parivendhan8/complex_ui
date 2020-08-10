
class Utils{

  static String getUserName(String email){
    return 'live:${email.split("@")[0]}';
  }

  static String getInitials(String name){
    var split = name.split(" ");
    String firstName = split[0][0];
    String secondName = split[1][0];
    return firstName + secondName;
  }

}