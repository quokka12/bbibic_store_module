class Cart {
  String goodsId = '';
  String goodsName = '';
  String goodsImage = '';
  int goodsPrice = 0;
  int count = 0;
  bool isSelected = false;

  Cart(this.goodsId, this.goodsName, this.goodsImage, this.goodsPrice,
      this.count, this.isSelected);
  // 파이어베이스에 저장하기 위해 Map타입으로 바꿔준다.
  Map<String, dynamic> toMap() {
    return {
      "goodsId": goodsId,
      "goodsName": goodsName,
      "goodsImage": goodsImage,
      "goodsPrice": goodsPrice,
      "count": count,
      "isSelected": isSelected,
    };
  }
}
