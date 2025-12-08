class VoterStatus {
  final int serialNumber;
  final bool hasVoted;
  bool? isOurvoter;

  VoterStatus({
    required this.serialNumber,
    required this.hasVoted,
    this.isOurvoter, // ✅ assign to class field
  });

  factory VoterStatus.fromJson(Map<String, dynamic> json) {
    return VoterStatus(
      serialNumber: json['serial_number'] ?? 0,
      hasVoted: json['has_voted'] ?? false,
      isOurvoter: json['is_our_voter'] ?? false,
    );
  }
}
