admin_email = ENV['YIP_HELPER_EMAIL'] || 'admin@example.com'
admin_password = ENV['YIP_HELPER_PASSWORD'] || 'password'
admin_name = ENV['YIP_HELPER_NAME'] || 'admin'
User.create(email: admin_email,
            password: admin_password,
            fullname: admin_name,
            role: 'admin')
