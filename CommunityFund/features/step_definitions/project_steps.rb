Then(/^I fill in my project details$/) do
  fill_in 'project_name', with: "New Project"
  fill_in 'project_description', with: "A brand new community project"
  fill_in 'project_target_amount', with: "1000"
  check "community_#{Community.active.first.id}"
  # TODO - rewards
end

Then(/^I click on the "(.*?)" button$/) do |arg1|
  click_button(arg1)
end

Then(/^I click on the "(.*?)" link$/) do |arg1|
  click_link(arg1)
end


Then(/^the project info should be shown$/) do
  @project = Project.last
  page.has_content? "New Project"
  page.has_content? "A brand new community project"
  page.has_content? "$1000"
  page.has_content? "To be completed: At midnight on #{@project.completion_date_for_display}"
  page.has_content? "Edit"
end

Then(/^I should see the edit details$/) do
  page.has_content? "Edit #{@project.name}"
end

Then(/^I edit the project$/) do
  fill_in 'project_description', with: "Some new description"
  fill_in 'project_target_amount', with: "1500"
  # rewards will be tested in form
  click_button("save_button")
end

Then(/^I blank the edit fields$/) do
  fill_in 'project_description', with: ""
  fill_in 'project_name', with: ""
  fill_in 'project_target_amount', with: ""
  click_button("save_button")
end

Then(/^the project should not be saved$/) do
  page.has_content? "Please enter a name"
  page.has_content? "Please enter a description"
  page.has_content? "Please enter an amount greater than $100"
end