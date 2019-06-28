require_relative 'db_connection'
require 'active_support/inflector'
require "byebug"
# NB: the attr_accessor we wrote in phase 0 is NOT used in the rest
# of this project. It was only a warm up.

# REMEMBER SQLObject is the parent!
# ex. Cat < SQLObject
class SQLObject         
  # returns an array with the names of the table's columns
  # ex. Cat.columns == [:id, :name, :owner_id]
  # query the database using DBConnection.execute2 to ask it what the columns 
  # are for a table 
  def self.columns
    # table = @table_name               # <- ?this doesn't work because this hasn't been defined yet?
    # table = SQLObject.table_name      # <- ?not the same as below? wrong class (bec we're calling this method on child class not SQLObject)
    table = self.table_name    

    if @columns.nil?
      # DBConnection returns an array (1st ele is array of names of columns)
      # if we call self.columns again 2x+, the code below won't be queried
      @columns = DBConnection.execute2(<<-SQL)
        SELECT
          *
        FROM
          #{table}
      SQL
      @columns = @columns.first.map(&:to_sym)
    end

    @columns
  end

# cat = #<Cat:0x00007facce1fdf60 @attributes={:id=>1, :name=>"Breakfast", :owner_id=>1}
# cat.finalize!
# #==> 

  # automatically adds getter and setter methods for each column
  # ? getter/setter for getting col name/setting col name? NOT getting all col values?
  # ex. Cat < SQLObject
  def self.finalize!
    # get array of columns, with each column as symbol
    columns = self.columns
    columns.each do |col_name|
      define_method("#{col_name}") do                 
        self.attributes[col_name]                  
      end
      define_method("#{col_name}=") do  |val_to_set|
        self.attributes[col_name] = val_to_set               
      end
    end
  end


  # setter method for table_name
  def self.table_name=(table_name)
    @table_name = table_name
  end

  # getter method for table_name
  # need to write this before we can interact with the database
  # get the name of the table for that class as a string?
  # ex. Cat.table_name == 'cats'
  def self.table_name
    if @table_name.nil?                   # if @attribute @table_name hasn't been set
      @table_name = self.to_s.tableize    # convert to string first, then call .tableize
    else
      @table_name
    end
  end


  # fetches all the records from the database
  # returns an array of "row" objects
  def self.all
    table = self.table_name
    results = DBConnection.execute(<<-SQL)
      SELECT
        #{table}.*
      FROM    
        #{table}
    SQL
    # ex. results = [{"id"=>1, "name"=>"Breakfast", "owner_id"=>1}, {"id"=>2, "name"=>"Earl", "owner_id"=>2}, {"id"=>3, "name"=>"Haskell", "owner_id"=>3}, {"id"=>4, "name"=>"Markov", "owner_id"=>3}, {"id"=>5, "name"=>"Stray Cat", "owner_id"=>nil}]

    # loop through each hash in results
    # turn each hash into new obj
    results.map { |result| self.new(result) }
    #[#<Cat:0x00007facce1fdf60 @attributes={:id=>1, :name=>"Breakfast", :owner_id=>1}>, #<Cat:0x00007facce1fdcb8 @attributes={:id=>2, :name=>"Earl", :owner_id=>2}>, #<Cat:0x00007facce1fd880 @attributes={:id=>3, :name=>"Haskell", :owner_id=>3}>, #<Cat:0x00007facce1fd3d0 @attributes={:id=>4, :name=>"Markov", :owner_id=>3}>, #<Cat:0x00007facce1fd1c8 @attributes={:id=>5, :name=>"Stray Cat", :owner_id=>nil}>]
  end


  def self.parse_all(results)   # results = array of hashes
    # results = [{:name=>"cat1", :owner_id=>1}, {:name=>"cat2", :owner_id=>2}]
    results.map { |result| self.new(result) }
  end


  def self.find(id)
    table = self.table_name
    result = DBConnection.execute(<<-SQL)
      SELECT
        #{table}.id
      FROM    
        #{table}
      WHERE
        id = #{id}
    SQL
    self.parse_all(result).first
  end

  
  # Iterate through each of the attr_name, value pairs
  # For each For each attr_name, it should first convert the name to a symbol, 
  # and then check whether the attr_name is among the columns. If it is not, 
  # raise an error:
  # ex. 
  # cat = Cat.new(name: "Gizmo", owner_id: 123)
  # cat.name #=> "Gizmo"
  # cat.owner_id #=> 123
  def initialize(params = {})   # <- ?is params a hash representing a new row object?
    params.each do |key, value|
      attr_name = key.to_sym
      class_name = self.class
      raise "unknown attribute '#{attr_name}'" if !class_name.columns.include?(attr_name)
      
      # set the attr_name by calling #send  
      # ? what method are we sending?       
      # ? we are sending the column name to ?
      self.send("#{attr_name}=", value)     
      # self.send "#{attr_name}=", value            # also works
    end
  end


  def attributes
    @attributes ||= {}
  end


  # method that returns an array of the values for each attribute. 
  def attribute_values    
    columns = self.class.columns
    columns.map { |col| self.send(col) }            #=> ex. [:id, :name, :owner_id]
  end


  def insert
    table = self.table_name
    columns_arr = self.attribute_values

    result = DBConnection.execute(<<-SQL)
      INSERT INTO
        #{table} (#{columns})
      VALUES
        #{qmarks}
    SQL

    # self.parse_all(result).first
  end

  def update
    # ...
  end

  def save
    # ...
  end
end


# test = SQLObject.new
# p SQLObject.table_name