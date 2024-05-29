require 'json'

# assume `Record` is an active record model

module SomeExample
  class API < Grape::API
    format :json

    resource :records do
      desc "Returns records from parameters"
      params do
        requires :gender, type: String, desc: "Gender"
        requires :birthdate, type: DateTime, desc: "Birthdate"
        requires :sorted_by, type: String, desc: "Sorted By"
      end
      get :query do
        Record
          .where(gender: gender, birthdate: birthdate)
          # NOTE: this could be SQL-injected, not best practice
          .order("#{sorted_by} DESC")
      end

      desc "Return a record"
      params do
        requires :id, type: Integer, desc: 'Status ID.'
      end
      route_param :id do
        get do
          Record.find(params[:id])
        end

        desc "Delete a record"
        destroy do
          # NOTE: there are ways in Grape to reuse/share this as @record, see documentation for examples
          record = Record.find(params[:id])

          record.destroy
        end
      end

      desc "Add a single record"
      params do
        requires :name, type: String, desc: 'Name'
        requires :gender, type: String, desc: "Gender"
        requires :birthdate, type: DateTime, desc: "Birthdate"
      end
      post '/' do
        # NOTE: in Rails, use strong params
        # https://api.rubyonrails.org/classes/ActionController/StrongParameters.html
        # https://medium.com/@danielmutubait/rails-strong-parameters-and-why-you-need-them-b539d9c8685e
        Records.save(params)
      end
    end
  end
end
