const String authBaseUrl = 'https://prelive-oauth2.quran.foundation';

// 2. The API URL (Data Endpoints)
const String apiBaseUrl = 'https://apis-prelive.quran.foundation';

// 3. The specific endpoints
final String authorizationEndpoint = '$authBaseUrl/oauth/authorize';
final String tokenEndpoint = '$authBaseUrl/oauth2/token'; 
final String circleCreationEndpoint = 'https://qyyvgxrypolktxowctwu.supabase.co/functions/v1/createCircle';