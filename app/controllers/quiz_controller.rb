class QuizController < ApplicationController
  def index
    @quiz = Quiz.new
  end

  #post 
  def create
    authenticate(params)
    @quiz = current_user.quizzes.build

    if @quiz.save
      # session[:quiz_start_time] = @quiz.created_at
      # session[:questions] = []

      # shuffle the question deck at the beginning instead of after every page call
      session[:questions] = Question.all.map(&:id).shuffle

      redirect_to quiz_path(@quiz)
    else
      redirect_to quiz_index_path
    end
  end

  def show
    @quiz = Quiz.find(params[:id])

    if (questions_left? && !time_over?)
      @question = find_next_question
    else
      redirect_to results_quiz_path
    end
  end

  def results
    @answers = Answer.includes([:question,:quiz]).where("quiz_id = ?", params[:id])
    @questions = Question.count

    if (@answers.first.quiz.user.id == current_user.id) || current_user.admin?
      # @score = @answers.inject(0) do |sum,a|
      #   (a.question.correct_answer == a.user_given) ? sum += 1 : sum
      # end

      @score = 0
      @result = @answers.map do |a|
        if (a.question.correct_answer == a.user_given)
          decision = "Correct"
          @score += 1
        else
          decision = "Incorrect"
        end

        [a.question.title,decision]
      end
    else
      redirect_to quiz_index_path
    end
  end

  def update
    @quiz = Quiz.find(params[:id])
    @quiz.answers.create({
      :user_given => params[:user_answer], 
      :user_id => current_user.id, 
      :question_id => params[:question]
    })

    redirect_to @quiz
  end

  private
  def find_next_question
    # remainder = Question.all.map(&:id) - session[:questions]
    # Question.includes(:images).find(remainder.shuffle.first)
    next_one = session[:questions].pop
    Question.includes(:images).find(next_one)
  end

  def time_over?
    # (Time.now - session[:quiz_start_time]) > (2 * 60)
    (Time.now - @quiz.created_at) > (2 * 60)
  end

  def questions_left?
    # session[:questions].size < Question.count
    !session[:questions].empty?
  end
end
