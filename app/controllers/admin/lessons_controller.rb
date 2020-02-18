class Admin::LessonsController < Admin::BaseController
  skip_before_action :set_active_main_menu_item, only: :sort
  before_action :set_course, except: :sort
  before_action :set_lesson, only: [:edit, :update, :destroy]

  def index
    @lessons = @course.lessons.order(:position).page(params[:page])
  end

  def new
    add_breadcrumb "Новое Занятие", [:new, :admin, @course, :lesson]

    @lesson = @course.lessons.build
  end

  def create
    @lesson = @course.lessons.build(lesson_params)

    if @lesson.save
      redirect_to after_save_path, notice: 'Занятие успешно создано'
    else
      add_breadcrumb "Новое Занятие", [:new, :admin, @course, :lesson]

      flash.now[:alert] = 'Не удалось создать Занятие'
      render :new
    end
  end

  def edit
    add_breadcrumb "Редактировать #{@lesson.name}", [:edit, :admin, @course, @lesson]
  end

  def update
    if @lesson.update(lesson_params)
      redirect_to after_save_path, notice: 'Занятие успешно изменено'
    else
      add_breadcrumb "Редактировать #{@lesson.name}", [:edit, :admin, @course, @lesson]
      flash.now[:alert] = 'Не удалось изменить Занятие'
      render :edit
    end
  end

  def destroy
    if @lesson.destroy
      redirect_to [:admin, @course, :lessons], notice: 'Занятие успешно удалено'
    else
      redirect_to [:admin, @course, :lessons], alert: 'Не удалось удалить Занятие'
    end
  end

  def sort
    params[:lessons].each_with_index do |id, index|
      Lesson.update_all({ position: index + 1 }, { id: id })
    end
    render nothing:true
  end
  private

  def set_course
    @course = Course.find(params[:course_id])

    add_breadcrumb 'Курсы', :admin_courses_path
    add_breadcrumb @course.name, [:admin, @course, :lessons]
  end

  def set_lesson
    @lesson = Lesson.find(params[:id])
  end

  def set_active_main_menu_item
    @main_menu[:courses][:active] = true
  end

  def lesson_params
    params.require(:lesson).permit(:name, :description, :section_id, :main_image,
                                   :main_image_cache, :stop_lesson, :free, :video, :without_homework,
                                   :homework)
  end

  def after_save_path
    if params[:commit] == 'Сохранить и продолжить'
      [:edit, :admin, @course, @lesson]
    else
      [:admin, @course, :lessons]
    end
  end
end
