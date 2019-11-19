class VersionHistory < ActiveRecord::Base
  before_create :before_save_action

  def before_save_action
    index = VersionHistory.all.size == 0 ? 0 : VersionHistory.last.version
    self.version = index + 1
  end
end
