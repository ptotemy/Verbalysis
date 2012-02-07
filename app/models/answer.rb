class Answer < ActiveRecord::Base

   set_table_name :answers

  # ---------------
  # Accessible Attributes
  # ---------------
  # Only accessible attributes can be created or modified. In case, you add more attributes through a later migration,
  # remember to add the attribute to the attr_accessible list. Otherwise, many an hour is lost in figuring out why data is not
  # getting captured through forms...

  attr_accessible :question_id, :name, :answer_tags_attributes

  # ---------------
  # Associations
  # ---------------
  # Uncomment, copy and add you associations here...
  belongs_to                :question
  has_many                  :answer_tags, :dependent=>:destroy
  # has_and_belongs_to_many   :friends
  # has_one                  :life
  accepts_nested_attributes_for :answer_tags


  # ---------------
  # Validations
  # ---------------
  # These are the standard validations that you might need to use with the models. Please uncomment as required...

  
  # validates_presence_of :question_id
  # validates_numericality_of :question_id
    
  validates_presence_of :name
  validates_length_of :name,:maximum=>255
    
  # ---------------
  # Schema Information
  # ---------------
  # Just so that you do not have to open up the migration file to check this everytime...

    
  # question_id:integer
    
  # statement:string
    

  # ---------------
  # Scope
  # ---------------
  # Consider using a model scope if you find yourself having to use 'order' too frequently in your finds

  # default_scope order('created_at DESC')

end
