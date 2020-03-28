class AnswersController < ApplicationController
  before_action :set_question, :authenticate_user!
  before_action :owns_question

  # POST /questions/1/answers
  # POST /questions/1/answers.json
  def create
    @answer = Answer.new(answer_params)
    @answer.user = current_user
    @answer.question = @question

    respond_to do |format|
      if @answer.save
        format.html { redirect_to @question, notice: 'Answer was successfully created.' }
        format.json { render :show, status: :created, location: @question }
        format.js
      else
        @answers = @question.answers
        format.html { render 'questions/show' }
        format.json { render json: @answer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /questions/1/answers/1
  # DELETE /questions/1/answers/1.json
  def destroy
    answer = Answer.find_by(user_id: current_user.id, id: params[:id])
    answer.destroy

    respond_to do |format|
      format.html { redirect_to question_url, notice: 'Answer was successfully destroyed.' }
      format.json { head :no_content }
      format.js
    end
  end

  private
    def set_question
      @question = Question.find(params[:question_id])
    end

    def answer_params
      params.require(:answer).permit(:content)
    end

    def owns_question
      raise 'cant be owner' if @question.owner?(current_user)
    end
end
