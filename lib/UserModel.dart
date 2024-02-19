class Users {
  final String Id;
  final String name;
  final String email;
  final String userName;
  final String password;
  final String accBalance;
  final String? profileImage;
  final String? phoneNumber;
  Users(
      {
      this.profileImage,
        required this.Id,
        required this.userName,
      required this.name,
      required this.email,
      required this.password,
      required this.accBalance,
      this.phoneNumber});
  factory Users.fromMap(Map<String, dynamic> map) {
    return Users(
      profileImage: map['profileImage'],
        userName: map['userName'],
        name: map['name'],
        email: map['email'],
        password: map['password'],
        accBalance: map['accBalance'],
        Id: map['Id'],
      phoneNumber: map['phoneNumber'],
    );
  }
  Map<String,dynamic>toMap(){
    return{
      "profileImage":profileImage,
      "Id":Id,
      "userName":userName,
      "name":name,
      "email":email,
      "password":password,
      "accBalance":accBalance,
      "phoneNumber":phoneNumber,
    };
  }
  Users copyWith({
    String? profileImage,
    String? name,
    String? email,
     String? userName,
    String? password,
     String? accBalance,
    String? Id,
    String? phoneNumber,
}){
    return Users(
      profileImage: profileImage??this.profileImage,
      Id: Id??this.Id,
        userName: userName??this.userName,
        name: name??this.name,
        email: email??this.email,
        password: password??this.password,
        accBalance: accBalance??this.accBalance,
      phoneNumber: phoneNumber??this.phoneNumber,
    );
  }
}
