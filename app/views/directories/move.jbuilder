json.errors do
  json.array!(@directory.errors.full_messages) do |message|
    json.message message
  end
end
