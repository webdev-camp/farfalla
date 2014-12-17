unless Clerk.where( :email =>  "info@auringostaitaan.fi").first
  clerk = Clerk.new( :email =>  "info@auringostaitaan.fi" , :password => "password" ) 
  clerk.save!
end
