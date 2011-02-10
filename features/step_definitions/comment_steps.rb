Given /^(\d+) unmoderated Comment$/ do |number|
  raw_response = RestClient.post('http://10.63.36.213:8081/reader-comments/comment/create', 
    :userAlias => 'Matt',
    :userLocation => 'London',
    :message => 'Test Message',
    :assetId => 1355515,
    :assetTypeId => 1
  )
  
  response = JSON.parse(raw_response)
  
  if response['status'] == 'error'
    raise "Response failed: #{response.inspect}"
  end
  
  raw_response = RestClient.post('http://10.63.36.213:8081/reader-comments/comment/activate',
    :commentId => response['payload'],
    :userKey => 'asdfasfasdfasdfasd',
    :userEmail => 'test@test.com'
  )
  
  response = JSON.parse(raw_response)

  if response['status'] == 'error'
    raise "Response failed: #{response.inspect}"
  end
end

When /^the moderator publishes the Comment$/ do
  pending # express the regexp above with the code you wish you had
end

Then /^the moderator sees a green indication that the status has changed$/ do
  pending # express the regexp above with the code you wish you had
end

Then /^the Comment should be displayed on the Article page$/ do
  pending # express the regexp above with the code you wish you had
end

Then /^the moderator should see that there is (\d+) published Comment$/ do |arg1|
  pending # express the regexp above with the code you wish you had
end
