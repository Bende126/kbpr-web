class VoteQuestionsController < ApplicationController
  before_action :set_vote_question, only: %i[ show edit update destroy ]
  # GET /vote_questions or /vote_questions.json
  def index
    @vote_questions = VoteQuestion.all.order(created_at: :desc)
  end

  # GET /vote_questions/1 or /vote_questions/1.json
  def show

  end

  # GET /vote_questions/new
  def new
    @vote_question = VoteQuestion.new
  end

  # GET /vote_questions/1/edit
  def edit
  end

  # POST /vote_questions or /vote_questions.json
  def create
    @vote_question = VoteQuestion.new(vote_question_params)

    respond_to do |format|
      if @vote_question.save
        format.html { redirect_to vote_question_url(@vote_question), notice: "A szavazást sikeresen létrehoztuk!" }
        format.json { render :show, status: :created, location: @vote_question }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @vote_question.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /vote_questions/1 or /vote_questions/1.json
  def update
    respond_to do |format|
      if @vote_question.update(vote_question_params)
        format.html { redirect_to vote_question_url(@vote_question), notice: "A szavazást sikeresen frissítettük!" }
        format.json { render :show, status: :ok, location: @vote_question }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @vote_question.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /vote_questions/1 or /vote_questions/1.json
  def destroy
    @vote_question.destroy

    respond_to do |format|
      format.html { redirect_to vote_questions_url, notice: "A szavazást sikeresen töröltük" }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_vote_question
      @vote_question = VoteQuestion.find(params[:id])
      authorize @vote_question
    end

    # Only allow a list of trusted parameters through.
    def vote_question_params
      params.require(:vote_question).permit(:title, :content, :start_at, :end_at)
    end
end