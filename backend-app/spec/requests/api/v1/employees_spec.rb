require 'swagger_helper'

RSpec.describe 'api/v1/employees', type: :request do
  path '/api/v1/employees' do
    parameter name: :page, in: :query, type: :integer, description: 'page'
    parameter name: :per_page, in: :query, type: :integer, description: 'per page'

    let!(:employees) { create_list(:employee, 10) }
    let(:page) { 1 }
    let(:per_page) { 5 }
    let(:expected_result) { EmployeeSerializer.new(employees[0...5]).serializable_hash.to_json }
    
    get('list employees') do
      tags 'Employees'

      produces 'application/json'
      consumes 'application/json'
      
      response(200, 'successful') do
        run_test! do |response|
          expect(JSON.parse(response.body)['data'].size).to eq(5)
          expect(response.body).to eq(expected_result)
        end
      end
    end
  end

  path '/api/v1/employees/{id}' do
    parameter name: 'id', in: :path, type: :integer, description: 'id'
    
    get('show employee') do
      tags 'Employees'

      let!(:employee) { create(:employee) }
      let(:id) { employee.id }
      let(:expected_result) { EmployeeSerializer.new(employee).serializable_hash.to_json } 
      response(200, 'successful') do
        run_test! do |response|
          expect(response.body).to eq(expected_result)  
        end
      end

      response(404, 'not found') do
        let(:id) { 'invalid' }
        let(:expected_error) { { error: 'not_found', message: "Couldn't find Employee with 'id'=invalid" } } 
        run_test! do |response|
          expect(JSON.parse(response.body, symbolize_names: true)).to eq(expected_error)
        end
      end
    end
  end
end
