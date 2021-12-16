class ConfirmMailer < ApplicationMailer
  def confirm_mail(new_blog)
    @blog = new_blog
    mail to: 'gumbomb1@gmail.com', subject: '投稿確認メール'
  end
end
