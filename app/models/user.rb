class User < ActiveRecord::Base
  has_many :sessions, dependent: :destroy

  validates :name, presence: true

  def transfer_to_json
    as_json(except: [:updated_at, :created_at])
  end
end
