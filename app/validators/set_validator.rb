class SetValidator < ActiveModel::EachValidator

  def validate_each(record, attribute, cards)

    return false if cards.nil? || cards.empty?

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

end
