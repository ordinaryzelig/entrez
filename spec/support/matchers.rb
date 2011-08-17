RSpec::Matchers.define :take_longer_than do |seconds|
  match do |process|
    @elapsed_time = timer(&process)
    @elapsed_time > seconds
  end
  failure_message_for_should do
    "Expected process to take longer than #{seconds} seconds (actual: #{@elapsed_time})"
  end
end
