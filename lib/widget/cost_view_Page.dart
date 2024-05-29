import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../main.dart';

class CostViewPage extends StatefulWidget {
  final String senderName;
  final String receiverName;
  final String senderRegion;
  final String receiverRegion;
  final String price;
  final String weight;
  final String deliveryCompany;
  final String deliveryInsurance;
  final String deliveryExpress;
  final String deliveryRegion;
  final int totalCost;
  final int deliveryTime;

  CostViewPage({
    required this.senderName,
    required this.receiverName,
    required this.senderRegion,
    required this.receiverRegion,
    required this.price,
    required this.weight,
    required this.deliveryCompany,
    required this.deliveryInsurance,
    required this.deliveryExpress,
    required this.deliveryRegion,
    required this.totalCost,
    required this.deliveryTime,
  });

  @override
  _CostViewPageState createState() => _CostViewPageState();
}

class _CostViewPageState extends State<CostViewPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('택배 보내기'),
      ),
      body: Center(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 80),
              child: Column(
                children: [
                  Text('보내는 사람: ${widget.senderName}'),
                  Text('받는 사람: ${widget.receiverName}'),
                  Text('보내는 지역: ${widget.senderRegion}'),
                  Text('받는 지역: ${widget.receiverRegion}'),
                  Text('상품 가격: ${widget.price}원'),
                  Text('상품 무게: ${widget.weight}kg'),
                  Text('택배 회사: ${widget.deliveryCompany}'),
                  Text('보험 여부: ${widget.deliveryInsurance}'),
                  Text('배송 방법: ${widget.deliveryExpress}'),
                  Text('배송 지역: ${widget.deliveryRegion}'),
                  Text('총 운임 비용: ${widget.totalCost}원'),
                  Text('예상 소요 시간: ${widget.deliveryTime}일'),
                  SizedBox(height: 45),
                  Text('입력하신 정보가 맞는 지 확인해주세요.'),
                ],
              ),
            ),
            _buildNextPageButton('택배보내기'),
          ],
        ),
      ),
    );
  }

  Widget _buildNextPageButton(String text) {
    return Container(
      height: 40,
      margin: EdgeInsets.only(top: 100),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey, width: 2),
      ),
      child: TextButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => MyApp()), // Update with the actual next page widget
          );
        },
        child: Text(
          text,
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}