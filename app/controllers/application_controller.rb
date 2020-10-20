class ApplicationController < ActionController::Base

	def genres
       @genres=['All'];

       Genre.all.each do |genre|
       	@genres.push(genre.name.to_s)
       end
      @genres
	end

	def order 
		@order=['A-Z','Highest Rating First','Lowest Rating First','Newest First','Oldest First']
	end
	def auth_admin
    	if current_user.admin == false
    		redirect_to root_path
    	end
    end


	helper_method :genres

	helper_method :order
end
