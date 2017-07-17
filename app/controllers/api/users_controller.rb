module Api
  class UsersController < ::ApplicationController
    # Создание User обязательно поле name
    # если его нет то отдается ошибка
    def create
      user = User.create(user_params)
      render json: (user.errors.present? ? user.errors.messages : user.transfer_to_json)
    end

    def update
      render json: {success: find_user.update(user_params)}
    end

    def show
      render json: find_user.transfer_to_json
    end

    # Вывод всех Users
    def index
      render json: User.all.map(&:transfer_to_json)
    end

    # Вывод всех Session у выбранного User
    def sessions
      render json: find_user.sessions.map(&:transfer_to_json)
    end

    def amocrm
      amo = Amocrm.new
      email = params[:email]
      contact = amo.contact_find_by_email(email)
      param_contact = {  
        name: params[:fname], 
        custom_fields: [
          { 
            id: 241509, #phone
            values: [ {value: params[:phone], enum:  "HOME"} ]
          },{
            id: 241511, #email
            values: [ {value: email, enum:  "WORK"}]
          }
        ]
      }

      contact_id = contact.present? ? contact["id"] : amo.contact_create(param_contact)["add"].first["id"]
      param_lead = {  
        name: "Сделка с клиентом #{Time.now.to_i}", 
        custom_fields: [
          {
            id: 241549,  # OFERTA
            values:[ {value: params[:oferta] } ]
          },{
            id: 241569, # LEADS 
            values: [ { value: params[:lead] }]
          },{
            id: 241595,  # UTM_SOURCE
            values: [ { value: "vk" } ]
          },{
            id: 241601, #UTM_CONTENT
            values: [ { value: "content" } ]
          },{
            id: 241599, #UTM_CAMPAIGN
            values: [ { value: "genetica" } ]
          },{
            id: 241597, #UTM_MEDIUM
            values: [ { value: "cpc" } ]
          }
        ]
      }
      lead_id = amo.lead_create(param_lead)["add"].first["id"]
      amo.add_contact_to_lead(contact_id, lead_id)

      param_task = {
        element_id: lead_id,
        element_type: 2,
        task_type: 1,
        text: 'Связаться с клиентом',
        complete_till: (Time.now.end_of_day - 5.hour).to_i,

      }
      amo.task_create(param_task)

      render json: {code: 200}
    end

private

def find_user
  User.find(params[:id])
end

def user_params
  params.permit(:name)
end

end
end