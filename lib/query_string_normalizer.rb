# We need a simple normalizer that will not URI escape []s.
QueryStringNormalizer = proc do |query_hash|
  query_hash.map do |key, value|
    value_string = case value
    when Array
      value.join(',')
    else
      # If value is a string, it will be frozen, so dup it.
      value.to_s.dup
    end
    # Escape spaces.
    value_string.gsub!(' ', '%20')
    "#{key}=#{value_string}"
  end.join('&')
end
