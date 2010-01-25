class User < ActiveRecord::Base
  acts_as_authentic
  ROLES = ["Admin"]
end