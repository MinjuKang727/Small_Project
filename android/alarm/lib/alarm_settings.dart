import 'package:flutter/material.dart';

class AlarmSettingsScreen extends StatefulWidget {
  @override
  _AlarmSettingsScreenState createState() => _AlarmSettingsScreenState();
}

class _AlarmSettingsScreenState extends State<AlarmSettingsScreen> {
  TimeOfDay _selectedTime = TimeOfDay.now();
  String _repeatCycle = '매일';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('아버님 안약 알람 설정')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            // 1. 시간 선택 카드
            ListTile(
              title: Text("알람 시간", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              subtitle: Text("${_selectedTime.format(context)}", style: TextStyle(fontSize: 40, color: Colors.blue)),
              onTap: () async {
                final TimeOfDay? picked = await showTimePicker(context: context, initialTime: _selectedTime);
                if (picked != null) setState(() => _selectedTime = picked);
              },
            ),
            Divider(),
            // 2. 반복 주기 선택
            DropdownButtonFormField<String>(
              value: _repeatCycle,
              decoration: InputDecoration(labelText: '반복 주기'),
              items: ['매일', '매주', '매월'].map((value) => DropdownMenuItem(value: value, child: Text(value))).toList(),
              onChanged: (value) => setState(() => _repeatCycle = value!),
            ),
            // 3. 배경 이미지 설정 버튼 (예시)
            ElevatedButton.icon(
              onPressed: () { /* 이미지 피커 로직 */ },
              icon: Icon(Icons.image),
              label: Text("알람 배경 사진 선택"),
            ),
            Spacer(),
            // 저장 버튼
            SizedBox(
              width: double.infinity,
              height: 60,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.blueAccent),
                onPressed: () {
                   // 여기에 알람 등록 로직 추가
                   ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("알람이 저장되었습니다!")));
                },
                child: Text("알람 저장하기", style: TextStyle(fontSize: 20, color: Colors.white)),
              ),
            )
          ],
        ),
      ),
    );
  }
}