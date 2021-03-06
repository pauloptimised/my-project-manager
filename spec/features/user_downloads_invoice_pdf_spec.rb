require "rails_helper"

describe "User downloads invoice PDF" do
  scenario "after creating the invoice" do
    user = create(:user)
    address = create(:address)
    project = create(:finalised_project, billing_address: address)
    print_job = create(:finalised_print_job, project: project, name: "Print Job 1", description: "Print Job Description")

    sign_in_with(user.email, user.password)
    go_to_project_page(project)
    click_on "Invoices"
    click_on "Add Percentage Invoice"

    fill_in "percentage_invoice_creator_percentage", with: 50
    fill_in "percentage_invoice_creator_name", with: "Name"
    click_on "Create Invoice"
    click_on "Download"

    expect(content_type).to eq("application/pdf")
    expect(content_disposition).to include("inline")
    expect(pdf_body).to have_content("Print Job 1")
    expect(pdf_body).to have_content("Print Job Description")
    expect(pdf_body).to have_content(print_job.envisage_to_my_price)
    expect(pdf_body).to have_content(print_job.brand_price)
  end
end
