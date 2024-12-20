class Kitten < ApplicationRecord
  def as_json(options = {})
    super({ only: [ :name, :cuteness, :softness ] }.merge(options))
  end
end
