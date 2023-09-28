class EmployeeSerializer
  include JSONAPI::Serializer
  attributes :name, :salary, :total_apportionment
end
