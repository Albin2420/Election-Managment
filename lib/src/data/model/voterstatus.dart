class VoterStatus {
  final int serialNumber;
  final bool hasVoted;

  VoterStatus({required this.serialNumber, required this.hasVoted});

  factory VoterStatus.fromJson(Map<String, dynamic> json) {
    return VoterStatus(
      serialNumber: json['serial_number'] ?? 0,
      hasVoted: json['has_voted'] ?? false,
    );
  }
}
