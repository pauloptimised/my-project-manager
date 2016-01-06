require "rails_helper"

describe "User manages a print job's labour items", type: :feature do
  scenario "adds labour item" do
    print_job = create(:print_job)
    labour = create(:labour)

    visit print_job_path(print_job)
    click_on "Add Labour"

    fill_form(:labour_item, { hours: 2, labour_id: labour.name })
    click_on "Create Labour item"

    expect(current_path).to eq(print_job_path(print_job))
    expect(page).to have_css ".labour-item", text: labour.name
  end

  scenario "edits labour item" do
    labour_item = create(:labour_item)

    visit print_job_path(labour_item.print_job)
    edit_labour_item(labour_item)

    fill_in "Hours", with: 3
    click_on "Update Labour item"

    expect(page).to have_css ".labour-item", text: "3.0 hours"
  end

  scenario "destroys labour item" do
    labour_item = create(:labour_item)

    visit print_job_path(labour_item.print_job)
    destroy_labour_item(labour_item)

    expect(page).not_to have_css "#labour_item_#{ labour_item.id }"
  end

  def edit_labour_item(labour_item)
    within "#labour_item_#{ labour_item.id }" do
      click_on "Edit"
    end
  end

  def destroy_labour_item(labour_item)
    within "#labour_item_#{ labour_item.id }" do
      click_on "Remove"
    end
  end
end
