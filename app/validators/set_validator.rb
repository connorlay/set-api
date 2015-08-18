class SetValidator < ActiveModel::EachValidator

  def validate_each(record, attribute, cards)
    return false unless check_input(record, attribute, cards)
    cards.first.attributes.keys.each do |attr|
      values = cards.map { |card| card.attributes[attr] }
      unless same_or_unique?(values)
        record.errors[attr] << "is not all the same or unique."
      end
    end
  end

  private

  def same_or_unique?(collection)
    collection.uniq.length == collection.length || collection.uniq.length == 1
  end

  def check_input(record, attribute, cards)
    record.errors[attribute] << "is nil." if cards.nil?
    if cards.try(:none?) { |card| card.respond_to? :attributes }
      record.errors[attribute] << "elements must respond to :attributes"
    end
    if cards.try(:size).try(:zero?)
      record.errors[attribute] << "cannot be empty."
    end
    record.errors.messages.empty?
  end

end
