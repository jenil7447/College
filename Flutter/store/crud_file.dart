class User {
  List<Map<String, dynamic>> userDetail = [
    {
      "fullName": "Bob Brown",
      "email": "bob.brown@example.com",
      "mobile": "3456789012",
      "dob": "30/11/1988",
      "city": "San Francisco",
      "gender": "Male",
      "isFavourite":1,
      "hobbies": ["Hiking", "Fishing", "Cycling"]
    },
    {
      "fullName": "Charlie Green",
      "email": "charlie.green@example.com",
      "mobile": "2345678901",
      "dob": "25/03/1995",
      "city": "Houston",
      "gender": "Male",
      "hobbies": ["Programming", "Drawing", "Fitness"]
    },
    {
      "fullName": "Daisy Blue",
      "email": "daisy.blue@example.com",
      "mobile": "4567890123",
      "dob": "14/07/1991",
      "city": "Seattle",
      "gender": "Female",
      "hobbies": ["Dancing", "Painting", "Singing"]
    },
    {
      "fullName": "Edward White",
      "email": "edward.white@example.com",
      "mobile": "6789012345",
      "dob": "19/12/1987",
      "city": "Boston",
      "gender": "Male",
      "hobbies": ["Movies", "Chess", "Running"]
    },
    {
      "fullName": "Fiona Black",
      "email": "fiona.black@example.com",
      "mobile": "7890123456",
      "dob": "10/04/1993",
      "city": "Denver",
      "gender": "Female",
      "hobbies": ["Photography", "Gaming", "Writing"]
    },
    {
      "fullName": "George Gray",
      "email": "george.gray@example.com",
      "mobile": "8901234567",
      "dob": "22/06/1989",
      "city": "Miami",
      "gender": "Male",
      "hobbies": ["Swimming", "Fishing", "Cycling"]
    },
    {
      "fullName": "Hannah Violet",
      "email": "hannah.violet@example.com",
      "mobile": "9012345678",
      "dob": "05/09/1996",
      "city": "Austin",
      "gender": "Female",
      "hobbies": ["Cooking", "Dancing", "Traveling"]
    },
    {
      "fullName": "Ian Orange",
      "email": "ian.orange@example.com",
      "mobile": "1123456789",
      "dob": "18/02/1994",
      "city": "Portland",
      "gender": "Male",
      "hobbies": ["Reading", "Music", "Gaming"]
    },
    {
      "fullName": "Jasmine Pink",
      "email": "jasmine.pink@example.com",
      "mobile": "2234567890",
      "dob": "30/10/1998",
      "city": "Las Vegas",
      "gender": "Female",
      "hobbies": ["Yoga", "Gardening", "Photography"]
    },
    {
      "fullName": "Kevin Cyan",
      "email": "kevin.cyan@example.com",
      "mobile": "3345678901",
      "dob": "11/01/1986",
      "city": "Dallas",
      "gender": "Male",
      "hobbies": ["Hiking", "Chess", "Movies"]
    }
  ]
  ;
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

  void update_user(String fullName, String email, String mobile, String dob, String city, String gender, List<String> hobbies, int idx) {
    if (idx < 0 || idx >= userDetail.length) {// Debug log
      return;
    }
    userDetail[idx] = {
      'fullName': fullName,
      'email': email,
      'mobile': mobile,
      'dob': dob,
      'city': city,
      'gender': gender,
      'hobbies': hobbies,
    };
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
