class VoterModel {
  final String id;
  final String name;
  final int serialNumber;

  final String? guardianName;
  final int? age;
  final String? gender;
  final String? address;
  final String? photo;
  final int? wardNumber;
  final int? houseNumber;
  final String? secIdNumber;
  final bool? isActive;
  final String? inactiveReason;
  final bool? isAlive;
  final bool? isDisputed;
  final bool? isOurVoter;
  final String? lsgBooth;
  final bool? hasVoted;
  final String? votedAt;
  final String? addedBy;

  VoterModel({
    required this.id,
    required this.name,
    required this.serialNumber,
    this.guardianName,
    this.age,
    this.gender,
    this.address,
    this.photo,
    this.wardNumber,
    this.houseNumber,
    this.secIdNumber,
    this.isActive,
    this.inactiveReason,
    this.isAlive,
    this.isDisputed,
    this.isOurVoter,
    this.lsgBooth,
    this.hasVoted,
    this.votedAt,
    this.addedBy,
  });

  factory VoterModel.fromJson(Map<String, dynamic> json) {
    return VoterModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      serialNumber: json['serial_number'] ?? 0,
      guardianName: json['guardian_name'],
      age: json['age'],
      gender: json['gender'],
      address: json['address'],
      photo: json['photo'],
      wardNumber: json['ward_number'],
      houseNumber: json['house_number'],
      secIdNumber: json['sec_id_number'],
      isActive: json['is_active'],
      inactiveReason: json['inactive_reason'],
      isAlive: json['is_alive'],
      isDisputed: json['is_disputed'],
      isOurVoter: json['is_our_voter'],
      lsgBooth: json['lsg_booth'],
      hasVoted: json['has_voted'],
      votedAt: json['voted_at'],
      addedBy: json['added_by'],
    );
  }
}
