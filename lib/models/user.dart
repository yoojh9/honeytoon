class User {
  String uid;
  String displayName;
  String email;
  String provider;
  String thumbnail;
  int honey = 0;
  int rank = -1;
  var works = [];

  User(this.uid, this.displayName, this.email, this.provider, this.thumbnail, this.honey, this.rank, this.works);
  
  @override
  String toString() {
    return "user.displayName: ${this.displayName}";
  }
}