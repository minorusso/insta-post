class ConfirmMailer < ApplicationMailer
  def confirm_mail(new_picture)
    @picture = new_picture
    mail to: 'gumbomb1@gmail.com', subject: '投稿確認メール'
  end
end
