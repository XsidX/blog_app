class ApplicationController < ActionController::Base
  def current_user
    temp_user = User.new(name: 'Brad', photo: 'https://randomuser.me/api/portraits/men/65.jpg', Bio: 'Brad has worked in the technology and association space for more than 15 years now. He is the CEO and President of MemberClicks, an all-in-one membership management software company, and has helped them grow from just under 300 customers in 2004 to 3,000 today across North America.')
    @current_user = User.all.find(1) || temp_user
  end
end
