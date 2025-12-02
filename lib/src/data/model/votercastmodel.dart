class VoterCastModel {
  final String id;
  final String name;
  final String houseNumber;
  final String electoralId;
  final String serialNumber;
  bool hasVoted;

  VoterCastModel({
    required this.id,
    required this.name,
    required this.houseNumber,
    required this.electoralId,
    required this.serialNumber,
    this.hasVoted = false,
  });
}
