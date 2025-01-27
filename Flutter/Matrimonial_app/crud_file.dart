class User {
  List<Map<String, dynamic>> userDetail = [
    {
      "fullName": "John Doe",
      "email": "john.doe@example.com",
      "mobile": "1234567890",
      "dob": "1990-01-01",
      "city": "New York",
      "gender": "Male",
      "hobbies": ["Reading", "Gaming", "Traveling"]
    },
    {
      "fullName": "Jane Smith",
      "email": "jane.smith@example.com",
      "mobile": "0987654321",
      "dob": "1992-05-15",
      "city": "Los Angeles",
      "gender": "Female",
      "hobbies": ["Cooking", "Yoga", "Music"]
    },
    {
      "fullName": "Alice Johnson",
      "email": "alice.johnson@example.com",
      "mobile": "5678901234",
      "dob": "1985-08-20",
      "city": "Chicago",
      "gender": "Female",
      "hobbies": ["Photography", "Gardening", "Traveling"]
    },
    {
      "fullName": "Bob Brown",
      "email": "bob.brown@example.com",
      "mobile": "3456789012",
      "dob": "1988-11-30",
      "city": "San Francisco",
      "gender": "Male",
      "hobbies": ["Hiking", "Fishing", "Cycling"]
    },
    {
      "fullName": "Charlie Green",
      "email": "charlie.green@example.com",
      "mobile": "2345678901",
      "dob": "1995-03-25",
      "city": "Houston",
      "gender": "Male",
      "hobbies": ["Programming", "Drawing", "Fitness"]
    },
    {
      "fullName": "Daisy Blue",
      "email": "daisy.blue@example.com",
      "mobile": "4567890123",
      "dob": "1991-07-14",
      "city": "Seattle",
      "gender": "Female",
      "hobbies": ["Dancing", "Painting", "Singing"]
    },
    {
      "fullName": "Edward White",
      "email": "edward.white@example.com",
      "mobile": "6789012345",
      "dob": "1987-12-19",
      "city": "Boston",
      "gender": "Male",
      "hobbies": ["Movies", "Chess", "Running"]
    },
    {
      "fullName": "Fiona Black",
      "email": "fiona.black@example.com",
      "mobile": "7890123456",
      "dob": "1993-04-10",
      "city": "Denver",
      "gender": "Female",
      "hobbies": ["Photography", "Gaming", "Writing"]
    },
    {
      "fullName": "George Gray",
      "email": "george.gray@example.com",
      "mobile": "8901234567",
      "dob": "1989-06-22",
      "city": "Miami",
      "gender": "Male",
      "hobbies": ["Swimming", "Fishing", "Cycling"]
    },
    {
      "fullName": "Hannah Violet",
      "email": "hannah.violet@example.com",
      "mobile": "9012345678",
      "dob": "1996-09-05",
      "city": "Austin",
      "gender": "Female",
      "hobbies": ["Cooking", "Dancing", "Traveling"]
    },
    {
      "fullName": "Ian Orange",
      "email": "ian.orange@example.com",
      "mobile": "1123456789",
      "dob": "1994-02-18",
      "city": "Portland",
      "gender": "Male",
      "hobbies": ["Reading", "Music", "Gaming"]
    },
    {
      "fullName": "Jasmine Pink",
      "email": "jasmine.pink@example.com",
      "mobile": "2234567890",
      "dob": "1998-10-30",
      "city": "Las Vegas",
      "gender": "Female",
      "hobbies": ["Yoga", "Gardening", "Photography"]
    },
    {
      "fullName": "Kevin Cyan",
      "email": "kevin.cyan@example.com",
      "mobile": "3345678901",
      "dob": "1986-01-11",
      "city": "Dallas",
      "gender": "Male",
      "hobbies": ["Hiking", "Chess", "Movies"]
    }

  ];
  // String fullName;
  // String email;
  // String mobile;
  // String dob;
  // String city;
  // String gender;
  // List<String> hobbies;
  //
  // User({
  //   required this.fullName,
  //   required this.email,
  //   required this.mobile,
  //   required this.dob,
  //   required this.city,
  //   required this.gender,
  //   required this.hobbies,
  // });
  void add_User( String fullName,String email,String mobile,String dob,String city,String gender,List<String> hobbies) {
    Map<String, dynamic> map = {};
    map['fullName'] = fullName;
    map['email'] = email;
    map['mobile'] = mobile;
    map['dob'] = dob;
    map['city'] = city;
    map['gender'] = gender;
    map['hobbies'] = hobbies;
    userDetail.add(map);
  }

  void update_user(String fullName,String email,String mobile,String dob,String city,String gender,List<String> hobbies,int idx) {
    Map<String, dynamic> map = {};
    map['fullName'] = fullName;
    map['email'] = email;
    map['mobile'] = mobile;
    map['dob'] = dob;
    map['city'] = city;
    map['gender'] = gender;
    map['hobbies'] = hobbies;
    userDetail[idx] = map;
  }

  void delete_user(int idx) {
    userDetail.removeAt(idx);
  }

  List<Map<String, dynamic>> getUser_details() {
    return userDetail;
  }
  List<Map<String, dynamic>>?  searchDetail({required String searchData}) {
    List<Map<String, dynamic>> temp = [];
    searchData = searchData.toLowerCase();
    if (searchData.isEmpty) {
      return userDetail;
    }
    for (var element in userDetail) {
      if (element['fullName'].toString().toLowerCase().contains(searchData)
          // element['email'].toString().toLowerCase().contains(searchData) ||
          // element['dob'].toString().toLowerCase().contains(searchData) ||
          // element['city'].toString().toLowerCase().contains(searchData) ||
          // element['hobbies'].toString().toLowerCase().contains(searchData) ||
          // element['gender'].toString().toLowerCase().contains(searchData) ||
          // element['mobile'].toString().toLowerCase().contains(searchData)
      ) {
        temp.add(element);
      }
    }
    return temp;
  }

}
