class Brand < ActiveRecord::Base
  MY_BRANDS = %w( my_office_branding my_vehicle_wrap my_print_services my_design my_internet_marketing my_team optimised ).freeze

  scope :my_brand, -> { where(brand_type: Brand.brand_types.select { |x| Brand::MY_BRANDS.include?(x) }.values) }
  scope :envisage_brand, -> { where.not(brand_type: Brand.brand_types.select { |x| Brand::MY_BRANDS.include?(x) }.values) }

  has_one :brand_address

  enum brand_type: [
    :my_office_branding,
    :envisage,
    :envisage_trade,
    :my_vehicle_wrap,
    :my_print_services,
    :my_design,
    :my_internet_marketing,
    :my_team,
    :optimised
  ]
  validates :company_name, presence: true, inclusion: { in: Company::COMPANY_NAMES }
  validates :name, presence: true
  validates :email, presence: true
  validates :brand_type, presence: true
  validates :account_management_rate, presence: true, numericality: { greater_than_or_equal_to: 0.0 }

  delegate :logo, :colour, to: :brand_graphics

  delegate :base_invoice_number, to: :company, prefix: true, allow_nil: true

  belongs_to :company

  def brand_graphics
    @brand_graphics ||= BrandGraphics.klass_for(brand_type).new
  end

  def my_brand?
    MY_BRANDS.include?(brand_type)
  end

  def my_print_services?
    brand_type == 'my_print_services'
  end

  def vehicle_brand?
    brand_type == 'my_vehicle_wrap'
  end

  def prefix
    if my_brand?
      company.prefix
    else
      'EN'
    end
  end
end
