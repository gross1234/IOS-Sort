# Twilio SMS Integration Setup Guide

## 🚀 Quick Setup

### 1. Get Twilio Credentials

1. **Sign up** at [twilio.com](https://www.twilio.com)
2. **Get your credentials** from the Twilio Console:
   - Account SID
   - Auth Token
   - Phone Number (for sending SMS)

### 2. Configure the App

#### Option A: Direct Configuration (Quick Setup)
Edit `IOS Sort/Services/TwilioConfig.swift`:

```swift
static let accountSID = "ACxxxxxxxxxxxxxxxxxxxxxxxxxxxxx" // Your Account SID
static let authToken = "your_auth_token_here"              // Your Auth Token
static let fromPhoneNumber = "+1234567890"                 // Your Twilio Phone Number
```

#### Option B: Environment Variables (Recommended for Production)
Set these environment variables in Xcode:

1. **Product → Scheme → Edit Scheme**
2. **Run → Arguments → Environment Variables**
3. **Add these variables:**
   - `TWILIO_ACCOUNT_SID` = `ACxxxxxxxxxxxxxxxxxxxxxxxxxxxxx`
   - `TWILIO_AUTH_TOKEN` = `your_auth_token_here`
   - `TWILIO_PHONE_NUMBER` = `+1234567890`

### 3. Test the Integration

1. **Build and run** the app
2. **Enter a real phone number** (your own for testing)
3. **Check your phone** for the SMS message
4. **Enter the OTP** to verify it works

## 📱 How It Works

### SMS Flow:
1. **User enters phone number** → Validates format
2. **App generates OTP** → Creates random 4-digit code
3. **Twilio sends SMS** → Real SMS to user's phone
4. **User enters OTP** → Validates against generated code
5. **Success** → Proceeds to next step

### Demo Mode:
- If Twilio isn't configured, app runs in **demo mode**
- OTP codes are printed to **console/Xcode logs**
- Use "Show OTP" button to see codes on screen

## 🔧 Troubleshooting

### Common Issues:

#### "Twilio not configured - using demo mode"
- **Solution**: Add your Twilio credentials to `TwilioConfig.swift`

#### "Invalid phone number format"
- **Solution**: Use format like `+1234567890` or `1234567890`

#### "Twilio API Error"
- **Check**: Account SID and Auth Token are correct
- **Check**: Phone number is verified in Twilio Console
- **Check**: Account has sufficient balance

#### SMS not received:
- **Check**: Phone number format is correct
- **Check**: Twilio account has SMS enabled
- **Check**: Phone number is verified (for trial accounts)

## 🛡️ Security Notes

### For Production:
1. **Use environment variables** instead of hardcoded credentials
2. **Implement server-side OTP generation** for better security
3. **Add rate limiting** to prevent abuse
4. **Use Twilio's webhook** for delivery status

### Current Implementation:
- ✅ **Client-side OTP generation** (good for demo)
- ✅ **Real SMS sending** via Twilio API
- ✅ **Phone number validation**
- ✅ **OTP expiration** (5 minutes)
- ✅ **Attempt limiting** (3 tries)

## 📊 Twilio Console

Monitor your SMS usage at:
- **Console**: [console.twilio.com](https://console.twilio.com)
- **Messages**: View sent SMS and delivery status
- **Phone Numbers**: Manage your Twilio phone numbers
- **Usage**: Track SMS costs and limits

## 💰 Pricing

- **Trial Account**: Free SMS to verified numbers
- **Paid Account**: ~$0.0075 per SMS (US)
- **Check**: [twilio.com/pricing](https://www.twilio.com/pricing) for current rates

## 🎯 Next Steps

1. **Configure Twilio** with your credentials
2. **Test with real phone number**
3. **Deploy to production** with environment variables
4. **Monitor usage** in Twilio Console
5. **Add server-side validation** for enhanced security

---

**Ready to test?** Configure your credentials and try sending a real SMS! 📱✨
