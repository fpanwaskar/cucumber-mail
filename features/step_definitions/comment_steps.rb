Given /^(\d+) unmoderated Comment$/ do |number|
  @asset_id = Time.now.to_i
  @comment = {
    'userAlias' => 'Matt',
    'userLocation' => 'London',
    'message' => 'Test Message',
  }
  
  raw_response = RestClient.post('http://10.63.36.213:8081/reader-comments/comment/create', 
    :userAlias => @comment['userAlias'],
    :userLocation => @comment['userLocation'],
    :message => @comment['message'],
    :assetId => @asset_id,
    :assetTypeId => 1
  )
  
  response = JSON.parse(raw_response)
  
  if response['status'] == 'error'
    raise "Response failed: #{response.inspect}"
  end
  
  @comment_id = response['payload']
  
  raw_response = RestClient.post('http://10.63.36.213:8081/reader-comments/comment/activate',
    :commentId => @comment_id,
    :userKey => 'asdfasfasdfasdfasd',
    :userEmail => 'test@test.com'
  )
  
  response = JSON.parse(raw_response)

  if response['status'] == 'error'
    raise "Response failed: #{response.inspect}"
  end
end

When /^the moderator publishes the Comment$/ do
  visit '/'
  
  within('.login') do
    fill_in 'username', :with => 'admin'
    fill_in 'password', :with => 'password4321'
    click_button 'Sign in'
  end
  
  within('#articleSearch') do
    fill_in 'id', :with => @asset_id
    click_button 'Search'
  end
  
  find('input.statusPub').click
end

Then /^the moderator sees a green indication that the Comment is now published$/ do
  # we've said "the Comment" so let's check there's only one:
  assert_equal 1, all(:xpath, '//*[@id="commentList"]/li').length
  
  assert page.has_css?('#commentList li.pub')
end

Then /^the Comment should be displayed on the Article page$/ do
  raw_response = RestClient.get("http://10.63.36.213:8081/reader-comments/comment/read/#{@comment_id}")
  
  response = JSON.parse(raw_response)

  if response['status'] == 'error'
    raise "Response failed: #{response.inspect}"
  end
  
  @comment.each do |key, value|
    announce "#{key}: #{response['payload'][key]}"
    assert_equal value, response['payload'][key]
  end
end

Then /^the moderator should see that there is (\d+) published Comment$/ do |number|
  assert_equal number.to_i, find('#publishedCounter').text.to_i
end
