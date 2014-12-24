class StudentsController < ApplicationController
  def index
    @students = Student.all
  end

  def show
    @student = Student.find(params[:id])
  end

  def new
    @student = Student.new
  end

  def create
    @student = Student.new(student_params)
    sorting_hat

    if @student.save
      redirect_to root_path
      # success: "Student #{@student.name} welcome to Hogwarts!!"
    else
      render :index
    end
  end

  def edit
    @student = Student.find(params[:id])
  end

  def update
    @student = Student.find(params[:id])
    @student.update(student_params)
    redirect_to students_path

    # if @student.update(student_params)
    #   redirect_to students_path,
    #   # success: "Student #{@student.name} was updated"
    # else
    #   render 'edit'
    # end
  end

  def school_sort
    students_array = Student.all
    new_house = 0
    shuffled_students = Student.all.shuffle
    shuffled_students.each do |student|
      # Sort first four students into houses
      if students_array.index(student) < 4
        new_house = students_array.index(student) + 1
      # Sort rest of students by index into houses
      else
        new_house = (students_array.index(student) % 4) + 1
      end

      # Checks num of students in houses to find house with lowest enrollment
      i = 1
      house_id_hash = {}
      4.times do
        house_id_hash["house_id: #{i}"] = (students_array.where(house_id: i).count)
        i = i + 1
      end
      smallest_house_num = house_id_hash.values.sort.first
      # get the house id with the least amount of students
      smallest_house = house_id_hash.key(smallest_house_num).split(//).last.to_i

      # Makes sure student isnt sorted in the same house as last time
      if new_house != student.house_id
        student.update_attribute(:house_id, new_house)
      elsif new_house != smallest_house
          student.update_attribute(:house_id, smallest_house)
      else
        small_house_num = house_id_hash.values.sort.second
        small_house = house_id_hash.key(small_house_num).split(//).last.to_i
        student.update_attribute(:house_id, small_house)
      end
    end
    redirect_to houses_path
  end

  private
    def sorting_hat
      house_array = House.all
      @student.house_id = house_array.sample.id
    end

  protected
   def student_params
     params.require(:student).permit(:name, :house_id)
   end
end
