class AlarmModel {
  DateTime time;           // 알람 시간
  String repeatCycle;      // 반복 주기 (매일, 월, 년 등)
  String alarmSound;       // 알람음 경로
  bool useVibration;       // 진동 여부
  int snoozeMinutes;       // 스누즈 간격 (분)
  String? backgroundImage; // 알람 배경 이미지 경로

  AlarmModel({
    required this.time,
    this.repeatCycle = '매일',
    this.alarmSound = '기본음',
    this.useVibration = true,
    this.snoozeMinutes = 5,
    this.backgroundImage,
  });
}