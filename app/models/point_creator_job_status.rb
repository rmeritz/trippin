class PointCreatorJobStatus < ActiveRecord::Base
  belongs_to :point, optional: true
end
