const String authBaseUrl = 'https://prelive-oauth2.quran.foundation';

// 2. The API URL (Data Endpoints)
const String apiBaseUrl = 'https://apis-prelive.quran.foundation';

// 3. The specific endpoints
final String authorizationEndpoint = '$authBaseUrl/oauth/authorize';
final String tokenEndpoint = '$authBaseUrl/oauth2/token'; 
final String circleCreationEndpoint = 'https://qyyvgxrypolktxowctwu.supabase.co/functions/v1/createCircle';
final String circleListEndpoint = 'https://qyyvgxrypolktxowctwu.supabase.co/functions/v1/getUserCircles';
final String joinCircleEndpoint = 'https://qyyvgxrypolktxowctwu.supabase.co/functions/v1/joinRoom';
final String homeDetailsEndpoint = '';
final String circleDetailsEndpoint = '';
final String logoutEndpoint = 'https://qyyvgxrypolktxowctwu.supabase.co/functions/v1/logout';