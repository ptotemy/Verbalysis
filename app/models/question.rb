class Question < ActiveRecord::Base

  set_table_name :questions

  # ---------------
  # Accessible Attributes
  # ---------------
  # Only accessible attributes can be created or modified. In case, you add more attributes through a later migration,
  # remember to add the attribute to the attr_accessible list. Otherwise, many an hour is lost in figuring out why data is not
  # getting captured through forms...

  attr_accessible :name, :answers_attributes


  # ---------------
  # Associations
  # ---------------
  # Uncomment, copy and add you associations here...
  # belongs_to                :parent
  has_many :answers, :dependent=>:destroy
  # has_and_belongs_to_many   :friends
  # has_one                  :life
  accepts_nested_attributes_for :answers

  # ---------------
  # Validations
  # ---------------
  # These are the standard validations that you might need to use with the models. Please uncomment as required...


  validates_presence_of :name

  # ---------------
  # Schema Information
  # ---------------
  # Just so that you do not have to open up the migration file to check this everytime...


  # statement:text


  # ---------------
  # Scope
  # ---------------
  # Consider using a model scope if you find yourself having to use 'order' too frequently in your finds

  # default_scope order('created_at DESC')

end
