@reason_recorder = []
['too many emails', 'no longer interested', 'other reason'].each do |reason|
  if reason == 'too many emails'
    @reason_recorder << "too many emails from you"
  end
  if reason == 'no longer interested'
    @reason_recorder << "no longer interested in this stuff"
  end
  if reason == 'other reason'
    @reason_recorder << "another reason"
  end
end
