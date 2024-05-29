import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class UserDataPage extends StatefulWidget {
  @override
  _UserDataPageState createState() => _UserDataPageState();
}

class _UserDataPageState extends State<UserDataPage> {
  final TextEditingController nameController = TextEditingController();
  Map<String, dynamic> userData = {};
  bool isLoading = false;

  final FirebaseDatabase _database = FirebaseDatabase.instance;

  void _fetchUserData(String userName) async {
    setState(() {
      isLoading = true;
      userData = {};
    });

    String userKey = userName.replaceAll(' ', '_').toLowerCase();
    DatabaseReference userRef = _database.ref('packages/$userKey');

    DataSnapshot snapshot = await userRef.get();
    if (snapshot.exists) {
      setState(() {
        userData = Map<String, dynamic>.from(snapshot.value as Map);
      });
    } else {
      setState(() {
        userData = {};
      });
    }

    setState(() {
      isLoading = false;
    });
  }

  Map<String, String> getKeyMapping() {
    return {
      'deliveryCompany': '택배회사',
      'deliveryExpress': '배송방법',
      'deliveryInsurance': '보험유무',
      'deliveryRegion': '배달지역',
      'deliveryTime': '배송시간',
      'price': '가격',
      'receiverName': '받는 사람',
      'receiverRegion': '받는 지역',
      'senderName': '보낸 사람',
      'senderRegion': '보낸 지역',
      'totalCost': '총 비용',
      'weight': '무게',
    };
  }

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '이전으로',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Container(
        color: Colors.white,
        child:Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '택배는 사랑을 싣고',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              Text(
                '사랑을 나누는 택배 서비스',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
              SizedBox(height: 40),
              TextField(
                controller: nameController,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.search),
                  hintText: '보내시는 사람의 이름을 검색해주세요',
                  filled: true,
                  fillColor: Colors.grey[200],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    _fetchUserData(nameController.text);
                  },
                  child: Text(
                      '조회하기',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              isLoading
                  ? Center(child: CircularProgressIndicator())
                  : userData.isNotEmpty
                  ? _buildUserData()
                  : Center(child: Text('데이터가 없습니다.')),
            ],
          ),
        ),

      ),
    );
  }

  Widget _buildUserData() {
    final keyMapping = getKeyMapping();

    return Expanded(
      child: ListView(
        children: userData.entries.map((entry) {
          String displayKey = keyMapping[entry.key] ?? entry.key;
          return ListTile(
            title: Text(displayKey),
            subtitle: Text('${entry.value}'),
          );
        }).toList(),
      ),
    );
  }
}