# frozen_string_literal: true

class EmailTemplate < ApplicationRecord
  belongs_to :org
  has_rich_text :content
end
