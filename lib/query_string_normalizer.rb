# We need a simple normalizer that will not URI escape []s.
QueryStringNormalizer = proc do |query_hash|
  query_hash.map do |key, value|
    value_string = case value
    when Array
      value.join(',')
    else
      value
    end
    "#{key}=#{value_string}"
  end.join('&')
end
