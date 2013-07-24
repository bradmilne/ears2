class UserMailer < ActionMailer::Base
  default :from => "notifications@example.com"
  
  def expire_email(user)
    mail(:to => user.email, :subject => "Subscription Cancelled")
  end

  def lesson_update_email(user, lesson_title, previous_lesson_rating, new_lesson_rating)
    attachments.inline['eartutor_black.png'] = File.read('assets/eartutor_black.png')
    @lesson_title = lesson_title
    @previous_lesson_rating = previous_lesson_rating
    @new_lesson_rating = new_lesson_rating
    mail(:to => user.email, :subject => "Good Work!")
  end
end