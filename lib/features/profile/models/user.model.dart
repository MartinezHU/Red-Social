class User {
  final String uuid;
  final String username;
  final String email;
  final DateTime dateJoined;
  final bool isStaff;
  final String profilePic;
  final String coverPhoto;
  final String bio;
  final DateTime birthDay;
  final String location;
  final String website;
  final bool mailNotifications;
  final String gender;
  final bool isPrivate;
  final bool isVerified;
  final bool isOnline;
  final DateTime lastLogin;

  User(
      this.uuid,
      this.username,
      this.email,
      this.dateJoined,
      this.isStaff,
      this.profilePic,
      this.coverPhoto,
      this.bio,
      this.birthDay,
      this.location,
      this.website,
      this.mailNotifications,
      this.gender,
      this.isPrivate,
      this.isVerified,
      this.isOnline,
      this.lastLogin);
}
