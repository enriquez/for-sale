Factory.define :user do |f|
  f.login     { "user" }
  f.password  { "password" }
  f.password_confirmation   { "password" }
end

Factory.define :administrator, :parent => :user do |user|
  user.login    { "admin" }
  user.role     { "Admin" }
end