class Factor < ActiveRecord::Base
  validates_presence_of :name
  has_many :factor_choices

  def progress_factor?
    # TODO: consider alternatives to hard-coding ids
    [3, 4, 7, 8].include? id
  end
end
