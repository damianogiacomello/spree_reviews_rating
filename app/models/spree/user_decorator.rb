Spree.user_class.class_eval do
  before_create :set_role
  
  def set_role
    self.spree_role_ids = Spree::Role.find_or_create_by_name("user").id
  end    
end
