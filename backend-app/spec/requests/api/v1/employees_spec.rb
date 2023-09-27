require 'swagger_helper'

RSpec.describe 'api/v1/employees', type: :request do

  path '/api/v1/employees' do
    let(:employees) { create_list(:employee, 10) }

    parameter name: :page, in: :query, type: :integer, description: 'page'
    parameter name: :per_page, in: :query, type: :integer, description: 'per page'
    get('list employees') do
      response(200, 'successful') do

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end
    end
  end

  path '/api/v1/employees/{id}' do
    # You'll want to customize the parameter types...
    parameter name: 'id', in: :path, type: :string, description: 'id'

    get('show employee') do
      response(200, 'successful') do
        let(:employee) { create(:employee) }
        let(:id) { employee.id }

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end
    end
  end
end
