class Source < ActiveResource::Base
  self.site = APP_CONFIG[:site]
  self.user = APP_CONFIG[:user]
  self.password = APP_CONFIG[:password]
  self.prefix = "/settings/"
end