# Flutter Web Deployment Troubleshooting Guide

## 🚨 Common Deployment Issues & Solutions

### 1. **GitHub Actions Build Failures**

#### Issue: "Flutter not found"
```
bash: flutter: command not found
```
**Solution:** Check the GitHub Actions workflow file (`.github/workflows/deploy.yml`):
- Ensure `flutter-version: 'stable'` is set
- Use `actions/checkout@v4` (latest version)

#### Issue: "pubspec.yaml not found"
```
Error: No pubspec.yaml file found
```
**Solution:** Ensure `pubspec.yaml` exists in the repository root with proper formatting.

#### Issue: "Dependencies resolution failed"
```
pub get failed
```
**Solution:** Check your `pubspec.yaml` dependencies versions and ensure they're compatible.

### 2. **API Backend Issues**

#### Issue: API returns 404 "Not Found"
```
{"message":"Not Found"}
```
**Possible Causes:**
- Lambda function not deployed
- API Gateway route not configured
- Wrong API URL

**Solution:**
1. Verify your Lambda function is deployed in AWS
2. Check API Gateway configuration
3. Test the API endpoint manually: `https://t18q1ugo32.execute-api.us-east-1.amazonaws.com/prod/questions?certId=aws_cp`

#### Issue: API returns 403 "Forbidden"
```
{"message":"Forbidden"}
```
**Possible Causes:**
- CORS not configured properly
- API key required but not provided
- Lambda execution permissions

**Solution:**
1. Configure CORS in API Gateway to allow web requests
2. Check if API requires authentication
3. Verify Lambda execution role permissions

#### Issue: Network timeout
```
TimeoutException after 30 seconds
```
**Solution:**
1. Check internet connectivity
2. Verify API endpoint is accessible
3. Check if there are firewall restrictions

### 3. **S3 Deployment Issues**

#### Issue: "Access Denied" during S3 sync
```
aws s3 sync access denied
```
**Solution:** Check GitHub Secrets:
- `AWS_ACCESS_KEY_ID` - must have S3 write permissions
- `AWS_SECRET_ACCESS_KEY` - corresponding secret key
- `AWS_REGION` - correct AWS region (e.g., `us-east-1`)
- `S3_BUCKET_NAME` - exact bucket name

#### Issue: "Bucket does not exist"
```
NoSuchBucket: The specified bucket does not exist
```
**Solution:**
1. Verify bucket name in GitHub Secrets
2. Ensure bucket exists in the correct AWS region
3. Check bucket permissions

### 4. **Website Not Loading**

#### Issue: "This site can't be reached"
**Solution:**
1. Check S3 bucket static website hosting is enabled
2. Verify bucket policy allows public read access
3. Check CloudFront distribution (if using)

#### Issue: App loads but shows errors
**Solution:**
1. Open browser developer tools (F12)
2. Check console for JavaScript errors
3. Use the Debug Dashboard in the app
4. Check network tab for failed API requests

### 5. **Performance Issues**

#### Issue: App loads slowly
**Solution:**
1. Enable gzip compression in S3/CloudFront
2. Use Flutter web `--release` build (already configured)
3. Consider using a CDN

## 🔧 Quick Diagnostics

### Check Build Status
Visit: `https://github.com/Pharaoh313/Cert-prep-app/actions`

### Test API Manually
```bash
curl -i "https://t18q1ugo32.execute-api.us-east-1.amazonaws.com/prod/questions?certId=aws_cp"
```

### Test Website
1. Visit your S3 website URL
2. Click "Debug Dashboard" on the home page
3. Run connectivity tests

## 🛠️ Emergency Recovery Steps

### If deployment completely fails:
1. Check GitHub Actions logs for specific error messages
2. Verify all GitHub Secrets are set correctly
3. Test API endpoint manually
4. Ensure S3 bucket exists and has correct permissions
5. Try manual deployment to isolate the issue

### If website is up but not working:
1. Use Debug Dashboard to test API connectivity
2. Check browser console for errors
3. Verify CORS configuration on the API
4. Test with different certId values

## 📋 Required GitHub Secrets

Ensure these are set in your repository settings:
- `AWS_ACCESS_KEY_ID` - AWS access key with S3 permissions
- `AWS_SECRET_ACCESS_KEY` - Corresponding secret key
- `AWS_REGION` - AWS region (e.g., us-east-1)
- `S3_BUCKET_NAME` - Name of your S3 bucket

## 🔍 Debugging Tools

### In the App:
- Use the Debug Dashboard (accessible from home screen)
- Check browser developer console
- Monitor network requests

### AWS Tools:
- CloudWatch logs for Lambda function
- API Gateway logs
- S3 access logs

## 📞 Getting Help

If you're still having issues:
1. Check the GitHub Actions logs for detailed error messages
2. Review AWS CloudWatch logs for backend issues
3. Use the Debug Dashboard to identify specific problems
4. Test individual components (API, S3, etc.) separately