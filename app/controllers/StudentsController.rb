class StudentsController < ApplicationController
  def index
    @students = Student.all.order({ :created_at => :desc })

    render({ :template => "students/index" })
  end

  def show
    the_id = params.fetch("path_id")
    @students = Student.where({:id => the_id }).at(0)

    render({ :template => "students/show" })
  end

  def create
    @students = Student.new
    @students.first_name = params.fetch("query_first_name")
    @students.last_name = params.fetch("query_last_name")
    @students.email = params.fetch("query_email")

    if @students.valid?
      @students.save
      redirect_to("/students", { :notice => "Student created successfully." })
    else
      redirect_to("/students", { :notice => "Student failed to create successfully." })
    end
  end

  def update
    the_id = params.fetch("path_id")
    @students = Student.where({ :id => the_id }).at(0)

    @students.first_name = params.fetch("query_first_name")
    @students.last_name = params.fetch("query_last_name")
    @students.email = params.fetch("query_email")

    if @students.valid?
      @students.save
      redirect_to("/students/#{@students.id}", { :notice => "Student updated successfully."} )
    else
      redirect_to("/students/#{@students.id}", { :alert => "Student failed to update successfully." })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    @students = Student.where({ :id => the_id }).at(0)

    @students.destroy

    redirect_to("/students", { :notice => "Student deleted successfully."} )
  end
end
