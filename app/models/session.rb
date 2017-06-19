class Session < ActiveRecord::Base
  belongs_to :user
  before_create :time_to_second
  before_update :time_to_second

  validates :time, :user_id, presence: true

  def transfer_to_json
    as_json(except: [:updated_at, :created_at])
  end

  def time_to_second
    self.second = StringToTime.sec(time)
  end
end
