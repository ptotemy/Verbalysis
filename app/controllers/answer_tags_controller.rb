class AnswerTagsController < ApplicationController

def index
    @answer_tags = AnswerTag.all
    @answer_tag = AnswerTag.new

  end
def show

    @answer_tag = AnswerTag.find(params[:id])

end
 def new
    @answer_tag = AnswerTag.new

  end

def create
    @answer_tag = AnswerTag.new(params[:answer_tag])
if @answer_tag.save
 if !params[:integrated_view].nil?
    redirect_to answer_tags_integrated_view_path, :notice => "Successfully created answer tag."
else
      redirect_to answer_tags_url, :notice => "Successfully created answer tag."
end
    else
      render :new
    end
  end

 def edit
    @answer_tag = AnswerTag.find(params[:id])
if !params[:get].nil?
 render :layout=>false
end
  end

  def update
    @answer_tag = AnswerTag.find(params[:id])
if @answer_tag.update_attributes(params[:answer_tag])
 if !params[:integrated_view].nil?
    redirect_to answer_tags_integrated_view_path, :notice => "Successfully created answer tag."
else
      redirect_to answer_tags_url, :notice => "Successfully created answer tag."
end


    else
      render :edit
    end
  end

def destroy
  @answer_tag = AnswerTag.find(params[:id])
@answer_tag.destroy
if !params[:integrated_view].nil?

 redirect_to answer_tags_integrated_view_path, :notice => "Successfully destroyed answer tag."
else
  redirect_to answer_tags_url, :notice => "Successfully destroyed answer tag."
end
end

def parse_save_from_excel
    test_file = params[:excel_file]
    file = FileUploader.new
    if file.store!(test_file)
      book = Spreadsheet.open "#{file.store_path}"
      sheet1 = book.worksheet 0

       @answer_tag  = []
      @errors = Hash.new
      @counter = 0

      sheet1.each 1 do |row|
        @counter+=1
        p = AnswerTag.new



         p.answer_id = row[0]

         p.tag_id = row[1]
        unless AnswerTag.find_by_answer_id_and_tag_id(p.answer_id,p.tag_id)
          if p.valid?
            p.save
          else
            @errors["#{@counter+1}"] = p.errors
          end
        end
      end
      file.remove!
      if @errors.empty?
        redirect_to answer_tag, notice: 'All Dummy data were successfully uploaded.'
      else
        redirect_to answer_tag, notice: 'There were some errors in your upload'
      end

    else
      redirect_to answer_tag, notice: 'Dummy datum could not be successfully uploaded.'
    end
  end
def integrated_view
  @answer_tags = AnswerTag.all
      @answer_tag = AnswerTag.new
render :layout=>'scaffold'

end
end
