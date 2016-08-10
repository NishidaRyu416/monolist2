class OwnershipsController < ApplicationController
  before_action :logged_in_user

  def create
    if params[:item_code]  # 検索のページ have or want ボタンを押した時 item_codeが存在するか
      @item = Item.find_or_initialize_by(item_code: params[:item_code])#item_codeは楽天のもの
    else  #検索以外のページから見た場合
      @item = Item.find(params[:item_id])#item_idは自分のデータベースのもの
    end

    # itemsテーブルに存在しない場合は楽天のデータを登録する。
    if @item.new_record?
      # TODO 商品情報の取得 RakutenWebService::Ichiba::Item.search を用いてください
      items = RakutenWebService::Ichiba::Item.search(itemCode: @item.item_code)

      item                  = items.first
      @item.title           = item['itemName']
      @item.small_image     = item['smallImageUrls'].first['imageUrl']#最初のグループにある」
      @item.medium_image    = item['mediumImageUrls'].first['imageUrl']
      @item.large_image     = item['mediumImageUrls'].first['imageUrl'].gsub('?_ex=128x128', '')
      @item.detail_page_url = item['itemUrl']
      @item.save! #強制save !は強制という意味。　予期せぬことが起こった場合エラー発生 
    end
    
    # [[item_code, item_name],[smallimageurl => {}],[関係ないデーター],[],[]]
  
    # TODO ユーザにwant or haveを設定する
    
    # params[:type]の値にHaveボタンが押された時には「Have」,
    # Wantボタンが押された時には「Want」が設定されています。
    current_user.want(@item) if params[:type] == "Want"
    current_user.have(@item) if params[:type] == "Have"   
  end

  def destroy
    @item = Item.find(params[:item_id])

    # TODO 紐付けの解除。 
    # params[:type]の値にHave itボタンが押された時には「Have」,
    # Want itボタンが押された時には「Want」が設定されています。
    current_user.unwant(@item) if params[:type] == "Want"
    current_user.unhave(@item) if params[:type] == "Have"   
  end
end
