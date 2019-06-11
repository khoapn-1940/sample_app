class UserMailer < ApplicationMailer
  def account_activation user
    @user = user
    mail to: user.email, subject: t("chap11.subject")
  end

  def password_reset
    @greeting = t("chap11.greeting")

    mail to: "to@example.org"
  end
end
