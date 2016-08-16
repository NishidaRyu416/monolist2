class RankingController < ApplicationController
  def have
    #/ranking/want
    @title_have = "Haveランキング"
    @rankings = Have.group(:item_id).order('count_item_id desc').limit(10).count('item_id')
    #=> {5=>12, 1=>11, 2=>10, 3=>9, 8=>9, 9=>7, 10=>6, 11=>5, 4=>4, 6=>3}
    item_ids = @rankings.keys
    #=> [5, 1, 2, 3, 8, 9, 10, 11, 4, 6]
    @items_have = Item.find(item_ids).sort_by{|item| item_ids.index(item.id)}
    
    #Item.find(item_ids)の時の要素のIDの順序
    #=> [1, 2, 3, 4, 5, 6, 8, 9, 10, 11]
    #1~11までの全てのデータを|item|に順番に入れる->1~11のIDだけを抽出(item.id)
    #->indexメソッドを使ってitem_idsの配列順を参照し、sort_byで並び替える。
  end

  def want
    #/ranking/have
    @title_want = "Wantランキング"
    @rankings = Want.group(:item_id).order('count_item_id desc').limit(10).count('item_id')
    #=> {5=>12, 1=>11, 2=>10, 3=>9, 8=>9, 9=>7, 10=>6, 11=>5, 4=>4, 6=>3}
    item_ids = @rankings.keys
    #=> [5, 1, 2, 3, 8, 9, 10, 11, 4, 6]
    @items_want = Item.find(item_ids).sort_by{|item| item_ids.index(item.id)}
    #Item.find(item_ids)の時の要素のIDの順序
    #=> [1, 2, 3, 4, 5, 6, 8, 9, 10, 11]
    #1~11までの全てのデータをitemに順番に入れる->1~11のIDだけを抽出(item.id)
    #->indexメソッドを使ってitem_idsの配列順を参照し、sort_byで並び替える。
  end
end

# id: 5　のオブジェクト

  #=> {#<Item:0x007f9c1d3400b0
  # id: 5,
  # title: "はじめてのBootstrap [ 槇俊明 ]",
  # description: nil,
  # detail_page_url: "http://item.rakuten.co.jp/book/12567734/",
  # small_image:
  # "http://thumbnail.image.rakuten.co.jp/@0_mall/book/cabinet/7992/9784777517992.jpg?_ex=64x64",
  # medium_image:
  # "http://thumbnail.image.rakuten.co.jp/@0_mall/book/cabinet/7992/9784777517992.jpg?_ex=128x128",
  # large_image:
  # "http://thumbnail.image.rakuten.co.jp/@0_mall/book/cabinet/7992/9784777517992.jpg",
  # created_at: Tue, 24 May 2016 23:24:05 UTC +00:00,
  # updated_at: Tue, 24 May 2016 23:24:05 UTC +00:00,
  # item_code: "book:16716714">=>12,