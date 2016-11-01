reason_props = OpenStruct.new(short_desc: "", reason_types: [:too_many_emails, :no_longer_interested, :other_reason])
unsubscribe_reasons = UnsubscribeReasonFactory.build_collection(reason_props)
unsubscribe_reasoner = UnsubscribeReasoner.new(reason_props: reason_props)
unsubscribe_reasons.each do |reason|
  unsubscribe_reasoner.update_reason(reason_type: reason.class)
end

class UnsubscribeReasons
  def self.all
    [TooManyEmails, NoLongerInterested, OtherReason]
  end
end

class UnsubscribeReasonFactory
  def self.build_collection(reason_props)
    UnsubscribeReasons.all.select { |reason| reason.has_reason?(reason_props) }.map { |reason| reason.new(reason_props) }
  end
end

class UnsubscribeReason
  attr_accessor :reason_props

  def initialize(reason_props)
    @reason_properties = reason_props
  end
end

class TooManyEmails < UnsubscribeReason
  def self.has_reason?(reason_props)
    reason_props[:reason_types].include?(:too_many_emails)
  end
end

class NoLongerInterested < UnsubscribeReason
  def self.has_reason?(reason_props)
    reason_props[:reason_types].include?(:no_longer_interested)
  end
end

class OtherReason < UnsubscribeReason
  def self.has_reason?(reason_props)
    reason_props[:reason_types].include?(:other_reason)
  end
end

class UnsubscribeReasoner
  attr_accessor :reason_props, :reason_list

# use reason_list as the pivot point in the code that contains if statements
  def initialize(reason_props:)
    @reason_props = reason_props
    @reason_list = []
  end

  def update_reason(reason_type:)
    reason_type = reason_type.name.underscore
    public_send("update_reason_with_#{reason_type}".to_sym)
  rescue NoMethodError
    nil
  end

  def update_reason_with_too_many_emails
    reason_list << "I received too many emails"
  end

  def update_reason_with_no_longer_interested
    reason_list << "I am no longer interested" 
  end

  def update_reason_with_other_reason
    reason_list << "I have another reason"
  end
end
