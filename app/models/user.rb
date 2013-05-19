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

  def ear_training_stats_hash(interval)
    total_answers = Response.where(:user_id => self.id, :correct_answer => interval).count
    total_correct = Response.where(:user_id => self.id, :correct_answer => interval, :result => "True").count
    #results_hash[:total_answers] = total_answers
    #results_hash[:total_correct] = total_correct
    results_hash = Hash.new
    results_hash = {"Total answer" => total_answers, 
                    "Total correct" => total_correct
                  }
  end
end
