# TL;DR: YOU SHOULD DELETE THIS FILE
#
# This file is used by web_steps.rb, which you should also delete
#
# You have been warned
module NavigationHelpers
  # Maps a name to a path. Used by the
  #
  #   When /^I go to (.+)$/ do |page_name|
  #
  # step definition in web_steps.rb
  #
  def path_to(page_name)
    case page_name

    when /^the home\s?page$/
      '/'
    when /^the admin home\s?page$/
      '/admin'
    when /^the admin content page$/
      '/admin/content'
    when /^the new article page$/
      '/admin/content/new'
    when /^the show article (.*) page$/
      article_path($1)    
    when /^the comments feewdback for article (.*) page$/
      feedback_path($1)
    when /^the (.*) article (.*)$/
      content_path($1, $2)
    when /^the new category page$/
      '/admin/categories/new'      
    
    # Add more mappings here.
    # Here is an example that pulls values out of the Regexp:
    #
    #   when /^(.*)'s profile page$/i
    #     user_profile_path(User.find_by_login($1))

    else
      begin
        page_name =~ /^the (.*) page$/
        path_components = $1.split(/\s+/)
        self.send(path_components.push('path').join('_').to_sym)
      rescue NoMethodError, ArgumentError
        raise "Can't find mapping from \"#{page_name}\" to a path.\n" +
          "Now, go and add a mapping in #{__FILE__}"
      end
    end
  end
  
  def content_path(action, id)
    "/admin/content/#{action}/#{id}" 
  end
  
  def article_path(id)
    "/article/show/#{id}" 
  end
  
  def feedback_path(id)
    "/admin/feedback/article/#{id}" 
  end
end

World(NavigationHelpers)
