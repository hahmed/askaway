class QuestionsController < ApplicationController
  before_action :set_question, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:edit, :update, :destroy]
  before_action :owns_question, only: [:edit, :update]

  # GET /questions
  # GET /questions.json
  def index
    query = params[:q].presence || "*"
    @questions = Question.search(query, suggest: true)
  end

  # GET /questions/1
  # GET /questions/1.json
  def show
    @answer = Answer.new
    @answers = @question.answers
  end

  # GET /questions/new
  def new
    ab_finished(:new_question_link_class)
    @question = Question.new
  end

  # GET /questions/1/edit
  def edit
  end

  # POST /questions
  # POST /questions.json
  def create
    @question = Question.new(question_params)
    @question.user = current_user

    respond_to do |format|
      if @question.save
        format.html { redirect_to @question, notice: 'Question was successfully created.' }
        format.json { render :show, status: :created, location: @question }
      else
        format.html { render :new }
        format.json { render json: @question.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /questions/1
  # PATCH/PUT /questions/1.json
  def update
    respond_to do |format|
      if @question.update(question_params)
        format.html { redirect_to @question, notice: 'Question was successfully updated.' }
        format.json { render :show, status: :ok, location: @question }
      else
        format.html { render :edit }
        format.json { render json: @question.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /questions/1
  # DELETE /questions/1.json
  def destroy
    @question.destroy
    respond_to do |format|
      format.html { redirect_to questions_url, notice: 'Question was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  # GET /questions/autocomplete
  def autocomplete
    render json: Question.search(params[:term], fields: [{ title: :text_start }],
      limit: 10).map(&:title)
  end

  # GET /questions/autocomplete
  def me
    @questions = current_user.questions
  end

  private
    def set_question
      @question = Question.find(params[:id])
    end

    def question_params
      params.require(:question).permit(:title, :content)
    end

    def owns_question
      raise 'must be owner' unless user_signed_in? && @question.owner?(current_user)
    end
end
