class User < ActiveRecord::Base
  rolify
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :name, :email, :password, :password_confirmation, :remember_me, :stripe_token, :coupon
  attr_accessor :stripe_token, :coupon
  before_save :update_stripe
  before_destroy :cancel_subscription

  has_many :quizzes
  has_many :responses

  def update_plan(role)
    self.role_ids = []
    self.add_role(role.name)
    unless customer_id.nil?
      customer = Stripe::Customer.retrieve(customer_id)
      customer.update_subscription(:plan => role.name)
    end
    true
  rescue Stripe::StripeError => e
    logger.error "Stripe Error: " + e.message
    errors.add :base, "Unable to update your subscription. #{e.message}."
    false
  end
  
  def update_stripe
    return if email.include?(ENV['ADMIN_EMAIL'])
    return if email.include?('@example.com') and not Rails.env.production?
    if customer_id.nil?
      if !stripe_token.present?
        raise "Stripe token not present. Can't create account."
      end
      if coupon.blank?
        customer = Stripe::Customer.create(
          :email => email,
          :description => name,
          :card => stripe_token,
          :plan => roles.first.name
        )
      else
        customer = Stripe::Customer.create(
          :email => email,
          :description => name,
          :card => stripe_token,
          :plan => roles.first.name,
          :coupon => coupon
        )
      end
    else
      customer = Stripe::Customer.retrieve(customer_id)
      if stripe_token.present?
        customer.card = stripe_token
      end
      customer.email = email
      customer.description = name
      customer.save
    end
    self.last_4_digits = customer.active_card.last4
    self.customer_id = customer.id
    self.stripe_token = nil
  rescue Stripe::StripeError => e
    logger.error "Stripe Error: " + e.message
    errors.add :base, "#{e.message}."
    self.stripe_token = nil
    false
  end
  
  def cancel_subscription
    unless customer_id.nil?
      customer = Stripe::Customer.retrieve(customer_id)
      unless customer.nil? or customer.respond_to?('deleted')
        if customer.subscription.status == 'active'
          customer.cancel_subscription
        end
      end
    end
  rescue Stripe::StripeError => e
    logger.error "Stripe Error: " + e.message
    errors.add :base, "Unable to cancel your subscription. #{e.message}."
    false
  end
  
  def expire
    UserMailer.expire_email(self).deliver
    destroy
  end

  def best_score_per_quiz
    if !Quiz.where(:user_id => self.id).maximum(:score)
      quiz = 0
    else
      quiz = Quiz.where(:user_id => self.id).maximum(:score)
      quiz = (((quiz)/5)*100).to_i
      quiz = "Your best quiz score so far is #{quiz}%."
    end
  end

  def average_quiz_score
    if Quiz.where(:user_id => self.id).count < 1
      quiz = "Welcome! Get started by choosing a lesson."
    else 
      quiz = Quiz.where(:user_id => self.id).average(:score)
      quiz = (((quiz)/5)*100).to_i
      quiz = "Your overall average quiz score is #{quiz}%."
    end
  end

  def ear_training_stats(interval)
    #total average
    total_answers = Response.where(:user_id => self.id, :correct_answer => interval).count
    total_correct = Response.where(:user_id => self.id, :correct_answer => interval, :result => "true").count
    if total_answers == 0
      total_average = 0
    else
      total_average = (total_correct.to_f/total_answers)*100
    end
    #average in last 30 days
    total_answers_30 = Response.where(:user_id => self.id, :correct_answer => interval, :created_at => 1.month.ago..Time.now).count
    total_correct_30 = Response.where(:user_id => self.id, :correct_answer => interval, :result => "true", :created_at => 1.month.ago..Time.now).count
    if total_answers_30 == 0
      total_average_30 = 0
    else
      total_average_30 = (total_correct_30.to_f/total_answers_30)*100
    end
    


    #total average octave 1
    total_answers_1 = Response.where(:user_id => self.id, :correct_answer => interval, :octave => 1).count
    total_correct_1 = Response.where(:user_id => self.id, :correct_answer => interval, :result => "true", :octave => 1).count
    if total_answers_1 == 0
      total_average_1 = 0
    else
      total_average_1 = (total_correct_1.to_f/total_answers_1)*100
    end

    #total average octave 2
    total_answers_2 = Response.where(:user_id => self.id, :correct_answer => interval, :octave => 2).count
    total_correct_2 = Response.where(:user_id => self.id, :correct_answer => interval, :result => "true", :octave => 2).count
    if total_answers_2 == 0
      total_average_2 = 0
    else
      total_average_2 = (total_correct_2.to_f/total_answers_2)*100
    end

    #total average octave 3
    total_answers_3 = Response.where(:user_id => self.id, :correct_answer => interval, :octave => 3).count
    total_correct_3 = Response.where(:user_id => self.id, :correct_answer => interval, :result => "true", :octave => 3).count
    if total_answers_3 == 0
      total_average_3 = 0
    else
      total_average_3 = (total_correct_3.to_f/total_answers_3)*100
    end

    #total average octave 4
    total_answers_4 = Response.where(:user_id => self.id, :correct_answer => interval, :octave => 4).count
    total_correct_4 = Response.where(:user_id => self.id, :correct_answer => interval, :result => "true", :octave => 4).count
    if total_answers_4 == 0
      total_average_4 = 0
    else
      total_average_4 = (total_correct_4.to_f/total_answers_4)*100
    end

    #total average octave 3
    total_answers_5 = Response.where(:user_id => self.id, :correct_answer => interval, :octave => 5).count
    total_correct_5 = Response.where(:user_id => self.id, :correct_answer => interval, :result => "true", :octave => 5).count
    if total_answers_5 == 0
      total_average_5 = 0
    else
      total_average_5 = (total_correct_5.to_f/total_answers_5)*100
    end



    results_hash = Hash.new
    results_hash = {"Total answer" => total_answers, 
                    "Total correct" => total_correct, 
                    "Total average" => total_average,
                    "Total average 30" => total_average_30,
                    "Total average 1" => total_average_1,
                    "Total average 2" => total_average_2,
                    "Total average 3" => total_average_3,
                    "Total average 4" => total_average_4,
                    "Total average 5" => total_average_5
                  }
  end

  def chord_progression_stats
    chords_array = ['I - ii', 'I - iii', 'I - IV', 'I - V', 'I - vi', 'I - vii',
                    'I - IV - V', 'I - ii - iii', 'I - iii - ii', 'I - vi - V',
                    'I - vi - IV', 'I - V - IV', 'I - IV - V - I', 'I - IV - V - IV',
                    'I - IV - I - V', 'I - IV - V - IV', 'I - V - vi - IV', 'I - ii - IV - V',
                    'I - vi - V - I', 'I - V - IV - I', 'I - ii - V - IV', 'I - ii - IV - I',
                    'I - vi - ii - V', 'I - vi - IV - V', 'Imaj7 - Imaj7 - V7 - V7', 'Imaj7 - Imaj7 - iimin7 - V7',
                    'Imaj7 - vimin7 - iimin7 - V7', 'Imaj7 -vi7 - iimin7 - V7', 'Imaj7 - VI7b13 - iimin7 - V7',
                    'Imaj7 - VI7b13 - II7 - V7', 'Imaj7 - VI7b13 - II7 - bII7', 'Imaj7 - VI7b13 - bVI7 - V7',
                    'Imaj7 - bIII7 - II7 - V7', 'Imaj7 - bIII7 - II7 - bII7', 'Imaj7 - bII7 - bVI7 - bII7', 'iiimin7 - VI7b13 - iimin7 - V7',
                    'III7 - VI7b13 - II7 - V7', 'bVII7 - VI7b13 - II7 - V7', 'Imaj7 - Imaj7 - ivm7 - bVII7', 'Imaj7 - I7b9 - ivmin7 - bVII7',
                    'Imaj7 - bIIImaj7 - bVImaj7 - bIImaj7', 'I7 - VI7 - bV7 - bIII7', 'Imaj7 - IV7 -iiimin7b5 - VI7b9', 
                    'Imin6 - vi7b5 - ii7b5', 'Imin6 - bIIImaj7 - ii7b5 - V7alt', 'Imin6 - bIIImaj7 -bVI7#11 - V7alt', 'Imin6 - bIII7#11 -bVI7#11 - bII7#11']
    chord_progression_stats_array = Array.new
    counter = 0
    while counter < chords_array.length
      chord_progression = chords_array[counter]
      
      #total average
      total_answers = Response.where(:user_id => self.id, :correct_answer => chords_array[counter]).count
      total_correct = Response.where(:user_id => self.id, :correct_answer => chords_array[counter], :result => "true").count
      if total_answers == 0
        total_average = 0
      else
        total_average = (total_correct.to_f/total_answers)*100
      end

      #average in last 30 days
      total_answers_30 = Response.where(:user_id => self.id, :correct_answer => chords_array[counter], :created_at => 1.month.ago..Time.now).count
      total_correct_30 = Response.where(:user_id => self.id, :correct_answer => chords_array[counter], :result => "true", :created_at => 1.month.ago..Time.now).count
      if total_answers_30 == 0
        total_average_30 = 0
      else
        total_average_30 = (total_correct_30.to_f/total_answers_30)*100
      end

      #total attempts
      total_attempts = Response.where(:user_id => self.id, :correct_answer => chords_array[counter]).count
    
      answers_array = [chord_progression, total_average, total_average_30, total_attempts]
      counter += 1
      chord_progression_stats_array << answers_array
      end
    return chord_progression_stats_array
  end
end