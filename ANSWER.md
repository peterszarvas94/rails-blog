# SMTP Email Setup for Rails Blog

## Development Environment Setup

### Option 1: Letter Opener (Recommended for Development)

Add to your `Gemfile`:

```ruby
group :development do
  gem "letter_opener"
end
```

Then run:
```bash
bundle install
```

Add to `config/environments/development.rb` after line 41:

```ruby
# Email delivery in development
config.action_mailer.delivery_method = :letter_opener
config.action_mailer.perform_deliveries = true
```

This will open emails in your browser automatically when sent.

### Option 2: Real SMTP in Development

If you want to test with real emails in development, add to `config/environments/development.rb`:

```ruby
# Real email delivery in development
config.action_mailer.delivery_method = :smtp
config.action_mailer.perform_deliveries = true
config.action_mailer.raise_delivery_errors = true

config.action_mailer.smtp_settings = {
  user_name: Rails.application.credentials.dig(:smtp, :user_name),
  password: Rails.application.credentials.dig(:smtp, :password),
  address: "smtp.gmail.com",
  port: 587,
  authentication: :plain,
  enable_starttls_auto: true
}
```

## Production Environment Setup

### Step 1: Update Your Domain

Edit `config/environments/production.rb` line 61:

```ruby
# Replace example.com with your actual domain
config.action_mailer.default_url_options = { host: "yourdomain.com" }
```

### Step 2: Enable SMTP Configuration

Uncomment and modify lines 64-70 in `config/environments/production.rb`:

```ruby
# Enable email delivery errors
config.action_mailer.raise_delivery_errors = true
config.action_mailer.perform_deliveries = true
config.action_mailer.delivery_method = :smtp

# SMTP configuration
config.action_mailer.smtp_settings = {
  user_name: Rails.application.credentials.dig(:smtp, :user_name),
  password: Rails.application.credentials.dig(:smtp, :password),
  address: Rails.application.credentials.dig(:smtp, :address),
  port: Rails.application.credentials.dig(:smtp, :port),
  authentication: :plain,
  enable_starttls_auto: true
}
```

### Step 3: Add SMTP Credentials

Run this command to edit your encrypted credentials:

```bash
bin/rails credentials:edit
```

Add your SMTP settings:

```yaml
smtp:
  user_name: your_email@gmail.com
  password: your_app_password
  address: smtp.gmail.com
  port: 587
```

## Popular SMTP Providers

### 1. Gmail

**Setup:**
1. Enable 2-factor authentication on your Google account
2. Generate an App Password: Google Account → Security → App passwords
3. Use the app password (not your regular password)

**Credentials:**
```yaml
smtp:
  user_name: your_email@gmail.com
  password: your_16_character_app_password
  address: smtp.gmail.com
  port: 587
```

### 2. SendGrid

**Setup:**
1. Sign up at sendgrid.com
2. Create an API key in Settings → API Keys
3. Verify your sender identity

**Credentials:**
```yaml
smtp:
  user_name: apikey
  password: your_sendgrid_api_key
  address: smtp.sendgrid.net
  port: 587
```

### 3. Mailgun

**Setup:**
1. Sign up at mailgun.com
2. Add and verify your domain
3. Get SMTP credentials from your domain settings

**Credentials:**
```yaml
smtp:
  user_name: postmaster@your-domain.mailgun.org
  password: your_mailgun_smtp_password
  address: smtp.mailgun.org
  port: 587
```

### 4. AWS SES

**Setup:**
1. Set up AWS SES in your region
2. Verify your email/domain
3. Create SMTP credentials in SES console

**Credentials:**
```yaml
smtp:
  user_name: your_ses_smtp_username
  password: your_ses_smtp_password
  address: email-smtp.us-east-1.amazonaws.com  # Replace with your region
  port: 587
```

### 5. Postmark

**Setup:**
1. Sign up at postmarkapp.com
2. Add and verify your sender signature
3. Get SMTP credentials from your server

**Credentials:**
```yaml
smtp:
  user_name: your_postmark_server_token
  password: your_postmark_server_token
  address: smtp.postmarkapp.com
  port: 587
```

## Testing Your Setup

### 1. Test in Rails Console

```bash
bin/rails console
```

```ruby
# Create a test user if needed
user = User.first || User.create!(email_address: "test@example.com", password: "password123")

# Send a password reset email
PasswordsMailer.reset(user).deliver_now

# Check if it was sent
puts "Email sent successfully!"
```

### 2. Test via Web Interface

1. Start your application: `bin/dev`
2. Go to: `http://localhost:3000/passwords/new`
3. Enter an existing email address
4. Check your email or logs

### 3. Check Logs

Monitor your application logs for email delivery:

```bash
tail -f log/development.log
# or
tail -f log/production.log
```

## Troubleshooting

### Common Issues

**Authentication Failed:**
- Double-check username/password
- For Gmail, ensure you're using an App Password, not your regular password
- Verify 2FA is enabled for Gmail

**Connection Timeout:**
- Check if your server/hosting provider blocks SMTP ports
- Try port 465 with SSL instead of 587 with STARTTLS

**Emails Going to Spam:**
- Set up SPF, DKIM, and DMARC records for your domain
- Use a reputable SMTP provider
- Include proper from/reply-to addresses

### Debug Configuration

Add this to temporarily debug SMTP issues:

```ruby
# In your environment file
config.action_mailer.smtp_settings = {
  # ... your settings ...
  openssl_verify_mode: 'none'  # Only for debugging!
}
```

**Remove `openssl_verify_mode` in production!**

## Security Best Practices

1. **Never commit credentials** - Always use Rails credentials or environment variables
2. **Use App Passwords** - Don't use your main email password
3. **Enable 2FA** - On your email provider account
4. **Monitor usage** - Check for unusual email sending patterns
5. **Rotate credentials** - Regularly update your SMTP passwords

## Environment Variables Alternative

Instead of Rails credentials, you can use environment variables:

```ruby
config.action_mailer.smtp_settings = {
  user_name: ENV['SMTP_USERNAME'],
  password: ENV['SMTP_PASSWORD'],
  address: ENV['SMTP_ADDRESS'],
  port: ENV['SMTP_PORT'],
  authentication: :plain,
  enable_starttls_auto: true
}
```

Set these in your deployment environment or `.env` file (don't commit `.env`).

Your password reset emails will now be delivered via your chosen SMTP provider!