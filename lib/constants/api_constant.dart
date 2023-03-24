const protocol = "http";
const domain = "10.4.248.213:3000";
// const domain = "10.4.248.213:3000";
const wardrobeURLAPI = "$protocol://$domain/api/wardrobe";
const outfitURLAPI = "$protocol://$domain/api/outfit";
const componentURLAPI = "$protocol://$domain/api/component";
const postURLAPI = "$protocol://$domain/api/post";
const userURLAPI = "$protocol://$domain/api/user";
const likeURLAPI = "$protocol://$domain/api/like";
const savedPostURLAPI = "$protocol://$domain/api/saved_post";
const reportURLAPI = "$protocol://$domain/api/report";

Map<String, String> setHeaders() {
  return {
    'Content-Type':'application/json',
    'Accept':'application/json',
    // 'Authorization':'Bearer $token'
  };
}