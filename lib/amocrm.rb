class Amocrm

  def initialize
    # @agent = Mechanize.new
    # @domain = "https://naukacity.amocrm.ru"
    # @agent.post("#{@domain}/private/api/auth.php", {"USER_LOGIN" => "prisakar@naukacity.ru", "USER_HASH" => "c44498a3a4b169527d0411c36c35dc93"})

    @api_endpoint = "https://naukacity.amocrm.ru"
    @api_key = "c44498a3a4b169527d0411c36c35dc93"
    @usermail = "prisakar@naukacity.ru"
    @credentials = { USER_LOGIN: @usermail, USER_HASH: @api_key }
    @connect = Faraday.new(url: @api_endpoint) do |faraday|
      faraday.request :url_encoded
      faraday.response :json, :content_type => /\bjson$/
      faraday.response :xml,  :content_type => /\bxml$/
      faraday.adapter :net_http
    end
  end

  def authorize
    @connect.post('/private/api/auth.php', @credentials).body["root"]["auth"] == "true"
  end

  def get(url, params = {}, headers = {})
    response = @connect.get do |request|
      request.headers.merge!(headers)
      request.url url, params.merge(@credentials)
    end
    handle_response(response)
  end

  def post(url, params = {})
    response = @connect.post(url) do |request|
      request.headers['Content-Type'] = 'application/json'
      request.url url, @credentials
      request.body = params.to_json
    end
    handle_response(response)
  end
  # =================== >>>>>>>>>>>

  def account_info
    get("/private/api/v2/json/accounts/current").body["response"]["account"]
  end

  def contact_list
    get("/private/api/v2/json/contacts/list").body["response"]["contacts"]
  end

  def lead_list
    get("/private/api/v2/json/leads/list").body["response"]["leads"]
  end

  def contact_find_by_email(email)
    find_contact = nil
    contact_list.each do |cl|
      if cl["custom_fields"].present?
        cf_email = cl["custom_fields"].map{|cf| cf if cf["code"] == "EMAIL"}.compact.first
        (find_contact = cl if cf_email["values"].first["value"] == email) if cf_email.present?
      end
    end
    find_contact
  end

  def contact_find_by_id(id)
    contact_list.select{|cont| cont["id"] == id.to_i}.first
  end

  def contact_create(params)
    post("/private/api/v2/json/contacts/set", {request: {contacts: {add: [params] } } }).body["response"]["contacts"]
  end

  def contact_update(params)
    post("/private/api/v2/json/contacts/set", {request: 
      {contacts: {update: [
        params.merge({last_modified: Time.now.to_i})
        ] } } }).body["response"]["contacts"]
  end

  def lead_create(params)
    post("/private/api/v2/json/leads/set", {request: {leads: {add: [params] } } }).body["response"]["leads"]
  end

  def add_contact_to_lead(contact_id, lead_id)
    linked_leads_id = (contact_find_by_id(contact_id)["linked_leads_id"] + [lead_id]).uniq
    param = { id: contact_id, linked_leads_id: linked_leads_id}
    contact_update(param)
  end

  def task_create(params)
    post("/private/api/v2/json/tasks/set", {request: {tasks: {add: [params] } } }).body["response"]["tasks"]
  end

  private

  def handle_response(response) # rubocop:disable all
    if response.status == 200 || response.status == 204
      return response 
    else
      return response.status
    end
  end


end