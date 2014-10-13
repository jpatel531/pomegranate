class Progression < ActiveRecord::Base
  belongs_to :user
  belongs_to :tutorial

  after_save :default_value

  def advance_to step_number
  	update(steps_completed: step_number)
  end

  private

  def default_value
  	update(steps_completed: 0) if steps_completed.nil?
  end

end