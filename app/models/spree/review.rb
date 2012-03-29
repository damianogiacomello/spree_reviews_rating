module Spree
  class Review < ActiveRecord::Base
    belongs_to :product
    belongs_to :user

    validates_presence_of :name, :review
    validates_numericality_of :rating, :if => Proc.new {|r| !r.rating.blank?}
    default_scope order("created_at DESC")
    scope :not_approved, where("approved = ?", false)

    scope :approved, lambda {|*args| {:conditions => ["(? = ?) or (approved = ?)", Spree::Config[:include_unapproved_reviews], true, true ]}}

    scope :oldest_first, :order => "created_at asc"
    scope :preview, :limit => Spree::Config[:preview_size], :order => "created_at desc"
    attr_accessible :rating, :review, :name
    
  end
end
