module Validation

  private

  def dot_in_name
    errors.add(:name, 'must contain at least one period symbol (.)') unless name.include? ?.
  end
end
