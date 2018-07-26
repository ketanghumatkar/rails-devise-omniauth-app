module OmniAuthStruct
  def auth_format(data)
    OmniAuthStruct.new(data).info
  end

  class OmniAuthStruct
    attr_accessor :standard_info, :data

    def initialize data
      @data = data
      @standard_info = common_auth_structure
    end

    def info
      standard_info[:provider] = data.provider
      standard_info[:uid] = data.uid
      standard_info[:info][:email] = auth_email
      standard_info
    end

    private
    def auth_email
      identifier_format = "http://schemas.xmlsoap.org/ws/2005/05/identity/claims/emailaddress"
      data["info"]["email"] || data["extra"]["raw_info"][identifier_format]
    end

    def common_auth_structure
      ActiveSupport::HashWithIndifferentAccess.new({
        provider: '',
        uid: '',
        info: {
          email: '',
          name: ''
        },
        credentials: {},
        extra: {}
      })
    end
  end
end