class AnswersController < ApplicationController

def index
    @answers = Answer.all
    @answer = Answer.new

  end
def show

    @answer = Answer.find(params[:id])

end
 def new
    @answer = Answer.new

  end

def create
    @answer = Answer.new(params[:answer])
if @answer.save
 if !params[:integrated_view].nil?
    redirect_to answers_integrated_view_path, :notice => "Successfully created answer."
else
      redirect_to answers_url, :notice => "Successfully created answer."
end
    else
      render :new
    end
  end

 def edit
    @answer = Answer.find(params[:id])
if !params[:get].nil?
 render :layout=>false
end
  end

  def update
    @answer = Answer.find(params[:id])
if @answer.update_attributes(params[:answer])
 if !params[:integrated_view].nil?
    redirect_to answers_integrated_view_path, :notice => "Successfully created answer."
else
      redirect_to answers_url, :notice => "Successfully created answer."
end


    else
      render :edit
    end
  end

def destroy
  @answer = Answer.find(params[:id])
@answer.destroy
if !params[:integrated_view].nil?

 redirect_to answers_integrated_view_path, :notice => "Successfully destroyed answer."
else
  redirect_to answers_url, :notice => "Successfully destroyed answer."
end
end

def parse_save_from_excel
    test_file = params[:excel_file]
    file = FileUploader.new
    if file.store!(test_file)
      book = Spreadsheet.open "#{file.store_path}"
      sheet1 = book.worksheet 0

       @answer  = []
      @errors = Hash.new
      @counter = 0

      sheet1.each 1 do |row|
        @counter+=1
        p = Answer.new



         p.question_id = row[0]

         p.statement = row[1]
        unless Answer.find_by_question_id_and_statement(p.question_id,p.statement)
          if p.valid?
            p.save
          else
            @errors["#{@counter+1}"] = p.errors
          end
        end
      end
      file.remove!
      if @errors.empty?
        redirect_to answer, notice: 'All Dummy data were successfully uploaded.'
      else
        redirect_to answer, notice: 'There were some errors in your upload'
      end

    else
      redirect_to answer, notice: 'Dummy datum could not be successfully uploaded.'
    end
  end
def integrated_view
  @answers = Answer.all
      @answer = Answer.new
render :layout=>'scaffold'

end
end
