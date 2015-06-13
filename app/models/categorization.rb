# == Schema Information
#
# Table name: categorizations
#
#  post_id     :integer
#  category_id :integer
#

class Categorization < ActiveRecord::Base
  belongs_to :post
  belongs_to :category
end
