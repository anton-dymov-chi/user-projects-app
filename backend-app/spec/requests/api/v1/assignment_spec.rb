require 'swagger_helper'

RSpec.describe 'api/v1/assignment', type: :request do
  path '/api/v1/assignments' do
    get('list assignments') do
      tags 'Assignments'
      produces 'application/json'
      consumes 'application/json'

      let!(:assignments) { create_list(:assignment, 10) }
      let(:page) { 1 }
      let(:per_page) { 5 }
      let(:expected_result) { AssignmentSerializer.new(assignments[0...5]).serializable_hash.to_json }
      let(:assignmentable_id) { nil }
      let(:assignmentable_type) { nil } 
      
      parameter name: :page, in: :query, type: :integer, description: 'page'
      parameter name: :per_page, in: :query, type: :integer, description: 'per page'
      parameter name: :assignmentable_id, in: :query, type: :integer, description: 'Assignmentable id'
      parameter name: :assignmentable_type, in: :query, type: :string, description: 'Assignmentable type'

      response(200, 'successful') do
        run_test! do |response|
          expect(JSON.parse(response.body)['data'].size).to eq(5)
          expect(response.body).to eq(expected_result)
        end
      end

      context 'when assignmentable params has passed' do
        let(:employee) { create(:employee) }
        let(:assignmentable_id) { employee.id }
        let(:assignmentable_type) { 'Employee' }
        let(:page) { nil }
        let(:per_page) { nil } 
        let(:assignments) { create_list(:assignment, 10, assignmentable_id:, assignmentable_type:) }
        let(:expected_result) { AssignmentSerializer.new(assignments).serializable_hash.to_json }

        response(200, 'success') do
          run_test! do |response|
            expect(response.body).to eq(expected_result)
            expect(JSON.parse(response.body)['data'].size).to eq(10) 
          end
        end
      end
    end

    post('create assingment') do
      tags 'Assignments'
      
      produces 'application/json'
      consumes 'application/json'
      parameter name: :assignment, in: :body, schema: {
        type: :object,
        properties: {
          rnd_percentage: { type: :float, description: 'RND percentage' },
          months: { type: :integer, description: 'Months' },
          assignmentable_id: { type: :integer, description: 'Employee/Contractor ID' },
          assignmentable_type: { type: :string, description: 'Employee or Contractor' },
          project_id: { type: :integer, description: 'Project ID' }
        },
        required: %w[ rnd_percentage months assignmentable_id assignmentable_type project_id ]
      }

      let(:project) { create(:project) }
      let(:employee) { create(:employee) } 
      let(:assignment_attrs) { attributes_for(:assignment, project_id: project.id, assignmentable_id: employee.id, assignmentable_type: 'Employee') } 
      let!(:assignment) { { assignment: assignment_attrs } }

      response(200, 'assignment created') do
        run_test!
      end

      response(422, 'cannot create assignment') do
        let(:assignment_attrs) { attributes_for(:assignment, project_id: project.id) }
        let(:error_message) do 
          "Validation failed: Assignmentable must exist, Assignmentable can't be blank, Assignmentable type can't be blank"
        end
        let(:expected_error) { { error: 'record_invalid', message: error_message } } 

        run_test! do |response|
          expect(JSON.parse(response.body, symbolize_names: true)).to eq(expected_error)
        end
      end
    end
  end

  path '/api/v1/assignments/{id}' do
    get('show assignment') do
      tags 'Assignments'
      produces 'application/json'
      consumes 'application/json'

      parameter name: :id, in: :path, type: :integer, description: 'Assignment ID'

      let(:assignment) { create(:assignment) }
      let(:expected_result) { AssignmentSerializer.new(assignment).serializable_hash.to_json } 
      let(:id) { assignment.id }
      
      response(200, 'assignment found') do
        run_test! do |response|
          expect(response.body).to eq(expected_result)  
        end
      end

      response(404, 'not found') do
        let(:id) { 'invalid' }
        let(:expected_error) { { error: 'not_found', message: "Couldn't find Assignment with 'id'=invalid" } }

        run_test! do |response|
          expect(JSON.parse(response.body, symbolize_names: true)).to eq(expected_error)
        end
      end
    end

    put('update assignment') do
      tags 'Assignments'
      produces 'application/json'
      consumes 'application/json'

      parameter name: :id, in: :path, type: :integer, description: 'Assignment ID'
      parameter name: :assignment, in: :body, schema: {
        type: :object,
        properties: {
          rnd_percentage: { type: :float, description: 'RND percentage' },
          months: { type: :integer, description: 'Months' },
          assignmentable_id: { type: :integer, description: 'Employee/Contractor ID' },
          assignmentable_type: { type: :string, description: 'Employee or Contractor' },
          project_id: { type: :integer, description: 'Project ID' }
        }
      }

      let(:employee) { create(:employee) }
      let(:project) { create(:project) }
      let(:created_assignment) do 
        create(:assignment, 
               rnd_percentage: 10, 
               assignmentable: employee, 
               project_id: project.id)
      end
      let(:id) { created_assignment.id } 
      
      response(200, 'updated assignment') do
        let(:assignment) { { rnd_percentage: 12 } }

        run_test! do |response|
          expect(JSON.parse(response.body)['data']['attributes']['rnd_percentage']).to eq(12.0)  
        end
      end

      response(404, 'assignment not found') do
        let(:id) { 'invalid' }
        let(:assignment) { { rnd_percentage: 12 } }

        run_test!
      end

      response(422, 'invalid updates assignment') do
        let(:assignment) { { months: 'invalid' } }

        run_test!
      end
    end
  end
end
