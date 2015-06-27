class LinkMailer < ApplicationMailer
  default from: 'soutetsu@gmail.com'

  def send_mail(to, url, item_owner)
    @url = url
    @item_owner = item_owner
    mail to: to, subject: 'Bropbox 共有リンクのお知らせ'
  end
end
