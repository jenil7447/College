class UserCrud {
  // Private list to store user details
  static final List<Map<String, dynamic>> _userDetails = [
    {
      "fullName": "John Doe",
      "email": "john.doe@example.com",
      "mobile": "1234567890",
      "dob": "1990-01-01",
      "city": "New York",
      "gender": "Male",
      "hobbies": ["Reading", "Gaming", "Traveling"],
      "isFavorite": false,
    },
    {
      "fullName": "Jane Smith",
      "email": "jane.smith@example.com",
      "mobile": "0987654321",
      "dob": "1992-05-15",
      "city": "Los Angeles",
      "gender": "Female",
      "hobbies": ["Cooking", "Yoga", "Music"],
      "isFavorite": false,
    },
  ];

  // Getter to access user details
  static List<Map<String, dynamic>> get userDetails => _userDetails;

  // Add a new user
  static void addUser(String fullName, String email, String mobile, String dob,
      String city, String gender, List<String> hobbies) {
    _userDetails.add({
      "fullName": fullName,
      "email": email,
      "mobile": mobile,
      "dob": dob,
      "city": city,
      "gender": gender,
      "hobbies": hobbies,
      "isFavorite": false, // Default to not favorite
    });
  }

  // Update an existing user
  static void updateUser(int index, String fullName, String email, String mobile,
      String dob, String city, String gender, List<String> hobbies) {
    if (index >= 0 && index < _userDetails.length) {
      _userDetails[index] = {
        "fullName": fullName,
        "email": email,
        "mobile": mobile,
        "dob": dob,
        "city": city,
        "gender": gender,
        "hobbies": hobbies,
        "isFavorite": _userDetails[index]["isFavorite"], // Preserve favorite status
      };
    }
  }

  // Delete a user
  static void deleteUser(int index) {
    if (index >= 0 && index < _userDetails.length) {
      _userDetails.removeAt(index);
    }
  }

  // Search users based on name, email, mobile, city, gender, or hobbies
  static List<Map<String, dynamic>> searchDetail(String searchData) {
    searchData = searchData.toLowerCase();
    return UserCrud.userDetails.where((user) {
      return user["fullName"].toLowerCase().contains(searchData) ||
          user["email"].toLowerCase().contains(searchData) ||
          user["mobile"].toLowerCase().contains(searchData) ||
          user["dob"].toLowerCase().contains(searchData) ||
          user["city"].toLowerCase().contains(searchData) ||
          user["gender"].toLowerCase().contains(searchData) ||
          (user["hobbies"] != null && user["hobbies"].any((hobby) =>
              hobby.toString().toLowerCase().contains(searchData)));
    }).toList();
  }

  // Toggle favorite status of a user
  static void toggleFavorite(int index) {
    if (index >= 0 && index < _userDetails.length) {
      _userDetails[index]["isFavorite"] = !_userDetails[index]["isFavorite"];
    }
  }

  // Get all favorite users
  static List<Map<String, dynamic>> getFavoriteUsers() {
    return _userDetails.where((user) => user["isFavorite"] == true).toList();
  }
}
