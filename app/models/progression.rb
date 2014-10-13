class Progression < ActiveRecord::Base
  belongs_to :user
  belongs_to :tutorial

  after_save :default_values

  def advance_to step_number
  	update(steps_completed: step_number)
  end

  private

  def default_values
  	update(steps_completed: 0) if steps_completed.nil?
  	update(last_input: "") if last_input.nil?
  end

end