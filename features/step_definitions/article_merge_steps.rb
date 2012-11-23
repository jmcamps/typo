Given /^the blog data is published$/ do
  Blog.default.update_attributes!({:blog_name => 'Teh Blag',
                                   :base_url => 'http://localhost:3000'});
  Blog.default.save!
 
  admin_user = User.new({:login => 'admin',
                :password => 'aaaaaaaa',
                :email => 'joe@snow.com',
                :profile_id => 1,
                :name => 'admin',
                :state => 'active', 
                :id => 1})
  admin_user.save!
                
  User.create!({:login => 'publisher',
                :password => 'pppppp',
                :email => 'publisher@snow.com',
                :profile_id => 2,
                :name => 'publisher',
                :state => 'active',
                :id => 2})
                
  User.create!({:login => 'contributor',
                :password => 'cccccc',
                :email => 'contributor@snow.com',
                :profile_id => 3,
                :name => 'contributor',
                :state => 'active',
                :id => 3})
  
  create_article_with_comment("1", "Admin article", "Body for admin article", 1, "admin", "Admin comment")
  create_article_with_comment("2", "Publisher article", "Body for publisher article", 1, "publisher", "Publisher comment")

  
     
end

def create_article_with_comment(guid,title,body,user_id,author,comment)
      article = Article.new(:allow_comments => true, 
                  :allow_pings => true, 
                  :author => author, 
                  :body => body, 
                  :guid => guid, 
                  :permalink => "hello-world", 
                  :post_type => "read", 
                  :published => true, 
                  :published_at => "2012-06-09 21:51:55 UTC", 
                  :settings => {"password"=>nil}, 
                  :state => "published", 
                  :text_filter_id => 5, 
                  :title => title, 
                  :type => "Article", 
                  :user_id => user_id)
      comment = Comment.new(:published => true,          
                  :author => 'Bob Foo',
                  :url => 'http://fakeurl.com',
                  :body => comment,
                  :created_at => '2005-01-01 02:00:00',
                  :updated_at => '2005-01-01 02:00:00',
                  :published_at => '2005-01-01 02:00:00',
                  :guid => '12313123123123123',
                  :state => 'ham')
      article.save!  
      article.comments << comment
      article.save!
  end

And /^I am logged as admin$/ do
  visit '/accounts/login'
  fill_in 'user_login', :with => 'admin'
  fill_in 'user_password', :with => 'aaaaaaaa'
  click_button 'Login'
  if page.respond_to? :should
    page.should have_content('Login successful')
  else
    assert page.has_content?('Login successful')
  end
end

And /^I am logged as publisher$/ do
  visit '/accounts/login'
  fill_in 'user_login', :with => 'publisher'
  fill_in 'user_password', :with => 'pppppp'
  click_button 'Login'
  if page.respond_to? :should
    page.should have_content('Login successful')
  else
    assert page.has_content?('Login successful')
  end
end

And /^I am logged as contributor$/ do
  visit '/accounts/login'
  fill_in 'user_login', :with => 'contributor'
  fill_in 'user_password', :with => 'cccccc'
  click_button 'Login'
  if page.respond_to? :should
    page.should have_content('Login successful')
  else
    assert page.has_content?('Login successful')
  end
end

Given /^I merge article (.*) with article (.*)$/ do |first, second|
    steps %Q{
      Given I am logged as admin
      And I go to the edit article #{first}
      When I fill in "merge_with" with "#{second}"
      And I press "Merge" 
      Then I should be on the admin content page
      And I should see "Articles were successfully merged."
    }
end
