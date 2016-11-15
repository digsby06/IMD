class Group < ActiveRecord::Base
  has_many :uploads, :dependent => :destroy
  default_scope { order('created_at DESC') }

end
