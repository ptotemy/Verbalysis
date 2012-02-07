class QuestionsController < ApplicationController

  def index
    @questions = Question.all
    @question = Question.new

  end

  def show

    @question = Question.find(params[:id])
    @answers = @question.answers
  end

  def new
    @question = Question.new
    @tags=Tag.all
    4.times do
      answer = @question.answers.build
      answer.answer_tags.build
      @tags.count.times { answer.answer_tags.build }
    end

  end

  def create


    @question = Question.new(params[:question])
    if @question.save
      @question.answers.each_with_index do |answer, index|
        if !params[index.to_s].nil?
          params[index.to_s].count.times do |i|
            @answer_tag=AnswerTag.new
            @answer_tag.answer_id=answer.id
            @answer_tag.tag_id=params[index.to_s][i]
            @answer_tag.save!
          end
        end
      end
      if !params[:integrated_view].nil?
        redirect_to questions_integrated_view_path, :notice => "Successfully created question."
      else
        redirect_to questions_url, :notice => "Successfully created question."
      end
    else
      redirect_to new_question_path
    end
  end

  def edit
    @question = Question.find(params[:id])
    if !params[:get].nil?
      render :layout=>false
    end
  end

  def update
    @question = Question.find(params[:id])
    if @question.update_attributes(params[:question])
      if !params[:integrated_view].nil?
        redirect_to questions_integrated_view_path, :notice => "Successfully created question."
      else
        redirect_to questions_url, :notice => "Successfully created question."
      end


    else
      render :edit
    end
  end

  def destroy
    @question = Question.find(params[:id])
    @question.destroy
    if !params[:integrated_view].nil?

      redirect_to questions_integrated_view_path, :notice => "Successfully destroyed question."
    else
      redirect_to questions_url, :notice => "Successfully destroyed question."
    end
  end

  def parse_save_from_excel
    test_file = params[:excel_file]
    file = FileUploader.new
    if file.store!(test_file)
      book = Spreadsheet.open "#{file.store_path}"
      sheet1 = book.worksheet 0

      @question = []
      @errors = Hash.new
      @counter = 0

      sheet1.each 1 do |row|
        @counter+=1
        p = Question.new

        p.statement = row[0]
        unless Question.find_by_statement(p.statement)
          if p.valid?
            p.save
          else
            @errors["#{@counter+1}"] = p.errors
          end
        end
      end
      file.remove!
      if @errors.empty?
        redirect_to question, notice: 'All Dummy data were successfully uploaded.'
      else
        redirect_to question, notice: 'There were some errors in your upload'
      end

    else
      redirect_to question, notice: 'Dummy datum could not be successfully uploaded.'
    end
  end

  def integrated_view
    @questions = Question.all
    @question = Question.new
    render :layout=>'scaffold'

  end
end
