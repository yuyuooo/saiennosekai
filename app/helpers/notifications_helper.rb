module NotificationsHelper
  def unchecked_notifications
    @notifications = current_user.passive_notifications.where(checked: false)
  end

  def notification_form(notification)
    @visitor = notification.visitor
    @comment = nil
    @visitor_comment = notification.crop_comment_id

    case notification.action
      when "dm" then
       @chat = Chat.find_by(id: notification.chat_id)&.message
        tag.a(@visitor.name, href:user_path(@visitor), style:"font-weight: bold;")+"があなたに"+tag.a('メッセージ',href:chat_path(notification.visitor), style:"font-weight: bold;")+"を送りました"
      when "comment" then
        @comment = CropComment.find_by(id: @visitor_comment)&.comment
        tag.a(@visitor.name, href:user_path(@visitor), style:"font-weight: bold;")+"が"+tag.a('あなたの栽培作物', href:crop_folder_path(notification.crop_folder_id), style:"font-weight: bold;")+"に「コメント」しました"
      when "favorite" then
        tag.a(@visitor.name, href:user_path(@visitor), style:"font-weight: bold;")+"が"+tag.a('あなたの栽培作物', href:crop_folder_path(notification.crop_folder_id), style:"font-weight: bold;")+"に「いいね」しました"
      when "like" then
        tag.a(@visitor.name, href:user_path(@visitor), style:"font-weight: bold;")+"が"+tag.a('あなたの商品', href:item_path(notification.item_id), style:"font-weight: bold;")+"に「気になる」しました"
    end
  end
end
