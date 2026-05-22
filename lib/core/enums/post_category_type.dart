enum PostCategoryType { move, recycling, buyForMe, giveAway }

extension PostCategoryTypeX on PostCategoryType {
  /// Human-readable label used in UI
  String get displayName {
    switch (this) {
      case PostCategoryType.move:
        return 'Move';
      case PostCategoryType.recycling:
        return 'Recycling';
      case PostCategoryType.buyForMe:
        return 'Buy For Me';
      case PostCategoryType.giveAway:
        return 'Give Away';
    }
  }

  /// Value expected by the API `type` query param
  String get apiValue {
    switch (this) {
      case PostCategoryType.move:
        return 'move';
      case PostCategoryType.recycling:
        return 'recycling';
      case PostCategoryType.buyForMe:
        return 'buy_for_me';
      case PostCategoryType.giveAway:
        return 'give_away';
    }
  }

  /// Parse from API response `type` string back to enum
  static PostCategoryType? fromApiValue(String? value) {
    switch (value) {
      case 'move':
        return PostCategoryType.move;
      case 'recycling':
        return PostCategoryType.recycling;
      case 'buy_for_me':
        return PostCategoryType.buyForMe;
      case 'give_away':
        return PostCategoryType.giveAway;
      default:
        return null;
    }
  }
}
