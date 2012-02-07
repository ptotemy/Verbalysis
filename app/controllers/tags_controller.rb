class TagsController < ApplicationController

def index
    @tags = Tag.all
    @tag = Tag.new

  end
def show

    @tag = Tag.find(params[:id])

end
 def new
    @tag = Tag.new

  end

def create
    @tag = Tag.new(params[:tag])
if @tag.save
 if !params[:integrated_view].nil?
    redirect_to tags_integrated_view_path, :notice => "Successfully created tag."
else
      redirect_to tags_url, :notice => "Successfully created tag."
end
    else
      render :new
    end
  end

 def edit
    @tag = Tag.find(params[:id])
if !params[:get].nil?
 render :layout=>false
end
  end

  def update
    @tag = Tag.find(params[:id])
if @tag.update_attributes(params[:tag])
 if !params[:integrated_view].nil?
    redirect_to tags_integrated_view_path, :notice => "Successfully created tag."
else
      redirect_to tags_url, :notice => "Successfully created tag."
end


    else
      render :edit
    end
  end

def destroy
  @tag = Tag.find(params[:id])
@tag.destroy
if !params[:integrated_view].nil?

 redirect_to tags_integrated_view_path, :notice => "Successfully destroyed tag."
else
  redirect_to tags_url, :notice => "Successfully destroyed tag."
end
end

def parse_save_from_excel
    test_file = params[:excel_file]
    file = FileUploader.new
    if file.store!(test_file)
      book = Spreadsheet.open "#{file.store_path}"
      sheet1 = book.worksheet 0

       @tag  = []
      @errors = Hash.new
      @counter = 0

      sheet1.each 1 do |row|
        @counter+=1
        p = Tag.new

         p.name = row[0]
        unless Tag.find_by_name(p.name)
          if p.valid?
            p.save
          else
            @errors["#{@counter+1}"] = p.errors
          end
        end
      end
      file.remove!
      if @errors.empty?
        redirect_to tag, notice: 'All Dummy data were successfully uploaded.'
      else
        redirect_to tag, notice: 'There were some errors in your upload'
      end

    else
      redirect_to tag, notice: 'Dummy datum could not be successfully uploaded.'
    end
  end
def integrated_view
  @tags = Tag.all
      @tag = Tag.new
render :layout=>'scaffold'

end
end
