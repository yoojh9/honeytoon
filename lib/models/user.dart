class User {
  String uid;
  String displayName;
  String email;
  String provider;
  String thumbnail;

  User(this.uid, this.displayName, this.email, this.provider, this.thumbnail);
  
  @override
  String toString() {
    // TODO: implement toString
    return "user.displayName: ${this.displayName}";
  }
}