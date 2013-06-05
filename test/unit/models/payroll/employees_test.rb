require 'test_helper'

class EmployeesTest < Test::Unit::TestCase
  include TestHelper
  
  def setup
    @client = Xeroizer::PublicApplication.new(CONSUMER_KEY, CONSUMER_SECRET).payroll
    mock_api('Employees')
  end

  test "get all" do
    employees = @client.Employee.all
    assert_equal 7, employees.length

    employee = @client.Employee.find(employees.first.id)
    assert_not_nil employee.home_address
    assert_equal 2, employee.bank_accounts.length
    assert_equal 1, employee.super_memberships.length

    assert_not_nil employee.pay_template
    assert_equal 1, employee.pay_template.earnings_lines.length

=begin
    pay_items = @client.PayItem.first
    assert_equal 4, pay_items.earnings_rates.size
    assert_equal 5, pay_items.deduction_types.size
    assert_equal 2, pay_items.reimbursement_types.size
    assert_equal 9, pay_items.leave_types.size

    doc = Nokogiri::XML pay_items.to_xml
    assert_equal 4, doc.xpath("/PayItems/EarningsRates/EarningsRate").size
    assert_equal 5, doc.xpath("/PayItems/DeductionTypes/DeductionType").size
    assert_equal 2, doc.xpath("/PayItems/ReimbursementTypes/ReimbursementType").size
    assert_equal 9, doc.xpath("/PayItems/LeaveTypes/LeaveType").size
=end
  end
end
