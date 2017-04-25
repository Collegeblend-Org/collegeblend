class AttemptsController < ApplicationController

  helper 'surveys'
  before_filter :authenticate_user!, except: [ :index, :show ]
  before_filter :load_active_survey
  before_filter :normalize_attempts_data, :only => :create
  helper_method :correct_answer?

  def new
    @participant = current_user # you have to decide what to do here

    unless @survey.nil?
      @attempt = @survey.attempts.new
      @attempt.answers.build
    end
  end

  def create
    @attempt = @survey.attempts.new(attempt_params)
    @attempt.participant = current_user

    if @attempt.valid? && @attempt.save
      redirect_to attempt_path(@survey.id)
    else
      render :action => :new
    end
  end
  
  def correct_answer?
    if @survey.attempts.last[:score] == 1
      current_user.add_points(10)
    end
  end

  private

  def load_active_survey
    @survey_id =  params[:survey_id].to_i - 1
    @survey = Survey::Survey.active[@survey_id]
  end

  def normalize_attempts_data
    normalize_data!(params[:survey_attempt][:answers_attributes])
  end

  def normalize_data!(hash)
    multiple_answers = []
    last_key = hash.keys.last.to_i

    hash.keys.each do |k|
      if hash[k]['option_id'].is_a?(Array)
        if hash[k]['option_id'].size == 1
          hash[k]['option_id'] = hash[k]['option_id'][0]
          next
        else
          multiple_answers <<  k if hash[k]['option_id'].size > 1
        end
      end
    end

    multiple_answers.each do |k|
      hash[k]['option_id'][1..-1].each do |o|
        last_key += 1
        hash[last_key.to_s] = hash[k].merge('option_id' => o)
      end
      hash[k]['option_id'] = hash[k]['option_id'].first
    end
  end

  def attempt_params
    rails4? ? params_whitelist : params[:survey_attempt]
  end

  def params_whitelist
    params.require(:survey_attempt).permit(Survey::Attempt::AccessibleAttributes)
  end
end
