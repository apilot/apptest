class Admin::LessonsController < Admin::BaseController
  add_breadcrumb 'Уроки', :admin_lessons_path
  before_action :set_lesson, only: [:edit, :update, :destroy]

  def index
    @lessons = Lesson.order(id: :desc).page(params[:page])
  end
  def new
    add_breadcrumb "Новый урок", new_admin_lesson_path
    @lesson = Lesson.new
    build_sections
  end

  def create
    @lesson = Lesson.new(lesson_params)

    if @lesson.save
      redirect_to admin_lessons_path, notice: "Урок успешно создан"
    else
      add_breadcrumb "Новый урок", new_admin_lesson_path
      build_sections

      flash.now[:alert] = 'Не удалось создать Урок'
      render :new
    end
  end

  def edit
    build_sections

    add_breadcrumb "Редактировать #{@lesson.name}", [:edit, :admin, @lesson]
  end
  def update
    if @lesson.update(lesson_params)
      redirect_to admin_lessons_path, notice: 'Урок успешно изменен'
    else
      add_breadcrumb "Редактировать #{@lesson.name}", [:edit, :admin, @couse]
      build_sections

      flash.now[:alert] = 'Не удалось изменить Урок'
      render :edit
    end
  end
def destroy
  if @lesson.destroy
    redirect_to admin_lessons_path, notice: 'Урок успешно удален'
  else
    redirect_to admin_lessons_path, alert: "Не удалось удалить Урок, #{@lesson.errors.full_messages.join(', ')}"
  end
end


  private

  def set_lesson
    @lesson = Lesson.find(params[:id])
  end

  def set_active_main_menu_item
    @main_menu[:lessons][:active] = true
  end
  def build_sections
    @lesson.sections.build if @lesson.sections.empty?
  end
  def lesson_params
    params.require(:lesson).permit(:name, :description, :teacher_id, :main_image,
                          :main_image_cache, discipline_ids: [],
                        sections_attributes: [:_destroy, :id, :name, :description, :position])
  end

end
