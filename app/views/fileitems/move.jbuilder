json.errors do
  json.array!(@file.errors.full_messages) do |message|
    json.message message
  end
end
